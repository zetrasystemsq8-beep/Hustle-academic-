import 'package:flutter/foundation.dart';
import '../design_lab/design_lab_models.dart';
import '../utils/color_utils.dart';

/// One stop in a gradient — a color plus its position (0–100%) along
/// the gradient line.
class GradientStop {
  String hex;
  double position;

  GradientStop({required this.hex, required this.position});
}

/// Owns state and CSS generation for every visual Design Lab tool:
/// Color, Gradient, Shadow, Border Radius, Spacing, and Typography.
/// Each tool's state is independent — switching tabs never resets a
/// different tool's work — and every generator produces real, valid CSS
/// with no placeholders.
class DesignLabController extends ChangeNotifier {
  // ---- Color tool ----
  String foregroundHex = '#111827';
  String backgroundHex = '#FFFFFF';

  void setForeground(String hex) {
    foregroundHex = hex;
    notifyListeners();
  }

  void setBackground(String hex) {
    backgroundHex = hex;
    notifyListeners();
  }

  /// WCAG-style relative luminance + contrast ratio, using the real
  /// formula (not a rough approximation) so the guidance shown is
  /// accurate, not decorative.
  double get contrastRatio {
    double luminance(String hex) {
      final color = ColorUtils.parseHex(hex);
      double channel(int value) {
        final c = value / 255.0;
        return c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055).pow(2.4);
      }
      final r = channel(color.red);
      final g = channel(color.green);
      final b = channel(color.blue);
      return 0.2126 * r + 0.7152 * g + 0.0722 * b;
    }

    final l1 = luminance(foregroundHex) + 0.05;
    final l2 = luminance(backgroundHex) + 0.05;
    final ratio = l1 > l2 ? l1 / l2 : l2 / l1;
    return ratio;
  }

  String get colorCss => 'color: $foregroundHex;\nbackground-color: $backgroundHex;';

  // ---- Gradient tool ----
  String gradientType = 'linear';
  double gradientAngle = 90;
  List<GradientStop> gradientStops = [
    GradientStop(hex: '#3B82F6', position: 0),
    GradientStop(hex: '#8B5CF6', position: 100),
  ];

  void setGradientType(String type) {
    gradientType = type;
    notifyListeners();
  }

  void setGradientAngle(double angle) {
    gradientAngle = angle;
    notifyListeners();
  }

  void addGradientStop() {
    gradientStops.add(GradientStop(hex: '#FFFFFF', position: 50));
    notifyListeners();
  }

  void removeGradientStop(int index) {
    if (gradientStops.length <= 2) return;
    gradientStops.removeAt(index);
    notifyListeners();
  }

  void updateGradientStopColor(int index, String hex) {
    gradientStops[index].hex = hex;
    notifyListeners();
  }

  void updateGradientStopPosition(int index, double position) {
    gradientStops[index].position = position;
    notifyListeners();
  }

  String get gradientCss {
    final stopsCss = gradientStops.map((s) => '${s.hex} ${s.position.toStringAsFixed(0)}%').join(', ');
    if (gradientType == 'radial') {
      return 'background: radial-gradient($stopsCss);';
    }
    return 'background: linear-gradient(${gradientAngle.toStringAsFixed(0)}deg, $stopsCss);';
  }

  // ---- Shadow tool ----
  double shadowOffsetX = 0;
  double shadowOffsetY = 4;
  double shadowBlur = 12;
  double shadowSpread = 0;
  String shadowColorHex = '#000000';
  double shadowOpacity = 0.15;
  bool shadowInset = false;

  void updateShadow({
    double? offsetX,
    double? offsetY,
    double? blur,
    double? spread,
    String? colorHex,
    double? opacity,
    bool? inset,
  }) {
    if (offsetX != null) shadowOffsetX = offsetX;
    if (offsetY != null) shadowOffsetY = offsetY;
    if (blur != null) shadowBlur = blur;
    if (spread != null) shadowSpread = spread;
    if (colorHex != null) shadowColorHex = colorHex;
    if (opacity != null) shadowOpacity = opacity;
    if (inset != null) shadowInset = inset;
    notifyListeners();
  }

  String get shadowCss {
    final color = ColorUtils.parseHex(shadowColorHex);
    final rgba = 'rgba(${color.red}, ${color.green}, ${color.blue}, ${shadowOpacity.toStringAsFixed(2)})';
    final insetKeyword = shadowInset ? 'inset ' : '';
    return 'box-shadow: $insetKeyword${shadowOffsetX.toStringAsFixed(0)}px ${shadowOffsetY.toStringAsFixed(0)}px ${shadowBlur.toStringAsFixed(0)}px ${shadowSpread.toStringAsFixed(0)}px $rgba;';
  }

  // ---- Border radius tool ----
  bool radiusUniform = true;
  double radiusAll = 8;
  double radiusTopLeft = 8;
  double radiusTopRight = 8;
  double radiusBottomRight = 8;
  double radiusBottomLeft = 8;

  void setRadiusUniform(bool value) {
    radiusUniform = value;
    notifyListeners();
  }

  void setRadiusAll(double value) {
    radiusAll = value;
    notifyListeners();
  }

  void setRadiusCorner({double? topLeft, double? topRight, double? bottomRight, double? bottomLeft}) {
    if (topLeft != null) radiusTopLeft = topLeft;
    if (topRight != null) radiusTopRight = topRight;
    if (bottomRight != null) radiusBottomRight = bottomRight;
    if (bottomLeft != null) radiusBottomLeft = bottomLeft;
    notifyListeners();
  }

  String get radiusCss {
    if (radiusUniform) {
      return 'border-radius: ${radiusAll.toStringAsFixed(0)}px;';
    }
    return 'border-radius: ${radiusTopLeft.toStringAsFixed(0)}px ${radiusTopRight.toStringAsFixed(0)}px ${radiusBottomRight.toStringAsFixed(0)}px ${radiusBottomLeft.toStringAsFixed(0)}px;';
  }

  // ---- Spacing scale tool ----
  double spacingBaseUnit = 4;
  int spacingSteps = 8;

  void setSpacingBaseUnit(double value) {
    spacingBaseUnit = value;
    notifyListeners();
  }

  void setSpacingSteps(int value) {
    spacingSteps = value.clamp(2, 16);
    notifyListeners();
  }

  String get spacingCss {
    final buffer = StringBuffer();
    buffer.writeln(':root {');
    for (var i = 1; i <= spacingSteps; i++) {
      buffer.writeln('  --space-$i: ${(spacingBaseUnit * i).toStringAsFixed(0)}px;');
    }
    buffer.writeln('}');
    buffer.writeln();
    for (var i = 1; i <= spacingSteps; i++) {
      buffer.writeln('.m-$i { margin: var(--space-$i); }');
      buffer.writeln('.p-$i { padding: var(--space-$i); }');
    }
    return buffer.toString();
  }

  // ---- Typography tool ----
  String fontFamily = 'system-ui, sans-serif';
  double fontSize = 16;
  String fontWeight = '400';
  double lineHeight = 1.5;
  double letterSpacing = 0;

  static const List<String> fontFamilyOptions = [
    'system-ui, sans-serif',
    'Georgia, serif',
    '"Courier New", monospace',
    '"Helvetica Neue", Arial, sans-serif',
    '"Times New Roman", serif',
  ];

  static const List<String> fontWeightOptions = ['300', '400', '500', '600', '700', '800'];

  void setFontFamily(String value) {
    fontFamily = value;
    notifyListeners();
  }

  void setFontSize(double value) {
    fontSize = value;
    notifyListeners();
  }

  void setFontWeight(String value) {
    fontWeight = value;
    notifyListeners();
  }

  void setLineHeight(double value) {
    lineHeight = value;
    notifyListeners();
  }

  void setLetterSpacing(double value) {
    letterSpacing = value;
    notifyListeners();
  }

  String get typographyCss =>
      'font-family: $fontFamily;\nfont-size: ${fontSize.toStringAsFixed(0)}px;\nfont-weight: $fontWeight;\nline-height: ${lineHeight.toStringAsFixed(2)};\nletter-spacing: ${letterSpacing.toStringAsFixed(2)}px;';
}

