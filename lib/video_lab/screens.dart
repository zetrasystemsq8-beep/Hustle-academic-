import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'clip_preview_screen.dart';
import 'models_and_state.dart';
import 'service.dart';
import 'trim_clip_screen.dart';

class VideoEditorScreen extends ConsumerStatefulWidget {
  const VideoEditorScreen({super.key});
  @override
  ConsumerState<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends ConsumerState<VideoEditorScreen> {
  final _service = VideoLabService();
  bool _addingClip = false;

  Future<void> _addClip() async {
    final data = ref.read(videoLabProvider);
    if (data.project == null) return;

    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null || result.files.single.path == null) return;

    final file = File(result.files.single.path!);

    if (!mounted) return;
    final trim = await Navigator.push<TrimResult>(
      context,
      MaterialPageRoute(builder: (_) => TrimClipScreen(file: file)),
    );
    if (trim == null) return;

    setState(() => _addingClip = true);

    try {
      final projectId = data.project!.id;
      final storagePath =
          'source/${DateTime.now().millisecondsSinceEpoch}_${result.files.single.name}';

      final assetRow = await _service.uploadAndRegisterAsset(
        projectId: projectId,
        storagePath: storagePath,
        file: file,
        durationMs: trim.totalDurationMs,
      );

      final notifier = ref.read(videoLabProvider.notifier);
      final currentClipCount = ref.read(videoLabProvider).clips.length;

      notifier.addClip(TimelineClip(
        id: const Uuid().v4(),
        assetId: assetRow['id'],
        storagePath: storagePath,
        sourceStartMs: trim.startMs,
        sourceEndMs: trim.endMs,
        durationMs: trim.totalDurationMs,
        timelinePositionMs: currentClipCount * (trim.endMs - trim.startMs),
        sortOrder: currentClipCount,
      ));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add clip: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _addingClip = false);
    }
  }

  void _previewClip(TimelineClip clip) {
    final url = _service.publicUrl('assets', clip.storagePath);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClipPreviewScreen(videoUrl: url, startMs: clip.sourceStartMs, endMs: clip.sourceEndMs),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(videoLabProvider);
    final notifier = ref.read(videoLabProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.project?.title ?? 'Video Lab'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              await _service.saveTimeline(data);
              if (context.mounted) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PreviewExportScreen()));
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: data.clips.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.video_library_outlined, size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text('No clips yet', style: TextStyle(color: Colors.grey.shade600)),
                        const SizedBox(height: 4),
                        Text(
                          'Tap "Add clip" below to get started',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: data.clips.length,
                    itemBuilder: (context, i) {
                      final clip = data.clips[i];
                      return ListTile(
                        leading: const Icon(Icons.movie),
                        title: Text('Clip ${i + 1}'),
                        subtitle: Text(
                          '${(clip.sourceStartMs / 1000).toStringAsFixed(1)}s – '
                          '${(clip.sourceEndMs / 1000).toStringAsFixed(1)}s '
                          '(of ${(clip.durationMs / 1000).toStringAsFixed(1)}s)',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.play_circle_outline),
                              onPressed: () => _previewClip(clip),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => notifier.removeClip(clip.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: _addingClip ? null : _addClip,
                  icon: _addingClip
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.video_call),
                  label: const Text('Add clip'),
                ),
                TextButton.icon(
                  onPressed: () {
                    notifier.addOverlay(const TextOverlay(text: 'New text', startMs: 0, endMs: 2000));
                  },
                  icon: const Icon(Icons.text_fields),
                  label: const Text('Add text'),
                ),
                TextButton.icon(
                  onPressed: () {
                    if (data.clips.length >= 2) {
                      notifier.addTransition(TransitionSpec(
                        fromClipId: data.clips[data.clips.length - 2].id,
                        toClipId: data.clips.last.id,
                      ));
                    }
                  },
                  icon: const Icon(Icons.compare_arrows),
                  label: const Text('Add transition'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PreviewExportScreen extends ConsumerStatefulWidget {
  const PreviewExportScreen({super.key});
  @override
  ConsumerState<PreviewExportScreen> createState() => _PreviewExportScreenState();
}

class _PreviewExportScreenState extends ConsumerState<PreviewExportScreen> {
  final _service = VideoLabService();
  String _destination = 'device';
  RenderJob? _job;

  Future<void> _export(String projectId) async {
    final jobId = await _service.startExport(projectId: projectId, destination: _destination);
    _service.watchJob(jobId).listen((job) {
      setState(() => _job = job);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(videoLabProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Export')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'device', label: Text('Save to device')),
                ButtonSegment(value: 'nigergram', label: Text('Post to Nigergram')),
              ],
              selected: {_destination},
              onSelectionChanged: (s) => setState(() => _destination = s.first),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: data.project == null ? null : () => _export(data.project!.id),
              child: const Text('Export'),
            ),
            const SizedBox(height: 24),
            if (_job != null) ...[
              LinearProgressIndicator(value: _job!.progressPct / 100),
              const SizedBox(height: 8),
              Text('${_job!.status} — ${_job!.progressPct}%'),
              if (_job!.error != null) Text(_job!.error!, style: const TextStyle(color: Colors.red)),
              if (_job!.status == 'done' && _job!.outputUrl != null)
                Text('Ready: ${_job!.outputUrl}'),
            ],
          ],
        ),
      ),
    );
  }
}
