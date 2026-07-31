import 'package:flutter/material.dart';
import '../svg_studio/svg_shape_model.dart';

/// Horizontal row of "add shape" buttons for SVG Studio.
class ShapeToolbar extends StatelessWidget {
  final ValueChanged<SvgShapeType> onAddShape;

  const ShapeToolbar({super.key, required this.onAddShape});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          _ToolButton(icon: Icons.crop_square, label: 'Rectangle', onTap: () => onAddShape(SvgShapeType.rectangle)),
          _ToolButton(icon: Icons.circle_outlined, label: 'Circle', onTap: () => onAddShape(SvgShapeType.circle)),
          _ToolButton(icon: Icons.show_chart, label: 'Line', onTap: () => onAddShape(SvgShapeType.line)),
          _ToolButton(icon: Icons.text_fields, label: 'Text', onTap: () => onAddShape(SvgShapeType.text)),
          _ToolButton(icon: Icons.gesture, label: 'Path', onTap: () => onAddShape(SvgShapeType.path)),
        ],
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ToolButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton.icon(
        icon: Icon(icon, size: 16),
        label: Text(label, style: const TextStyle(fontSize: 12)),
        onPressed: onTap,
      ),
    );
  }
}
