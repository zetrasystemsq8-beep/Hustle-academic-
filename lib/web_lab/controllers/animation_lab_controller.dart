import 'package:flutter/foundation.dart';
import '../animation_lab/keyframe_model.dart';

/// Preset easing curves offered in the UI. "Custom" accepts a raw
/// cubic-bezier() string for the generated CSS, but the in-app preview
/// approximates any custom curve linearly — see [AnimationLabController]
/// doc for why.
enum EasingPreset { linear, ease, easeIn, easeOut, easeInOut, custom }

extension EasingPresetCss on EasingPreset {
  String cssValue(String customValue) {
    switch (this) {
      case EasingPreset.linear:
        return 'linear';
      case EasingPreset.ease:
        return 'ease';
      case EasingPreset.easeIn:
        return 'ease-in';
      case EasingPreset.easeOut:
        return 'ease-out';
      case EasingPreset.easeInOut:
        return 'ease-in-out';
      case EasingPreset.custom:
        return customValue.trim().isEmpty ? 'ease' : customValue.trim();
    }
  }
}

enum AnimationDirection { normal, reverse, alternate, alternateReverse }

extension AnimationDirectionCss on AnimationDirection {
  String get cssValue {
    switch (this) {
      case AnimationDirection.normal:
        return 'normal';
      case AnimationDirection.reverse:
        return 'reverse';
      case AnimationDirection.alternate:
        return 'alternate';
      case AnimationDirection.alternateReverse:
        return 'alternate-reverse';
    }
  }
}

/// Owns the full state of an Animation Lab session: the keyframe steps,
/// timing configuration, and CSS generation. The in-app preview
/// interpolates directly from this same state, so what students see
/// previewed and what gets generated as CSS are always in sync.
class AnimationLabController extends ChangeNotifier {
  String animationName = 'myAnimation';
  int durationMs = 1000;
  EasingPreset easing = EasingPreset.easeInOut;
  String customEasingValue = '';
  String iterationCount = '1';
  AnimationDirection direction = AnimationDirection.normal;

  final List<KeyframeStep> _steps = [
    KeyframeStep(percent: 0, values: {AnimatableProperty.opacity: '0'}),
    KeyframeStep(percent: 100, values: {AnimatableProperty.opacity: '1'}),
  ];

  List<KeyframeStep> get steps {
    final sorted = List<KeyframeStep>.from(_steps)..sort((a, b) => a.percent.compareTo(b.percent));
    return List.unmodifiable(sorted);
  }

  /// Every property currently in use by at least one step — used to
  /// decide which sliders/fields the preview and timeline need to show.
  Set<AnimatableProperty> get activeProperties {
    final set = <AnimatableProperty>{};
    for (final step in _steps) {
      set.addAll(step.values.keys);
    }
    return set;
  }

  void setAnimationName(String value) {
    animationName = value;
    notifyListeners();
  }

  void setDuration(int ms) {
    durationMs = ms;
    notifyListeners();
  }

  void setEasing(EasingPreset preset) {
    easing = preset;
    notifyListeners();
  }

  void setCustomEasing(String value) {
    customEasingValue = value;
    notifyListeners();
  }

  void setIterationCount(String value) {
    iterationCount = value;
    notifyListeners();
  }

  void setDirection(AnimationDirection value) {
    direction = value;
    notifyListeners();
  }

  /// Adds a new step at [percent]. Every property already in use by any
  /// existing step is carried forward with its most recent value, so a
  /// student adding a new stop never has to redefine every property from
  /// scratch — this also keeps the preview's interpolation well-defined,
  /// since every active property has a value at every step.
  void addStep(double percent) {
    final carriedValues = <AnimatableProperty, String>{};
    for (final property in activeProperties) {
      carriedValues[property] = _valueAt(percent, property);
    }
    _steps.add(KeyframeStep(percent: percent, values: carriedValues));
    notifyListeners();
  }

  void removeStep(KeyframeStep step) {
    if (_steps.length <= 2) return;
    _steps.remove(step);
    notifyListeners();
  }

  void updatePercent(KeyframeStep step, double percent) {
    step.percent = percent.clamp(0, 100);
    notifyListeners();
  }

