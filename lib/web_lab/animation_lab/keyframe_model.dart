/// A CSS property Animation Lab can preview and generate keyframes for.
/// Deliberately a fixed set rather than free-text CSS — this is what
/// lets the in-app preview render exactly, accurately, with no parser.
enum AnimatableProperty {
  opacity,
  translateX,
  translateY,
  scale,
  rotate,
  backgroundColor,
  width,
  height,
}

extension AnimatablePropertyLabel on AnimatableProperty {
  String get label {
    switch (this) {
      case AnimatableProperty.opacity:
        return 'Opacity';
      case AnimatableProperty.translateX:
        return 'Translate X (px)';
      case AnimatableProperty.translateY:
        return 'Translate Y (px)';
      case AnimatableProperty.scale:
        return 'Scale';
      case AnimatableProperty.rotate:
        return 'Rotate (deg)';
      case AnimatableProperty.backgroundColor:
        return 'Background color';
      case AnimatableProperty.width:
        return 'Width (px)';
      case AnimatableProperty.height:
        return 'Height (px)';
    }
  }

  bool get isColor => this == AnimatableProperty.backgroundColor;
  bool get isTransform => this == AnimatableProperty.translateX ||
      this == AnimatableProperty.translateY ||
      this == AnimatableProperty.scale ||
      this == AnimatableProperty.rotate;

  String get defaultValue {
    switch (this) {
      case AnimatableProperty.opacity:
        return '1';
      case AnimatableProperty.scale:
        return '1';
      case AnimatableProperty.backgroundColor:
        return '#3B82F6';
      case AnimatableProperty.width:
      case AnimatableProperty.height:
        return '100';
      case AnimatableProperty.translateX:
      case AnimatableProperty.translateY:
      case AnimatableProperty.rotate:
        return '0';
    }
  }
}

/// A single keyframe stop — a percentage through the animation, plus the
/// value of every property currently in use at that point.
class KeyframeStep {
  double percent;
  Map<AnimatableProperty, String> values;

  KeyframeStep({required this.percent, Map<AnimatableProperty, String>? values})
      : values = values ?? {};
}
