import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models_and_state.dart';
import 'service.dart';

class VideoEditorScreen extends StatefulWidget {
  const VideoEditorScreen({super.key});
  @override
  State<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen> {
  final _service = VideoLabService();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<VideoLabState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(state.project?.title ?? 'Video Lab'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              await _service.saveTimeline(state);
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
            child: ListView.builder(
              itemCount: state.clips.length,
              itemBuilder: (context, i) {
                final clip = state.clips[i];
                return ListTile(
                  leading: const Icon(Icons.movie),
                  title: Text('Clip ${i + 1}'),
                  subtitle: Text('${clip.sourceStartMs}ms – ${clip.sourceEndMs}ms'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => state.removeClip(clip.id),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  // hook up to a text input dialog in a real build
                  state.addOverlay(TextOverlay(text: 'New text', startMs: 0, endMs: 2000));
                },
                icon: const Icon(Icons.text_fields),
                label: const Text('Add text'),
              ),
              TextButton.icon(
                onPressed: () {
                  if (state.clips.length >= 2) {
                    state.addTransition(TransitionSpec(
                      fromClipId: state.clips[state.clips.length - 2].id,
                      toClipId: state.clips.last.id,
                    ));
                  }
                },
                icon: const Icon(Icons.compare_arrows),
                label: const Text('Add transition'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PreviewExportScreen extends StatefulWidget {
  const PreviewExportScreen({super.key});
  @override
  State<PreviewExportScreen> createState() => _PreviewExportScreenState();
}

class _PreviewExportScreenState extends State<PreviewExportScreen> {
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
    final state = context.watch<VideoLabState>();

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
              onPressed: state.project == null ? null : () => _export(state.project!.id),
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
