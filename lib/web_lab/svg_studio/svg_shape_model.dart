/// The kind of primitive an [SvgShape] represents. Path is the one type
/// whose geometry isn't visually rendered on the in-app canvas (see
/// [SvgShape] doc) — it still exports correct, valid SVG.
enum SvgShapeType { rectangle, circle, line, text, path }

/// A single shape on the SVG Studio canvas. Fields are a superset across
/// all shape types rather than a class hierarchy — simpler to serialize
/// and edit uniformly in the properties panel, at the cost of some
/// unused fields per type (documented per field below).
class SvgShape {
  final String id;
  final SvgShapeType type;

  /// Rect/text: top-left x. Circle: center x (cx). Line: x1.
  double x;

  /// Rect/text: top-left y. Circle: center y (cy). Line: y1.
  double y;

  /// Line only: second point.
  double x2;
  double y2;

  /// Rect only.
  double width;
  double height;

  /// Circle only.
  double radius;

  /// Text only.
  String textContent;
  double fontSize;

  /// Path only — raw SVG path data the student types themselves. Studio
  /// never generates this; it's the one place students practice real
  /// path syntax directly.
  String pathData;

  String fill;
  String stroke;
  double strokeWidth;
  double opacity;
  double rotationDegrees;

  SvgShape({
    required this.id,
    required this.type,
    this.x = 50,
    this.y = 50,
    this.x2 = 150,
    this.y2 = 150,
    this.width = 100,
    this.height = 60,
    this.radius = 40,
    this.textContent = 'Text',
    this.fontSize = 16,
    this.pathData = 'M10 10 L90 10 L50 90 Z',
    this.fill = '#3B82F6',
    this.stroke = '#1E3A8A',
    this.strokeWidth = 2,
    this.opacity = 1,
    this.rotationDegrees = 0,
  });

  /// Serializes this shape to its real SVG markup — the actual exported
  /// output, independent of what the in-app canvas is able to draw.
  String toSvgElement() {
    final transform = rotationDegrees == 0 ? '' : ' transform="rotate($rotationDegrees $_rotationCenterX $_rotationCenterY)"';
    final commonStyle = 'fill="$fill" stroke="$stroke" stroke-width="$strokeWidth" opacity="$opacity"';

    switch (type) {
      case SvgShapeType.rectangle:
        return '<rect x="$x" y="$y" width="$width" height="$height" $commonStyle$transform />';
      case SvgShapeType.circle:
        return '<circle cx="$x" cy="$y" r="$radius" $commonStyle$transform />';
      case SvgShapeType.line:
        return '<line x1="$x" y1="$y" x2="$x2" y2="$y2" stroke="$stroke" stroke-width="$strokeWidth" opacity="$opacity" />';
      case SvgShapeType.text:
        return '<text x="$x" y="$y" font-size="$fontSize" fill="$fill" opacity="$opacity"$transform>${_escapeXml(textContent)}</text>';
      case SvgShapeType.path:
        return '<path d="$pathData" $commonStyle$transform />';
    }
  }

  double get _rotationCenterX {
    switch (type) {
      case SvgShapeType.rectangle:
        return x + width / 2;
      case SvgShapeType.circle:
      case SvgShapeType.text:
        return x;
      case SvgShapeType.line:
        return (x + x2) / 2;
      case SvgShapeType.path:
        return 50;
    }
  }

  double get _rotationCenterY {
    switch (type) {
      case SvgShapeType.rectangle:
        return y + height / 2;
      case SvgShapeType.circle:
      case SvgShapeType.text:
        return y;
      case SvgShapeType.line:
        return (y + y2) / 2;
      case SvgShapeType.path:
        return 50;
    }
  }

  String _escapeXml(String input) {
    return input.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;');
  }

  String get displayName {
    switch (type) {
      case SvgShapeType.rectangle:
        return 'Rectangle';
      case SvgShapeType.circle:
        return 'Circle';
      case SvgShapeType.line:
        return 'Line';
      case SvgShapeType.text:
        return 'Text';
      case SvgShapeType.path:
        return 'Path';
    }
  }
}
