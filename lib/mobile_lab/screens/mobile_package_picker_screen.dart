import 'package:flutter/material.dart';

// ============================================================
// PACKAGE PICKER — curated list of common Flutter packages, adds
// them to the project's pubspec.yaml directly via safe text editing.
// Prevents students hand-editing YAML and breaking indentation.
// ============================================================

class MobilePackageInfo {
  final String name;
  final String version;
  final String description;
  final IconData icon;

  const MobilePackageInfo({
    required this.name,
    required this.version,
    required this.description,
    required this.icon,
  });
}

const List<MobilePackageInfo> kCuratedPackages = [
  MobilePackageInfo(name: 'http', version: '^1.2.0', description: 'Make network requests to APIs', icon: Icons.cloud_outlined),
  MobilePackageInfo(name: 'provider', version: '^6.1.2', description: 'Simple state management', icon: Icons.hub_outlined),
  MobilePackageInfo(name: 'shared_preferences', version: '^2.3.2', description: 'Save small pieces of data on the device', icon: Icons.save_outlined),
  MobilePackageInfo(name: 'image_picker', version: '^1.1.2', description: 'Pick images from camera or gallery', icon: Icons.image_outlined),
  MobilePackageInfo(name: 'url_launcher', version: '^6.3.0', description: 'Open URLs, phone numbers, emails', icon: Icons.link),
  MobilePackageInfo(name: 'intl', version: '^0.19.0', description: 'Format dates, numbers, and currency', icon: Icons.language),
  MobilePackageInfo(name: 'cached_network_image', version: '^3.4.1', description: 'Load and cache images from the web', icon: Icons.photo_outlined),
  MobilePackageInfo(name: 'path_provider', version: '^2.1.4', description: 'Find common device file paths', icon: Icons.folder_outlined),
  MobilePackageInfo(name: 'sqflite', version: '^2.3.3', description: 'A local SQLite database', icon: Icons.storage_outlined),
  MobilePackageInfo(name: 'google_fonts', version: '^6.2.1', description: 'Use any Google Font in your app', icon: Icons.text_fields),
  MobilePackageInfo(name: 'flutter_svg', version: '^2.0.10', description: 'Render SVG images', icon: Icons.image),
  MobilePackageInfo(name: 'permission_handler', version: '^11.3.1', description: 'Request camera, location, etc. permissions', icon: Icons.security_outlined),
  MobilePackageInfo(name: 'share_plus', version: '^10.0.2', description: 'Share text, links, and files', icon: Icons.share_outlined),
  MobilePackageInfo(name: 'device_info_plus', version: '^10.1.2', description: 'Read device model, OS version, etc.', icon: Icons.phone_android),
  MobilePackageInfo(name: 'package_info_plus', version: '^8.0.2', description: 'Read your app\'s own name and version', icon: Icons.info_outline),
  MobilePackageInfo(name: 'connectivity_plus', version: '^6.0.5', description: 'Check if the device is online', icon: Icons.wifi),
  MobilePackageInfo(name: 'video_player', version: '^2.9.1', description: 'Play video files', icon: Icons.play_circle_outline),
  MobilePackageInfo(name: 'audioplayers', version: '^6.1.0', description: 'Play sound and music', icon: Icons.music_note_outlined),
  MobilePackageInfo(name: 'lottie', version: '^3.1.2', description: 'Play Lottie animations', icon: Icons.animation),
  MobilePackageInfo(name: 'webview_flutter', version: '^4.9.0', description: 'Embed a web view in your app', icon: Icons.web),
];

// ============================================================
// PUBSPEC MANAGER — safe, deterministic text edits to a
// pubspec.yaml file's dependencies: section.
// ============================================================

class PubspecManager {
  /// Returns the set of package names currently under `dependencies:`,
  /// excluding the flutter sdk entry and its nested `sdk: flutter` line.
  static Set<String> listInstalledPackages(String pubspecContent) {
    final lines = pubspecContent.split('\n');
    final installed = <String>{};
    bool inDependencies = false;

    for (final line in lines) {
      if (line.trim() == 'dependencies:') {
        inDependencies = true;
        continue;
      }
      if (inDependencies) {
        // A top-level section change (no leading space) ends dependencies:
        if (line.isNotEmpty && !line.startsWith(' ')) {
          inDependencies = false;
          continue;
        }
        // Top-level package key: exactly 2 spaces indent, ends with ':'
        final match = RegExp(r'^  ([a-zA-Z0-9_]+):').firstMatch(line);
        if (match != null) {
          final name = match.group(1)!;
          if (name != 'flutter') installed.add(name);
        }
      }
    }
    return installed;
  }

