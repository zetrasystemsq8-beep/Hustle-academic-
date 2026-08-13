import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const _kBg = Color(0xFF0F0F0F);
const _kAccent = Color(0xFFFF6B00);
const _kSurface = Color(0xFF1C1C1E);

class TransformResult {
  final int rotationDeg;
  final double scale;
  final double speed;
  const TransformResult({required this.rotationDeg, required this.scale, required this.speed});
}

class TransformClipScreen extends StatefulWidget {
  final String videoUrl;
  final int initialRotationDeg;
  final double initialScale;
  final double initialSpeed;

  const TransformClipScreen({
    super.key,
    required this.videoUrl,
    this.initialRotationDeg = 0,
    this.initialScale = 1.0,
    this.initialSpeed = 1.0,
  });

  @override
  State<TransformClipScreen> createState() => _TransformClipScreenState();
}

class _TransformClipScreenState extends State<TransformClipScreen> {
  late VideoPlayerController _controller;
  bool _ready = false;
  String? _error;
  late int _rotation;
  late double _scale;
  late double _speed;

  @override
  void initState() {
    super.initState();
    _rotation = widget.initialRotationDeg;
    _scale = widget.initialScale;
    _speed = widget.initialSpeed;
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _controller.initialize().then((_) {
      if (!mounted) return;
      _controller.setPlaybackSpeed(_speed);
      _controller.setLooping(true);
      _controller.play();
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

  void _rotateBy90() {
    setState(() => _rotation = (_rotation + 90) % 360);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kBg,
        foregroundColor: Colors.white,
        title: const Text('Transform clip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle, color: _kAccent),
            onPressed: _ready
                ? () => Navigator.pop(context, TransformResult(rotationDeg: _rotation, scale: _scale, speed: _speed))
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
                        child: Transform.rotate(
                          angle: _rotation * 3.14159265 / 180,
                          child: Transform.scale(
                            scale: _scale,
                            child: AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: _kSurface,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Rotate', style: TextStyle(color: Colors.white70)),
                              IconButton(icon: const Icon(Icons.rotate_right, color: _kAccent), onPressed: _rotateBy90),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 60, child: Text('Scale', style: TextStyle(color: Colors.white70))),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(activeTrackColor: _kAccent, thumbColor: _kAccent, inactiveTrackColor: Colors.white24),
                                  child: Slider(
                                    min: 0.5,
                                    max: 2.0,
                                    value: _scale,
                                    onChanged: (v) => setState(() => _scale = v),
                                  ),
                                ),
                              ),
                              SizedBox(width: 40, child: Text('${_scale.toStringAsFixed(1)}x', style: const TextStyle(color: Colors.white70))),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 60, child: Text('Speed', style: TextStyle(color: Colors.white70))),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(activeTrackColor: _kAccent, thumbColor: _kAccent, inactiveTrackColor: Colors.white24),
                                  child: Slider(
                                    min: 0.5,
                                    max: 2.0,
                                    value: _speed,
                                    onChanged: (v) {
                                      setState(() => _speed = v);
                                      _controller.setPlaybackSpeed(v);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 40, child: Text('${_speed.toStringAsFixed(1)}x', style: const TextStyle(color: Colors.white70))),
                            ],
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
