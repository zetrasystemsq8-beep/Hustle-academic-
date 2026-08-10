import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const _kBg = Color(0xFF0F0F0F);
const _kAccent = Color(0xFFFF6B00);

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
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _controller.initialize().then((_) async {
      if (!mounted) return;
      await _controller.seekTo(Duration(milliseconds: widget.startMs));
      setState(() => _ready = true);
      _controller.play();
      _controller.addListener(_stopAtEnd);
    }).catchError((e) {
      if (mounted) setState(() => _error = e.toString());
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
      backgroundColor: _kBg,
      appBar: AppBar(backgroundColor: _kBg, foregroundColor: Colors.white, title: const Text('Preview clip')),
      body: Center(
        child: _error != null
            ? Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Failed to load video:\n$_error', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
              )
            : _ready
                ? AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller))
                : const CircularProgressIndicator(color: _kAccent),
      ),
    );
  }
}
