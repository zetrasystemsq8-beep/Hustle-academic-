import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ClipPreviewScreen extends StatefulWidget {
  final String videoUrl;
  final int startMs;
  final int endMs;
  const ClipPreviewScreen({super.key, required this.videoUrl, required this.startMs, required this.endMs});

  @override
  State<ClipPreviewScreen> createState() => _ClipPreviewScreenState();
}

class _ClipPreviewScreenState extends State<ClipPreviewScreen> {
  late VideoPlayerController _controller;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) async {
        await _controller.seekTo(Duration(milliseconds: widget.startMs));
        if (!mounted) return;
        setState(() => _ready = true);
        _controller.play();
        _controller.addListener(_stopAtEnd);
      });
  }

  void _stopAtEnd() {
    if (_controller.value.position.inMilliseconds >= widget.endMs && _controller.value.isPlaying) {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_stopAtEnd);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview clip')),
      body: Center(
        child: _ready
            ? AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller))
            : const CircularProgressIndicator(),
      ),
    );
  }
}
