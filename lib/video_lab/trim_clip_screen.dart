import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrimResult {
  final int startMs;
  final int endMs;
  final int totalDurationMs;
  const TrimResult({required this.startMs, required this.endMs, required this.totalDurationMs});
}

class TrimClipScreen extends StatefulWidget {
  final File file;
  const TrimClipScreen({super.key, required this.file});

  @override
  State<TrimClipScreen> createState() => _TrimClipScreenState();
}

class _TrimClipScreenState extends State<TrimClipScreen> {
  late VideoPlayerController _controller;
  bool _ready = false;
  double _start = 0;
  double _end = 1;
  double _totalMs = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {
          _totalMs = _controller.value.duration.inMilliseconds.toDouble();
          _end = _totalMs;
          _ready = true;
        });
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
      appBar: AppBar(
        title: const Text('Trim clip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _ready
                ? () => Navigator.pop(
                      context,
                      TrimResult(startMs: _start.round(), endMs: _end.round(), totalDurationMs: _totalMs.round()),
                    )
                : null,
          ),
        ],
      ),
      body: _ready
          ? Column(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                IconButton(
                  icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying ? _controller.pause() : _controller.play();
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                ),
                const SizedBox(height: 16),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
