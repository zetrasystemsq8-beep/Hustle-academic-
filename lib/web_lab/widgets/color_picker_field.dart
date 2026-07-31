import 'package:flutter/material.dart';
import '../utils/color_utils.dart';

/// A compact color field used by SVG Studio and Animation Lab: a swatch
/// that opens a palette + hex-input popup. Not a general-purpose Flutter
/// widget — deliberately scoped to the hex-string editing this app needs.
class ColorPickerField extends StatelessWidget {
  final String label;
  final String hexValue;
  final ValueChanged<String> onChanged;

  const ColorPickerField({
    super.key,
    required this.label,
    required this.hexValue,
    required this.onChanged,
  });

  Future<void> _openPicker(BuildContext context) async {
    final controller = TextEditingController(text: hexValue);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(label),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ColorUtils.quickPalette.map((color) {
                return GestureDetector(
                  onTap: () => Navigator.pop(context, ColorUtils.toHex(color)),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Hex value', prefixText: '#'),
              onSubmitted: (value) => Navigator.pop(context, '#$value'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, '#${controller.text.replaceFirst('#', '')}'),
            child: const Text('Use'),
          ),
        ],
      ),
    );
    if (result != null) onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openPicker(context),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: ColorUtils.parseHex(hexValue),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 8),
          Text(hexValue, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        ],
      ),
    );
  }
}
