/// A single importable library available in the Package Manager. `tags`
/// are the exact, real `<script>`/`<link>` tags for that library's
/// public CDN, injected verbatim into the assembled document — never
/// downloaded, bundled, or rewritten.
class CdnPackage {
  final String id;
  final String name;
  final String description;
  final List<String> tags;

  const CdnPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
  });
}

/// Fixed catalog of libraries Web Lab supports importing via CDN. Kept
/// as a small curated list — matching exactly what the spec named —
/// rather than an open plugin system, so every option here is one the
/// team has verified works inside the app's WebView.
class CdnPackageRegistry {
  CdnPackageRegistry._();

  static const List<CdnPackage> all = [
    CdnPackage(
      id: 'bootstrap',
      name: 'Bootstrap',
      description: 'Popular CSS framework with pre-built components and a grid system.',
      tags: [
        '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">',
        '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>',
      ],
    ),
    CdnPackage(
      id: 'tailwind',
      name: 'Tailwind CSS',
      description: 'Utility-first CSS framework — style directly with class names.',
      tags: [
        '<script src="https://cdn.tailwindcss.com"></script>',
      ],
    ),
    CdnPackage(
      id: 'alpine',
      name: 'Alpine.js',
      description: 'Lightweight JavaScript framework for adding interactivity via HTML attributes.',
      tags: [
        '<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.14.1/dist/cdn.min.js"></script>',
      ],
    ),
    CdnPackage(
      id: 'chartjs',
      name: 'Chart.js',
      description: 'Draw bar, line, pie, and other charts on a <canvas> element.',
      tags: [
        '<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>',
      ],
    ),
    CdnPackage(
      id: 'threejs',
      name: 'Three.js',
      description: '3D graphics library for rendering scenes, models, and animations.',
      tags: [
        '<script src="https://cdn.jsdelivr.net/npm/three@0.169.0/build/three.min.js"></script>',
      ],
    ),
    CdnPackage(
      id: 'gsap',
      name: 'GSAP',
      description: 'Professional-grade JavaScript animation library.',
      tags: [
        '<script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js"></script>',
      ],
    ),
  ];

  static CdnPackage? findById(String id) {
    try {
      return all.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Returns the concatenated `<head>` tags for every package id in
  /// [enabledIds], in registry order, for injection into an assembled
  /// document. Unknown ids (e.g. a package removed in a future version)
  /// are silently skipped rather than breaking the build.
  static String tagsForEnabled(List<String> enabledIds) {
    final buffer = StringBuffer();
    for (final id in enabledIds) {
      final package = findById(id);
      if (package == null) continue;
      for (final tag in package.tags) {
        buffer.writeln(tag);
      }
    }
    return buffer.toString();
  }
}
