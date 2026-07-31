import 'package:flutter/material.dart';
import '../animation_lab/keyframe_model.dart';
import '../controllers/animation_lab_controller.dart';
import '../utils/color_utils.dart';

/// Live preview box for Animation Lab. Reads interpolated values
/// directly from [AnimationLabController] every frame, so what's shown
/// here is always exactly what the generated CSS describes — for every
/// property this tool exposes (see the "known limitation" on fully
/// custom cubic-bezier easing in the controller's doc).
class AnimationPreviewWidget extends StatefulWidget {
  final AnimationLabController controller;

  const AnimationPreviewWidget({super.key, required this.controller});

  @override
  State<AnimationPreviewWidget> createState() => _AnimationPreviewWidgetState();
}

class _AnimationPreviewWidgetState extends State<AnimationPreviewWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.controller.durationMs));
    widget.controller.addListener(_handleControllerChanged);
  }

  void _handleControllerChanged() {
    if (_animationController.duration?.inMilliseconds != widget.controller.durationMs) {
      _animationController.duration = Duration(milliseconds: widget.controller.durationMs);
    }
    setState(() {});
  }

  Curve _curveFor(EasingPreset preset) {
    switch (preset) {
      case EasingPreset.linear:
        return Curves.linear;
      case EasingPreset.ease:
        return Curves.ease;
      case EasingPreset.easeIn:
        return Curves.easeIn;
      case EasingPreset.easeOut:
        return Curves.easeOut;
      case EasingPreset.easeInOut:
        return Curves.easeInOut;
      case EasingPreset.custom:
        // Approximated as linear — see class-level limitation note.
        return Curves.linear;
    }
  }

  void _togglePlay() {
    if (_isPlaying) {
      _animationController.stop();
      setState(() => _isPlaying = false);
      return;
    }

    setState(() => _isPlaying = true);
    final direction = widget.controller.direction;
    final shouldAlternate = direction == AnimationDirection.alternate || direction == AnimationDirection.alternateReverse;
    final reversedStart = direction == AnimationDirection.reverse || direction == AnimationDirection.alternateReverse;

    if (reversedStart) _animationController.value = 1.0;

    if (shouldAlternate) {
      _animationController.repeat(reverse: true);
    } else if (widget.controller.iterationCount == 'infinite') {
      reversedStart ? _animationController.repeat(min: 0, max: 1) : _animationController.repeat();
    } else {
      final count = int.tryParse(widget.controller.iterationCount) ?? 1;
      _playFixedCount(count, reversedStart);
    }
  }

  Future<void> _playFixedCount(int count, bool reversed) async {
    for (var i = 0; i < count; i++) {
      if (!_isPlaying) return;
      if (reversed) {
        await _animationController.reverse(from: 1.0);
      } else {
        await _animationController.forward(from: 0.0);
      }
    }
    if (mounted) setState(() => _isPlaying = false);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChanged);
    _animationController.dispose();
    super.dispose();
  }

  double _readNumeric(AnimatableProperty property, double t, double fallback) {
    if (!widget.controller.activeProperties.contains(property)) return fallback;
    return double.tryParse(widget.controller.valueAtProgress(property, t)) ?? fallback;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                final curved = _curveFor(widget.controller.easing).transform(_animationController.value);

                final opacity = _readNumeric(AnimatableProperty.opacity, curved, 1).clamp(0.0, 1.0);
                final translateX = _readNumeric(AnimatableProperty.translateX, curved, 0);
                final translateY = _readNumeric(AnimatableProperty.translateY, curved, 0);
                final scale = _readNumeric(AnimatableProperty.scale, curved, 1);
                final rotateDeg = _readNumeric(AnimatableProperty.rotate, curved, 0);
                final width = _readNumeric(AnimatableProperty.width, curved, 100);
                final height = _readNumeric(AnimatableProperty.height, curved, 100);

                final colorHex = widget.controller.activeProperties.contains(AnimatableProperty.backgroundColor)
                    ? widget.controller.valueAtProgress(AnimatableProperty.backgroundColor, curved)
                    : '#3B82F6';

                return Opacity(
                  opacity: opacity,
                  child: Transform.translate(
                    offset: Offset(translateX, translateY),
                    child: Transform.rotate(
                      angle: rotateDeg * 3.1415926535 / 180,
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            color: ColorUtils.parseHex(colorHex),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                label: Text(_isPlaying ? 'Stop' : 'Play'),
                onPressed: _togglePlay,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