  /// Adds [property] to every existing step (using its default value),
  /// so the property is well-defined across the whole timeline the
  /// moment it's introduced.
  void addPropertyToAllSteps(AnimatableProperty property) {
    for (final step in _steps) {
      step.values.putIfAbsent(property, () => property.defaultValue);
    }
    notifyListeners();
  }

  void removePropertyFromAllSteps(AnimatableProperty property) {
    for (final step in _steps) {
      step.values.remove(property);
    }
    notifyListeners();
  }

  void updateStepValue(KeyframeStep step, AnimatableProperty property, String value) {
    step.values[property] = value;
    notifyListeners();
  }

  /// Linearly interpolates a numeric property's value at an arbitrary
  /// [percent] from the surrounding defined steps — used both to carry
  /// values into a newly added step and by the live preview.
  String _valueAt(double percent, AnimatableProperty property) {
    final sortedSteps = steps.where((s) => s.values.containsKey(property)).toList();
    if (sortedSteps.isEmpty) return property.defaultValue;
    if (sortedSteps.length == 1) return sortedSteps.first.values[property]!;

    KeyframeStep before = sortedSteps.first;
    KeyframeStep after = sortedSteps.last;
    for (var i = 0; i < sortedSteps.length - 1; i++) {
      if (sortedSteps[i].percent <= percent && sortedSteps[i + 1].percent >= percent) {
        before = sortedSteps[i];
        after = sortedSteps[i + 1];
        break;
      }
    }

    if (property.isColor) {
      return before.values[property]!;
    }

    final beforeValue = double.tryParse(before.values[property] ?? '') ?? 0;
    final afterValue = double.tryParse(after.values[property] ?? '') ?? 0;
    final span = after.percent - before.percent;
    final t = span == 0 ? 0.0 : (percent - before.percent) / span;
    final interpolated = beforeValue + (afterValue - beforeValue) * t;
    return interpolated.toStringAsFixed(2);
  }

  /// Returns the interpolated value of [property] at animation progress
  /// [t] (0.0–1.0), used directly by the live preview widget every frame.
  String valueAtProgress(AnimatableProperty property, double t) {
    return _valueAt(t * 100, property);
  }

  /// Assembles the full, real CSS — a `@keyframes` block plus a ready-to-
  /// use class applying it — exactly matching what the preview shows.
  String generateCss() {
    final buffer = StringBuffer();
    buffer.writeln('@keyframes $animationName {');

    for (final step in steps) {
      buffer.writeln('  ${step.percent.toStringAsFixed(0)}% {');

      final transformParts = <String>[];
      for (final property in step.values.keys) {
        final value = step.values[property]!;
        switch (property) {
          case AnimatableProperty.opacity:
            buffer.writeln('    opacity: $value;');
            break;
          case AnimatableProperty.backgroundColor:
            buffer.writeln('    background-color: $value;');
            break;
          case AnimatableProperty.width:
            buffer.writeln('    width: ${value}px;');
            break;
          case AnimatableProperty.height:
            buffer.writeln('    height: ${value}px;');
            break;
          case AnimatableProperty.translateX:
            transformParts.add('translateX(${value}px)');
            break;
          case AnimatableProperty.translateY:
            transformParts.add('translateY(${value}px)');
            break;
          case AnimatableProperty.scale:
            transformParts.add('scale($value)');
            break;
          case AnimatableProperty.rotate:
            transformParts.add('rotate(${value}deg)');
            break;
        }
      }
      if (transformParts.isNotEmpty) {
        buffer.writeln('    transform: ${transformParts.join(' ')};');
      }

      buffer.writeln('  }');
    }
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln('.your-element {');
    buffer.writeln('  animation-name: $animationName;');
    buffer.writeln('  animation-duration: ${durationMs}ms;');
    buffer.writeln('  animation-timing-function: ${easing.cssValue(customEasingValue)};');
    buffer.writeln('  animation-iteration-count: $iterationCount;');
    buffer.writeln('  animation-direction: ${direction.cssValue};');
    buffer.writeln('}');

    return buffer.toString();
  }
}
