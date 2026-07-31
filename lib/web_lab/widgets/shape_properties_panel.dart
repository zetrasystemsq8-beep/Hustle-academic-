import 'package:flutter/material.dart';
import '../controllers/svg_studio_controller.dart';
import '../svg_studio/svg_shape_model.dart';
import 'color_picker_field.dart';

/// Editable fields for the currently selected shape on the SVG Studio
/// canvas — the visual counterpart to hand-typing SVG attributes,
/// showing exactly which attribute each control maps to.
class ShapePropertiesPanel extends StatelessWidget {
  final SvgStudioController controller;

  const ShapePropertiesPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final shape = controller.selectedShape;
        if (shape == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('Tap a shape on the canvas to edit it.', style: TextStyle(color: Colors.grey)),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Text(shape.displayName, style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                IconButton(
                  tooltip: 'Send backward',
                  icon: const Icon(Icons.flip_to_back, size: 18),
                  onPressed: () => controller.sendBackward(shape.id),
                ),
                IconButton(
                  tooltip: 'Bring forward',
                  icon: const Icon(Icons.flip_to_front, size: 18),
                  onPressed: () => controller.bringForward(shape.id),
                ),
                IconButton(
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                  onPressed: () => controller.removeShape(shape.id),
                ),
              ],
            ),
            const Divider(),
            ..._buildFieldsForType(shape),
            const Divider(),
            _sliderField('Opacity', shape.opacity, 0, 1, (v) => controller.updateSelected((s) => s.opacity = v)),
            _sliderField('Rotation°', shape.rotationDegrees, 0, 360, (v) => controller.updateSelected((s) => s.rotationDegrees = v)),
          ],
        );
      },
    );
  }

  List<Widget> _buildFieldsForType(SvgShape shape) {
    switch (shape.type) {
      case SvgShapeType.rectangle:
        return [
          _numberField('X', shape.x, (v) => controller.updateSelected((s) => s.x = v)),
          _numberField('Y', shape.y, (v) => controller.updateSelected((s) => s.y = v)),
          _numberField('Width', shape.width, (v) => controller.updateSelected((s) => s.width = v)),
          _numberField('Height', shape.height, (v) => controller.updateSelected((s) => s.height = v)),
          _colorField('Fill', shape.fill, (v) => controller.updateSelected((s) => s.fill = v)),
          _colorField('Stroke', shape.stroke, (v) => controller.updateSelected((s) => s.stroke = v)),
          _numberField('Stroke width', shape.strokeWidth, (v) => controller.updateSelected((s) => s.strokeWidth = v)),
        ];
      case SvgShapeType.circle:
        return [
          _numberField('Center X (cx)', shape.x, (v) => controller.updateSelected((s) => s.x = v)),
          _numberField('Center Y (cy)', shape.y, (v) => controller.updateSelected((s) => s.y = v)),
          _numberField('Radius', shape.radius, (v) => controller.updateSelected((s) => s.radius = v)),
          _colorField('Fill', shape.fill, (v) => controller.updateSelected((s) => s.fill = v)),
          _colorField('Stroke', shape.stroke, (v) => controller.updateSelected((s) => s.stroke = v)),
          _numberField('Stroke width', shape.strokeWidth, (v) => controller.updateSelected((s) => s.strokeWidth = v)),
        ];
      case SvgShapeType.line:
        return [
          _numberField('X1', shape.x, (v) => controller.updateSelected((s) => s.x = v)),
          _numberField('Y1', shape.y, (v) => controller.updateSelected((s) => s.y = v)),
          _numberField('X2', shape.x2, (v) => controller.updateSelected((s) => s.x2 = v)),
          _numberField('Y2', shape.y2, (v) => controller.updateSelected((s) => s.y2 = v)),
          _colorField('Stroke', shape.stroke, (v) => controller.updateSelected((s) => s.stroke = v)),
          _numberField('Stroke width', shape.strokeWidth, (v) => controller.updateSelected((s) => s.strokeWidth = v)),
        ];
      case SvgShapeType.text:
        return [
          _numberField('X', shape.x, (v) => controller.updateSelected((s) => s.x = v)),
          _numberField('Y', shape.y, (v) => controller.updateSelected((s) => s.y = v)),
          _textField('Content', shape.textContent, (v) => controller.updateSelected((s) => s.textContent = v)),
          _numberField('Font size', shape.fontSize, (v) => controller.updateSelected((s) => s.fontSize = v)),
          _colorField('Fill', shape.fill, (v) => controller.updateSelected((s) => s.fill = v)),
        ];
      case SvgShapeType.path:
        return [
          _numberField('X', shape.x, (v) => controller.updateSelected((s) => s.x = v)),
          _numberField('Y', shape.y, (v) => controller.updateSelected((s) => s.y = v)),
          _numberField('Width', shape.width, (v) => controller.updateSelected((s) => s.width = v)),
          _numberField('Height', shape.height, (v) => controller.updateSelected((s) => s.height = v)),
          _textField('Path data (d)', shape.pathData, (v) => controller.updateSelected((s) => s.pathData = v)),
          _colorField('Fill', shape.fill, (v) => controller.updateSelected((s) => s.fill = v)),
          _colorField('Stroke', shape.stroke, (v) => controller.updateSelected((s) => s.stroke = v)),
        ];
    }
  }

  Widget _numberField(String label, double value, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(fontSize: 13))),
          Expanded(
            child: TextFormField(
              initialValue: value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1),
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
              onChanged: (text) {
                final parsed = double.tryParse(text);
                if (parsed != null) onChanged(parsed);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(String label, String value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          TextFormField(
            initialValue: value,
            maxLines: label == 'Path data (d)' ? 3 : 1,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _colorField(String label, String value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(fontSize: 13))),
          ColorPickerField(label: label, hexValue: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _sliderField(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Row(
      children: [
        SizedBox(width: 110, child: Text(label, style: const TextStyle(fontSize: 13))),
        Expanded(
          child: Slider(value: value.clamp(min, max), min: min, max: max, onChanged: onChanged),
        ),
      ],
    );
  }
}
