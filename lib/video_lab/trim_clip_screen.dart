import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const _kBg = Color(0xFF0F0F0F);
const _kAccent = Color(0xFFFF6B00);
const _kSurface = Color(0xFF1C1C1E);

class TrimResult {
  final int startMs;
  final int endMs;
  final int totalDurationMs;
  const TrimResult({required this.startMs, required this.endMs, required this.totalDurationMs});
}

/// Trim a freshly picked local video file (used when adding a new clip).
class TrimClipScreen extends StatefulWidget {
  final File file;
  const TrimClipScreen({super.key, required this.file});

  @override
  State<TrimClipScreen> createState() => _TrimClipScreenState();
}

class _TrimClipScreenState extends State<TrimClipScreen> {
  late VideoPlayerController _controller;
  bool _ready = false;
  String? _error;
  double _start = 0;
  double _end = 1;
  double _totalMs = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _totalMs = _controller.value.duration.inMilliseconds.toDouble();
        _end = _totalMs;
        _ready = true;
      });
    }).catchError((e) {
      if (mounted) setState(() => _error = e.toString());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kBg,
        foregroundColor: Colors.white,
        title: const Text('Trim clip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle, color: _kAccent),
            onPressed: _ready
                ? () => Navigator.pop(
                      context,
                      TrimResult(startMs: _start.round(), endMs: _end.round(), totalDurationMs: _totalMs.round()),
                    )
                : null,
          ),
        ],
      ),
      body: _error != null
          ? Center(child: Text('Failed to load video:\n$_error', style: const TextStyle(color: Colors.white70)))
          : _ready
              ? Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 44,
                      icon: Icon(
                        _controller.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        color: _kAccent,
                      ),
                      onPressed: () => setState(() {
                        _controller.value.isPlaying ? _controller.pause() : _controller.play();
                      }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: _kSurface,
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: _kAccent,
                              thumbColor: _kAccent,
                              inactiveTrackColor: Colors.white24,
                            ),
                            child: RangeSlider(
                              min: 0,
                              max: _totalMs == 0 ? 1 : _totalMs,
                              values: RangeValues(_start, _end),
                              onChanged: (v) => setState(() {
                                _start = v.start;
                                _end = v.end;
                              }),
                            ),
                          ),
                          Text(
                            '${(_start / 1000).toStringAsFixed(1)}s – ${(_end / 1000).toStringAsFixed(1)}s '
                            'of ${(_totalMs / 1000).toStringAsFixed(1)}s',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator(color: _kAccent)),
    );
  }
}

/// Re-trim a clip that's already been uploaded (streams from its signed URL).
class TrimExistingClipScreen extends StatefulWidget {
  final String videoUrl;
  final int durationMs;
  final int initialStartMs;
  final int initialEndMs;
  const TrimExistingClipScreen({
    super.key,
    required this.videoUrl,
    required this.durationMs,
    required this.initialStartMs,
    required this.initialEndMs,
  });

  @override
  State<TrimExistingClipScreen> createState() => _TrimExistingClipScreenState();
}

class _TrimExistingClipScreenState extends State<TrimExistingClipScreen> {
  late VideoPlayerController _controller;
  bool _ready = false;
  String? _error;
  late double _start;
  late double _end;

  @override
  void initState() {
    super.initState();
    _start = widget.initialStartMs.toDouble();
    _end = widget.initialEndMs.toDouble();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() => _ready = true);
    }).catchError((e) {
      if (mounted) setState(() => _error = e.toString());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalMs = widget.durationMs.toDouble();
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kBg,
        foregroundColor: Colors.white,
        title: const Text('Re-trim clip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle, color: _kAccent),
            onPressed: _ready
                ? () => Navigator.pop(context, TrimResult(startMs: _start.round(), endMs: _end.round(), totalDurationMs: widget.durationMs))
                : null,
          ),
        ],
      ),
      body: _error != null
          ? Center(child: Text('Failed to load video:\n$_error', style: const TextStyle(color: Colors.white70)))
          : _ready
              ? Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 44,
                      icon: Icon(
                        _controller.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        color: _kAccent,
                      ),
                      onPressed: () => setState(() {
                        _controller.value.isPlaying ? _controller.pause() : _controller.play();
                      }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: _kSurface,
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: _kAccent,
                              thumbColor: _kAccent,
                              inactiveTrackColor: Colors.white24,
                            ),
                            child: RangeSlider(
                              min: 0,
                              max: totalMs == 0 ? 1 : totalMs,
                              values: RangeValues(_start, _end),
                              onChanged: (v) => setState(() {
                                _start = v.start;
                                _end = v.end;
                              }),
                            ),
                          ),
                          Text(
                            '${(_start / 1000).toStringAsFixed(1)}s – ${(_end / 1000).toStringAsFixed(1)}s '
                            'of ${(totalMs / 1000).toStringAsFixed(1)}s',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator(color: _kAccent)),
    );
  }
}
