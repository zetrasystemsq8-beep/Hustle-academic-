import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';

// ============================================================
// ICON PICKER SERVICE — lets a student pick a custom app icon,
// or falls back to Hustle Academy's bundled Zetra logo so
// generated apps NEVER ship with the plain Flutter logo.
// ============================================================

class MobileIconPickerService {
  static const String defaultIconAssetPath = 'assets/mobile_lab/default_app_icon.png';

  /// Opens the device gallery, returns base64-encoded PNG bytes ready
  /// to store on MobileProject.customIconBase64, or null if cancelled.
  static Future<String?> pickIcon() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (picked == null) return null;

    final bytes = await picked.readAsBytes();
    return base64Encode(bytes);
  }

  /// Loads Hustle Academy's own bundled Zetra logo — used whenever a
  /// project has no customIconBase64 set. Requires
  /// assets/mobile_lab/ to be listed under flutter: assets: in
  /// pubspec.yaml, since Flutter does not pull in subfolders of a
  /// listed parent directory automatically.
  static Future<Uint8List> loadDefaultIconBytes() async {
    final data = await rootBundle.load(defaultIconAssetPath);
    return data.buffer.asUint8List();
  }

  /// Resolves the actual bytes to embed in a project's zip — the
  /// student's custom icon if they set one, otherwise the default.
  /// Never throws: any failure loading either source falls back to
  /// a minimal generated placeholder rather than failing the build.
  static Future<Uint8List> resolveIconBytes(String? customIconBase64) async {
    if (customIconBase64 != null && customIconBase64.isNotEmpty) {
      try {
        return base64Decode(customIconBase64);
      } catch (e) {
        debugPrint('Custom icon failed to decode, falling back: $e');
      }
    }
    try {
      return await loadDefaultIconBytes();
    } catch (e) {
      debugPrint('Default icon asset failed to load, using generated placeholder: $e');
      return _generateFallbackIconBytes();
    }
  }

  /// Last-resort in-memory icon if even the bundled default asset
  /// fails to load for some reason — guarantees Generate APK never
  /// crashes outright because of a missing/misconfigured icon.
  static Future<Uint8List> _generateFallbackIconBytes() async {
    // A tiny valid 1x1 orange PNG, base64-encoded, used only if both
    // the custom icon and the bundled default icon are unavailable.
    const fallbackPngBase64 =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=';
    return base64Decode(fallbackPngBase64);
  }
}

// ============================================================
// ICON PICKER WIDGET — small preview + "Change Icon" button,
// drop this into the project editor's app bar or a settings sheet.
// ============================================================

class MobileIconPickerTile extends StatelessWidget {
  final String? customIconBase64;
  final ValueChanged<String?> onIconChanged;

  const MobileIconPickerTile({
    required this.customIconBase64,
    required this.onIconChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: customIconBase64 != null
            ? Image.memory(base64Decode(customIconBase64!), width: 40, height: 40, fit: BoxFit.cover)
            : FutureBuilder<Uint8List>(
                future: MobileIconPickerService.loadDefaultIconBytes(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(width: 40, height: 40, color: Colors.grey[300]);
                  }
                  return Image.memory(snapshot.data!, width: 40, height: 40, fit: BoxFit.cover);
                },
              ),
      ),
      title: Text(customIconBase64 != null ? 'Custom app icon' : 'Default Hustle Academy icon'),
      subtitle: const Text('Tap to change'),
      trailing: customIconBase64 != null
          ? IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Reset to default',
              onPressed: () => onIconChanged(null),
            )
          : null,
      onTap: () async {
        final base64Icon = await MobileIconPickerService.pickIcon();
        if (base64Icon != null) onIconChanged(base64Icon);
      },
    );
  }
}
