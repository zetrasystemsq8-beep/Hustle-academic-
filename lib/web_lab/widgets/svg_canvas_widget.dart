import 'package:flutter/material.dart';
import '../controllers/svg_studio_controller.dart';
import '../svg_studio/svg_shape_model.dart';
import '../utils/color_utils.dart';

/// Renders the live SVG Studio canvas by drawing each [SvgShape]
/// directly via [CustomPainter] — rectangles, circles, lines, and text
/// render accurately. Path shapes are shown as a labeled placeholder box
/// rather than their real geometry, since rendering arbitrary SVG path
/// data would require a full path-data parser this canvas doesn't have;
/// the exported/inserted SVG markup for a path is still fully correct.
class SvgCanvasWidget extends StatelessWidget {
  final SvgStudioController controller;

  const SvgCanvasWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return GestureDetector(
          onTapUp: (details) => _handleTap(details.localPosition),
          onPanUpdate: (details) => controller.moveSelectedBy(details.delta.dx, details.delta.dy),
          child: Container(
            color: Colors.white,
            width: controller.canvasWidth,
            height: controller.canvasHeight,
            child: CustomPaint(
              painter: _SvgCanvasPainter(
                shapes: controller.shapes,
                selectedId: controller.selectedShapeId,
              ),
              size: Size(controller.canvasWidth, controller.canvasHeight),
            ),
          ),
        );
      },
    );
  }

  void _handleTap(Offset position) {
    // Hit-test from topmost shape down, so overlapping shapes select the
    // one visually on top, matching what the student sees.
    for (final shape in controller.shapes.reversed) {
      if (_hitTest(shape, position)) {
        controller.selectShape(shape.id);
        return;
      }
    }
    controller.selectShape(null);
  }

  bool _hitTest(SvgShape shape, Offset point) {
    switch (shape.type) {
      case SvgShapeType.rectangle:
      case SvgShapeType.path:
        return point.dx >= shape.x &&
            point.dx <= shape.x + shape.width &&
            point.dy >= shape.y &&
            point.dy <= shape.y + shape.height;
      case SvgShapeType.circle:
        final dx = point.dx - shape.x;
        final dy = point.dy - shape.y;
        return (dx * dx + dy * dy) <= (shape.radius * shape.radius);
      case SvgShapeType.line:
        // Simple distance-to-segment check with generous tolerance,
        // since a line has no fill area to tap.
        final tolerance = 10.0;
        final dist = _distanceToSegment(point, Offset(shape.x, shape.y), Offset(shape.x2, shape.y2));
        return dist <= tolerance;
      case SvgShapeType.text:
        return point.dx >= shape.x &&
            point.dx <= shape.x + shape.fontSize * shape.textContent.length * 0.6 &&
            point.dy >= shape.y - shape.fontSize &&
            point.dy <= shape.y;
    }
  }

  double _distanceToSegment(Offset p, Offset a, Offset b) {
    final ab = b - a;
    final ap = p - a;
    final lengthSquared = ab.dx * ab.dx + ab.dy * ab.dy;
    final t = lengthSquared == 0 ? 0.0 : ((ap.dx * ab.dx + ap.dy * ab.dy) / lengthSquared).clamp(0.0, 1.0);
    final closest = Offset(a.dx + ab.dx * t, a.dy + ab.dy * t);
    return (p - closest).distance;
  }
}

class _SvgCanvasPainter extends CustomPainter {
  final List<SvgShape> shapes;
  final String? selectedId;

  _SvgCanvasPainter({required this.shapes, required this.selectedId});

  @override
  void paint(Canvas canvas, Size size) {
    for (final shape in shapes) {
      final fillPaint = Paint()
        ..color = ColorUtils.parseHex(shape.fill).withOpacity(shape.opacity)
        ..style = PaintingStyle.fill;
      final strokePaint = Paint()
        ..color = ColorUtils.parseHex(shape.stroke).withOpacity(shape.opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = shape.strokeWidth;

      switch (shape.type) {
        case SvgShapeType.rectangle:
          final rect = Rect.fromLTWH(shape.x, shape.y, shape.width, shape.height);
          canvas.drawRect(rect, fillPaint);
          if (shape.strokeWidth > 0) canvas.drawRect(rect, strokePaint);
          break;

        case SvgShapeType.circle:
          canvas.drawCircle(Offset(shape.x, shape.y), shape.radius, fillPaint);
          if (shape.strokeWidth > 0) canvas.drawCircle(Offset(shape.x, shape.y), shape.radius, strokePaint);
          break;

        case SvgShapeType.line:
          canvas.drawLine(Offset(shape.x, shape.y), Offset(shape.x2, shape.y2), strokePaint);
          break;

        case SvgShapeType.text:
          final painter = TextPainter(
            text: TextSpan(
              text: shape.textContent,
              style: TextStyle(color: ColorUtils.parseHex(shape.fill).withOpacity(shape.opacity), fontSize: shape.fontSize),
            ),
            textDirection: TextDirection.ltr,
          );
          painter.layout();
          painter.paint(canvas, Offset(shape.x, shape.y - shape.fontSize));
          break;

        case SvgShapeType.path:
          // Real path data isn't parsed/rendered here — see class doc.
          // A clearly-labeled placeholder keeps this honest rather than
          // silently drawing nothing.
          final rect = Rect.fromLTWH(shape.x, shape.y, shape.width, shape.height);
          final placeholderPaint = Paint()
            ..color = Colors.grey.withOpacity(0.15)
            ..style = PaintingStyle.fill;
          canvas.drawRect(rect, placeholderPaint);
          _drawDashedBorder(canvas, rect);
          final painter = TextPainter(
            text: const TextSpan(text: 'path (see code)', style: TextStyle(color: Colors.grey, fontSize: 10)),
            textDirection: TextDirection.ltr,
          );
          painter.layout(maxWidth: shape.width);
          painter.paint(canvas, Offset(shape.x + 4, shape.y + 4));
          break;
      }

      if (shape.id == selectedId) {
        final bounds = _boundsFor(shape);
        final selectionPaint = Paint()
          ..color = Colors.blueAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawRect(bounds.inflate(4), selectionPaint);
      }
    }
  }

  Rect _boundsFor(SvgShape shape) {
    switch (shape.type) {
      case SvgShapeType.rectangle:
      case SvgShapeType.path:
        return Rect.fromLTWH(shape.x, shape.y, shape.width, shape.height);
      case SvgShapeType.circle:
        return Rect.fromCircle(center: Offset(shape.x, shape.y), radius: shape.radius);
      case SvgShapeType.line:
        return Rect.fromPoints(Offset(shape.x, shape.y), Offset(shape.x2, shape.y2));
      case SvgShapeType.text:
        return Rect.fromLTWH(shape.x, shape.y - shape.fontSize, shape.fontSize * shape.textContent.length * 0.6, shape.fontSize);
    }
  }

  void _drawDashedBorder(Canvas canvas, Rect rect) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const dashWidth = 4.0;
    const dashSpace = 3.0;
    var path = Path()..addRect(rect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SvgCanvasPainter oldDelegate) => true;
}
