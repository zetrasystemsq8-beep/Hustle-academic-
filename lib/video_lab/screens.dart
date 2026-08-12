import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import 'clip_preview_screen.dart';
import 'filters.dart';
import 'models_and_state.dart';
import 'service.dart';
import 'stickers_data.dart';
import 'trim_clip_screen.dart';

const _kBg = Color(0xFF0F0F0F);
const _kAccent = Color(0xFFFF6B00);
const _kSurface = Color(0xFF1C1C1E);
const _kSurfaceLight = Color(0xFF2A2A2C);

class VideoEditorScreen extends ConsumerStatefulWidget {
  const VideoEditorScreen({super.key});
  @override
  ConsumerState<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends ConsumerState<VideoEditorScreen> {
  final _service = VideoLabService();
  final _recorder = AudioRecorder();
  bool _busy = false;
  bool _recording = false;
  int? _selectedIndex;
  VideoPlayerController? _previewController;
  final Map<String, String> _stickerImageUrls = {};

  @override
  void dispose() {
    _previewController?.dispose();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _selectClip(int index, TimelineClip clip) async {
    setState(() => _selectedIndex = index);
    final url = await _service.signedUrl('assets', clip.storagePath);
    final old = _previewController;
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await controller.initialize();
    await controller.seekTo(Duration(milliseconds: clip.sourceStartMs));
    if (!mounted) {
      controller.dispose();
      return;
    }
    setState(() => _previewController = controller);
    old?.dispose();
  }

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

    setState(() => _busy = true);
    try {
      final projectId = data.project!.id;
      final storagePath = 'source/${DateTime.now().millisecondsSinceEpoch}_${result.files.single.name}';

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
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add clip: $e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _reTrimSelected() async {
    final data = ref.read(videoLabProvider);
    if (_selectedIndex == null || _selectedIndex! >= data.clips.length) return;
    final clip = data.clips[_selectedIndex!];

    final url = await _service.signedUrl('assets', clip.storagePath);
    if (!mounted) return;

    final trim = await Navigator.push<TrimResult>(
      context,
      MaterialPageRoute(
        builder: (_) => TrimExistingClipScreen(
          videoUrl: url,
          durationMs: clip.durationMs,
          initialStartMs: clip.sourceStartMs,
          initialEndMs: clip.sourceEndMs,
        ),
      ),
    );
    if (trim == null) return;
    ref.read(videoLabProvider.notifier).trimClip(clip.id, trim.startMs, trim.endMs);
  }

  Future<void> _previewClipFullscreen(TimelineClip clip) async {
    final url = await _service.signedUrl('assets', clip.storagePath);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ClipPreviewScreen(videoUrl: url, startMs: clip.sourceStartMs, endMs: clip.sourceEndMs)),
    );
  }

  Future<void> _pickFilter() async {
    final data = ref.read(videoLabProvider);
    if (data.project == null) return;

    final chosen = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: _kSurface,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 12), child: Text('Filter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: kFilterPresets.length,
                  itemBuilder: (context, i) {
                    final preset = kFilterPresets[i];
                    final selected = data.project!.filterPreset == preset.id;
                    return GestureDetector(
                      onTap: () => Navigator.pop(context, preset.id),
                      child: Container(
                        width: 76,
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: selected ? _kAccent : Colors.transparent, width: 2)),
                              child: ColorFiltered(
                                colorFilter: preset.colorFilter,
                                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: _kSurfaceLight), child: const Icon(Icons.image, color: Colors.white38)),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(preset.label, style: TextStyle(color: selected ? _kAccent : Colors.white70, fontSize: 11)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (chosen == null) return;
    ref.read(videoLabProvider.notifier).setFilterPreset(chosen);
    await _service.updateFilterPreset(data.project!.id, chosen);
  }

  Future<void> _pickSticker() async {
    final data = ref.read(videoLabProvider);
    if (data.project == null) return;

    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: _kSurface,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Stickers & Emoji', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                itemCount: kBuiltinEmojis.length,
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () => Navigator.pop(context, 'emoji:${kBuiltinEmojis[i]}'),
                  child: Center(child: Text(kBuiltinEmojis[i], style: const TextStyle(fontSize: 28))),
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => Navigator.pop(context, 'upload'),
                icon: const Icon(Icons.upload, color: _kAccent),
                label: const Text('Upload custom sticker image', style: TextStyle(color: _kAccent)),
              ),
            ],
          ),
        ),
      ),
    );

    if (choice == null) return;

    if (choice.startsWith('emoji:')) {
      final emoji = choice.substring(6);
      ref.read(videoLabProvider.notifier).addSticker(StickerOverlay(id: const Uuid().v4(), kind: 'emoji', content: emoji));
      return;
    }

    if (choice == 'upload') {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result == null || result.files.single.path == null) return;
      setState(() => _busy = true);
      try {
        final file = File(result.files.single.path!);
        final storagePath = await _service.uploadStickerImage(projectId: data.project!.id, file: file, filename: result.files.single.name);
        ref.read(videoLabProvider.notifier).addSticker(StickerOverlay(id: const Uuid().v4(), kind: 'image', content: storagePath));
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload sticker: $e')));
      } finally {
        if (mounted) setState(() => _busy = false);
      }
    }
  }

  Future<String> _stickerImageUrl(StickerOverlay sticker) async {
    if (_stickerImageUrls.containsKey(sticker.id)) return _stickerImageUrls[sticker.id]!;
    final url = await _service.signedUrl('assets', sticker.content);
    _stickerImageUrls[sticker.id] = url;
    return url;
  }

  Future<void> _pickAudio() async {
    final data = ref.read(videoLabProvider);
    if (data.project == null) return;

    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: _kSurface,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add Audio', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.mic, color: _kAccent),
                title: const Text('Record voiceover', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context, 'voiceover'),
              ),
              ListTile(
                leading: const Icon(Icons.music_note, color: _kAccent),
                title: const Text('Add background music', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context, 'music'),
              ),
            ],
          ),
        ),
      ),
    );

    if (choice == 'music') {
      final result = await FilePicker.platform.pickFiles(type: FileType.audio);
      if (result == null || result.files.single.path == null) return;
      setState(() => _busy = true);
      try {
        final file = File(result.files.single.path!);
        final storagePath = await _service.uploadAudioFile(projectId: data.project!.id, file: file, filename: result.files.single.name);
        ref.read(videoLabProvider.notifier).addAudioTrack(AudioTrack(id: const Uuid().v4(), kind: 'music', storagePath: storagePath));
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add music: $e')));
      } finally {
        if (mounted) setState(() => _busy = false);
      }
      return;
    }

    if (choice == 'voiceover') {
      await _recordVoiceover();
    }
  }

  Future<void> _recordVoiceover() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Microphone permission is required to record a voiceover')));
      return;
    }

    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/voiceover_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(const RecordConfig(), path: path);
    setState(() => _recording = true);

    if (!mounted) return;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: _kSurface,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.fiber_manual_record, color: Colors.red),
            SizedBox(width: 10),
            Text('Recording…', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Stop', style: TextStyle(color: _kAccent)),
          ),
        ],
      ),
    );

    final recordedPath = await _recorder.stop();
    setState(() => _recording = false);
    if (recordedPath == null) return;

    final data = ref.read(videoLabProvider);
    if (data.project == null) return;

    setState(() => _busy = true);
    try {
      final file = File(recordedPath);
      final storagePath = await _service.uploadAudioFile(
        projectId: data.project!.id,
        file: file,
        filename: 'voiceover_${DateTime.now().millisecondsSinceEpoch}.m4a',
      );
      ref.read(videoLabProvider.notifier).addAudioTrack(AudioTrack(id: const Uuid().v4(), kind: 'voiceover', storagePath: storagePath));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save voiceover: $e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _bottomAction({required IconData icon, required String label, required VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: onTap == null ? Colors.white24 : Colors.white),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: onTap == null ? Colors.white24 : Colors.white70, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(videoLabProvider);
    final notifier = ref.read(videoLabProvider.notifier);
    final activeFilter = filterPresetFor(data.project?.filterPreset ?? 'none');

    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kBg,
        foregroundColor: Colors.white,
        title: Text(data.project?.title ?? 'Video Lab', overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle, color: _kAccent),
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
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                width: double.infinity,
                color: Colors.black,
                child: Stack(
                  children: [
                    Center(
                      child: _previewController != null && _previewController!.value.isInitialized
                          ? GestureDetector(
                              onTap: () => setState(() {
                                _previewController!.value.isPlaying ? _previewController!.pause() : _previewController!.play();
                              }),
                              child: ColorFiltered(
                                colorFilter: activeFilter.colorFilter,
                                child: AspectRatio(aspectRatio: _previewController!.value.aspectRatio, child: VideoPlayer(_previewController!)),
                              ),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.video_library_outlined, size: 56, color: Colors.white24),
                                const SizedBox(height: 12),
                                Text(data.clips.isEmpty ? 'No clips yet' : 'Tap a clip below to preview', style: const TextStyle(color: Colors.white54)),
                              ],
                            ),
                    ),
                    // Draggable sticker/emoji overlays
                    ...data.stickers.map((sticker) {
                      return Positioned(
                        left: sticker.posX * constraints.maxWidth - 24,
                        top: sticker.posY * constraints.maxHeight - 24,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            final newX = ((sticker.posX * constraints.maxWidth) + details.delta.dx) / constraints.maxWidth;
                            final newY = ((sticker.posY * constraints.maxHeight) + details.delta.dy) / constraints.maxHeight;
                            notifier.updateStickerPosition(sticker.id, newX.clamp(0.0, 1.0), newY.clamp(0.0, 1.0));
                          },
                          onLongPress: () => notifier.removeSticker(sticker.id),
                          child: sticker.kind == 'emoji'
                              ? Text(sticker.content, style: const TextStyle(fontSize: 40))
                              : FutureBuilder<String>(
                                  future: _stickerImageUrl(sticker),
                                  builder: (context, snapshot) => snapshot.hasData
                                      ? Image.network(snapshot.data!, width: 48, height: 48)
                                      : const SizedBox(width: 48, height: 48),
                                ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 92,
            color: _kSurface,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: data.clips.isEmpty
                ? Center(child: Text(_busy ? 'Working…' : 'Add your first clip below', style: const TextStyle(color: Colors.white38, fontSize: 12)))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: data.clips.length,
                    itemBuilder: (context, i) {
                      final clip = data.clips[i];
                      final selected = _selectedIndex == i;
                      final durationS = ((clip.sourceEndMs - clip.sourceStartMs) / 1000).toStringAsFixed(1);
                      return GestureDetector(
                        onTap: () => _selectClip(i, clip),
                        onLongPress: () => _previewClipFullscreen(clip),
                        child: Container(
                          width: 84,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(color: _kSurfaceLight, borderRadius: BorderRadius.circular(10), border: Border.all(color: selected ? _kAccent : Colors.transparent, width: 2)),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.movie, color: selected ? _kAccent : Colors.white54, size: 22),
                                    const SizedBox(height: 4),
                                    Text('${durationS}s', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    notifier.removeClip(clip.id);
                                    if (_selectedIndex == i) {
                                      setState(() {
                                        _selectedIndex = null;
                                        _previewController?.dispose();
                                        _previewController = null;
                                      });
                                    }
                                  },
                                  child: const Icon(Icons.close, size: 16, color: Colors.white38),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            color: _kSurface,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _bottomAction(icon: Icons.add_box_outlined, label: 'Add clip', onTap: _busy ? null : _addClip),
                  _bottomAction(icon: Icons.content_cut, label: 'Trim', onTap: _selectedIndex == null ? null : _reTrimSelected),
                  _bottomAction(icon: Icons.text_fields, label: 'Text', onTap: () => notifier.addOverlay(const TextOverlay(text: 'New text', startMs: 0, endMs: 2000))),
                  _bottomAction(
                    icon: Icons.compare_arrows,
                    label: 'Transition',
                    onTap: data.clips.length >= 2
                        ? () => notifier.addTransition(TransitionSpec(fromClipId: data.clips[data.clips.length - 2].id, toClipId: data.clips.last.id))
                        : null,
                  ),
                  _bottomAction(icon: Icons.filter_vintage, label: 'Filters', onTap: data.project == null ? null : _pickFilter),
                  _bottomAction(icon: Icons.emoji_emotions_outlined, label: 'Sticker', onTap: (_busy || data.project == null) ? null : _pickSticker),
                  _bottomAction(icon: Icons.mic_none, label: 'Audio', onTap: (_busy || data.project == null) ? null : _pickAudio),
                ],
              ),
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
  bool _exporting = false;

  Future<void> _export(String projectId) async {
    setState(() => _exporting = true);
    try {
      final jobId = await _service.startExport(projectId: projectId, destination: _destination);
      _service.watchJob(jobId).listen((job) {
        if (mounted) setState(() => _job = job);
      });
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export failed: $e')));
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(videoLabProvider);

    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(backgroundColor: _kBg, foregroundColor: Colors.white, title: const Text('Export')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(color: _kSurface, borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _destination = 'device'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(color: _destination == 'device' ? _kAccent : Colors.transparent, borderRadius: BorderRadius.circular(26)),
                        child: Text('Save to device', textAlign: TextAlign.center, style: TextStyle(color: _destination == 'device' ? Colors.white : Colors.white54)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _destination = 'nigergram'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(color: _destination == 'nigergram' ? _kAccent : Colors.transparent, borderRadius: BorderRadius.circular(26)),
                        child: Text('Post to Nigergram', textAlign: TextAlign.center, style: TextStyle(color: _destination == 'nigergram' ? Colors.white : Colors.white54)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: _kAccent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              onPressed: (data.project == null || _exporting) ? null : () => _export(data.project!.id),
              child: _exporting
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Export', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 24),
            if (_job != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(value: _job!.progressPct / 100, backgroundColor: _kSurface, color: _kAccent, minHeight: 8),
              ),
              const SizedBox(height: 8),
              Text('${_job!.status} — ${_job!.progressPct}%', style: const TextStyle(color: Colors.white70)),
              if (_job!.error != null) Text(_job!.error!, style: const TextStyle(color: Colors.redAccent)),
              if (_job!.status == 'done' && _job!.outputUrl != null) Text('Ready: ${_job!.outputUrl}', style: const TextStyle(color: Colors.greenAccent)),
            ],
          ],
        ),
      ),
    );
  }
}
