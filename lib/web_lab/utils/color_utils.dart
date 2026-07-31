import 'package:flutter/material.dart';

/// Small hex-color parsing/serialization helpers shared by SVG Studio
/// and Animation Lab, so both tools read and write the same #rrggbb
/// format students will recognize from real CSS and SVG.
class ColorUtils {
  ColorUtils._();

  /// Parses a "#rrggbb" or "#aarrggbb" string into a [Color]. Falls back
  /// to opaque black if the string is malformed, rather than throwing —
  /// callers are typically live-updating from a text field mid-keystroke.
  static Color parseHex(String hex) {
    var value = hex.trim().replaceFirst('#', '');
    if (value.length == 6) value = 'FF$value';
    if (value.length != 8) return Colors.black;
    final parsed = int.tryParse(value, radix: 16);
    if (parsed == null) return Colors.black;
    return Color(parsed);
  }

  /// Serializes a [Color] back to a "#rrggbb" string (alpha dropped,
  /// since SVG/CSS fill and background-color values are almost always
  /// opaque in student projects; opacity is handled as a separate
  /// property in both tools).
  static String toHex(Color color) {
    final r = color.red.toRadixString(16).padLeft(2, '0');
    final g = color.green.toRadixString(16).padLeft(2, '0');
    final b = color.blue.toRadixString(16).padLeft(2, '0');
    return '#$r$g$b'.toUpperCase();
  }

  /// A small fixed palette for quick-pick swatches, kept intentionally
  /// short so it stays a starting point rather than a limitation —
  /// every picker also accepts a typed hex value.
  static const List<Color> quickPalette = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.grey,
  ];
}
