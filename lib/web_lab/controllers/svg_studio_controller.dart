import 'package:flutter/foundation.dart';
import '../svg_studio/svg_shape_model.dart';

/// Owns the full state of an SVG Studio canvas: every shape on it, which
/// one is selected, and the canvas's own viewBox size. Generates the
/// final, real SVG markup on demand — the source of truth for export
/// and "insert into project" always matches what's editable here.
class SvgStudioController extends ChangeNotifier {
  final List<SvgShape> _shapes = [];
  String? _selectedShapeId;
  int _nextId = 1;

  double canvasWidth = 300;
  double canvasHeight = 300;

  List<SvgShape> get shapes => List.unmodifiable(_shapes);
  String? get selectedShapeId => _selectedShapeId;

  SvgShape? get selectedShape {
    if (_selectedShapeId == null) return null;
    try {
      return _shapes.firstWhere((s) => s.id == _selectedShapeId);
    } catch (_) {
      return null;
    }
  }

  SvgShape addShape(SvgShapeType type) {
    final shape = SvgShape(id: 'shape_${_nextId++}', type: type);
    _shapes.add(shape);
    _selectedShapeId = shape.id;
    notifyListeners();
    return shape;
  }

  void selectShape(String? id) {
    _selectedShapeId = id;
    notifyListeners();
  }

  void removeShape(String id) {
    _shapes.removeWhere((s) => s.id == id);
    if (_selectedShapeId == id) _selectedShapeId = null;
    notifyListeners();
  }

  void bringForward(String id) {
    final index = _shapes.indexWhere((s) => s.id == id);
    if (index == -1 || index == _shapes.length - 1) return;
    final shape = _shapes.removeAt(index);
    _shapes.insert(index + 1, shape);
    notifyListeners();
  }

  void sendBackward(String id) {
    final index = _shapes.indexWhere((s) => s.id == id);
    if (index <= 0) return;
    final shape = _shapes.removeAt(index);
    _shapes.insert(index - 1, shape);
    notifyListeners();
  }

  /// Moves the selected shape by a drag delta, in canvas coordinates.
  void moveSelectedBy(double dx, double dy) {
    final shape = selectedShape;
    if (shape == null) return;
    shape.x += dx;
    shape.y += dy;
    if (shape.type == SvgShapeType.line) {
      shape.x2 += dx;
      shape.y2 += dy;
    }
    notifyListeners();
  }

  /// Applies an arbitrary field mutation to the selected shape, called
  /// from the properties panel after editing any single field.
  void updateSelected(void Function(SvgShape shape) mutate) {
    final shape = selectedShape;
    if (shape == null) return;
    mutate(shape);
    notifyListeners();
  }

  /// Assembles the full, real SVG document from every shape currently on
  /// the canvas — this exact string is what gets copied or saved.
  String generateSvgMarkup() {
    final buffer = StringBuffer();
    buffer.writeln('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 $canvasWidth $canvasHeight" width="$canvasWidth" height="$canvasHeight">');
    for (final shape in _shapes) {
      buffer.writeln('  ${shape.toSvgElement()}');
    }
    buffer.writeln('</svg>');
    return buffer.toString();
  }

  void clearAll() {
    _shapes.clear();
    _selectedShapeId = null;
    notifyListeners();
  }
}