  static bool hasPackage(String pubspecContent, String packageName) {
    return listInstalledPackages(pubspecContent).contains(packageName);
  }

  /// Inserts `  package: version` right after the `dependencies:` line.
  /// Does nothing if the package is already present.
  static String addPackage(String pubspecContent, String packageName, String version) {
    if (hasPackage(pubspecContent, packageName)) return pubspecContent;

    final lines = pubspecContent.split('\n');
    final index = lines.indexWhere((l) => l.trim() == 'dependencies:');
    if (index == -1) {
      // No dependencies: section found — append one at the end, safely.
      return '$pubspecContent\ndependencies:\n  $packageName: $version\n';
    }

    lines.insert(index + 1, '  $packageName: $version');
    return lines.join('\n');
  }

  /// Removes a top-level package line (and nothing else) from
  /// dependencies:. Leaves the flutter sdk entry untouched always.
  static String removePackage(String pubspecContent, String packageName) {
    if (packageName == 'flutter') return pubspecContent;

    final lines = pubspecContent.split('\n');
    final newLines = <String>[];
    bool inDependencies = false;
    bool skipping = false;

    for (final line in lines) {
      if (line.trim() == 'dependencies:') {
        inDependencies = true;
        newLines.add(line);
        continue;
      }
      if (inDependencies && line.isNotEmpty && !line.startsWith(' ')) {
        inDependencies = false;
      }

      if (inDependencies) {
        final match = RegExp(r'^  ([a-zA-Z0-9_]+):').firstMatch(line);
        if (match != null) {
          skipping = match.group(1) == packageName;
          if (skipping) continue;
        } else if (skipping) {
          // A nested line under the package being removed (e.g. "    sdk: flutter")
          continue;
        }
      }
      newLines.add(line);
    }
    return newLines.join('\n');
  }
}

// ============================================================
// PACKAGE PICKER SCREEN
// ============================================================

class MobilePackagePickerScreen extends StatefulWidget {
  final String currentPubspecContent;
  final ValueChanged<String> onPubspecChanged;

  const MobilePackagePickerScreen({
    required this.currentPubspecContent,
    required this.onPubspecChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<MobilePackagePickerScreen> createState() => _MobilePackagePickerScreenState();
}

class _MobilePackagePickerScreenState extends State<MobilePackagePickerScreen> {
  late String _pubspecContent;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _pubspecContent = widget.currentPubspecContent;
  }

  void _toggle(MobilePackageInfo pkg, bool installed) {
    setState(() {
      _pubspecContent = installed
          ? PubspecManager.removePackage(_pubspecContent, pkg.name)
          : PubspecManager.addPackage(_pubspecContent, pkg.name, pkg.version);
    });
    widget.onPubspecChanged(_pubspecContent);
  }

  @override
  Widget build(BuildContext context) {
    final installed = PubspecManager.listInstalledPackages(_pubspecContent);
    final filtered = kCuratedPackages.where((p) =>
        p.name.toLowerCase().contains(_query.toLowerCase()) ||
        p.description.toLowerCase().contains(_query.toLowerCase()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Packages'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search packages...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: ListView(
              children: filtered.map((pkg) {
                final isInstalled = installed.contains(pkg.name);
                return ListTile(
                  leading: Icon(pkg.icon, color: isInstalled ? Colors.green : Colors.grey[600]),
                  title: Text(pkg.name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                  subtitle: Text(pkg.description),
                  trailing: isInstalled
                      ? OutlinedButton(
                          onPressed: () => _toggle(pkg, true),
                          child: const Text('Remove'),
                        )
                      : FilledButton(
                          onPressed: () => _toggle(pkg, false),
                          child: const Text('Add'),
                        ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