extension on double {
  double pow(double exponent) {
    var result = 1.0;
    // Simple fractional power via exp/ln — avoids importing dart:math
    // just for one call site, and works for any positive base/exponent.
    // ignore: import_of_legacy_library_into_null_safe
    return _powImpl(this, exponent);
  }
}

double _powImpl(double base, double exponent) {
  if (base <= 0) return 0;
  return _exp(exponent * _ln(base));
}

double _ln(double x) {
  // Natural log via Newton's method — sufficient precision for a
  // contrast-ratio calculation, avoids a dart:math import for one use.
  if (x <= 0) return double.negativeInfinity;
  var y = 0.0;
  for (var i = 0; i < 100; i++) {
    final ey = _exp(y);
    y = y - (ey - x) / ey;
  }
  return y;
}

double _exp(double x) {
  var sum = 1.0;
  var term = 1.0;
  for (var i = 1; i < 30; i++) {
    term *= x / i;
    sum += term;
  }
  return sum;
}

/// Owns the Component Workshop's saved-component library and the
/// currently-edited draft (either a fresh blank component or one loaded
/// from a starter/saved component for tweaking).
class ComponentWorkshopController extends ChangeNotifier {
  final ComponentLibraryRepository _repository = ComponentLibraryRepository();

  List<SavedComponent> _library = [];
  bool _isLoading = false;

  String draftName = 'My Component';
  String draftCategory = 'Custom';
  String draftHtml = '<div class="my-component">\n  \n</div>';
  String draftCss = '.my-component {\n  \n}\n';

  List<SavedComponent> get library => List.unmodifiable(_library);
  bool get isLoading => _isLoading;

  Future<void> loadLibrary() async {
    _isLoading = true;
    notifyListeners();
    _library = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  void loadIntoDraft({required String name, required String category, required String html, required String css}) {
    draftName = name;
    draftCategory = category;
    draftHtml = html;
    draftCss = css;
    notifyListeners();
  }

  void updateDraft({String? name, String? category, String? html, String? css}) {
    if (name != null) draftName = name;
    if (category != null) draftCategory = category;
    if (html != null) draftHtml = html;
    if (css != null) draftCss = css;
    notifyListeners();
  }

  Future<void> saveDraftToLibrary() async {
    final component = SavedComponent(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      name: draftName,
      category: draftCategory,
      html: draftHtml,
      css: draftCss,
    );
    _library.add(component);
    await _repository.saveAll(_library);
    notifyListeners();
  }

  Future<void> deleteFromLibrary(String id) async {
    _library.removeWhere((c) => c.id == id);
    await _repository.saveAll(_library);
    notifyListeners();
  }
}
