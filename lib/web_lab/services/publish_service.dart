import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/project_model.dart';
import '../package_manager/cdn_package_registry.dart';

class PublishResult {
  final String slug;
  final String publicUrl;

  const PublishResult({required this.slug, required this.publicUrl});
}

/// Publishes a project's HTML/CSS/JS as a real, publicly hosted static
/// site using Supabase Storage.
class PublishService {
  static const String _bucketName = 'web-lab-published-sites';
  static const String _tableName = 'web_lab_published_projects';

  final SupabaseClient _client = Supabase.instance.client;
  final Random _random = Random();

  Future<PublishResult> publish(ProjectModel project, {String? existingSlug}) async {
    final slug = existingSlug ?? _generateSlug(project.name);
    final document = _buildStandaloneDocument(project);
    final bytes = Uint8List.fromList(utf8.encode(document));

    await _client.storage.from(_bucketName).uploadBinary(
          '$slug/index.html',
          bytes,
          fileOptions: const FileOptions(contentType: 'text/html', upsert: true),
        );

    await _client.from(_tableName).upsert(
      {
        'slug': slug,
        'project_name': project.name,
        'storage_path': '$slug/index.html',
        'published_at': DateTime.now().toIso8601String(),
      },
      onConflict: 'slug',
    );

    return PublishResult(slug: slug, publicUrl: publicUrlForSlug(slug));
  }

  Future<void> unpublish(String slug) async {
    await _client.storage.from(_bucketName).remove(['$slug/index.html']);
    await _client.from(_tableName).delete().eq('slug', slug);
  }

  String publicUrlForSlug(String slug) {
    return _client.storage.from(_bucketName).getPublicUrl('$slug/index.html');
  }

  String _generateSlug(String name) {
    final base = name
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-');
    final safeBase = base.isEmpty ? 'site' : base;
    final suffix = List.generate(6, (_) => _randomChar()).join();
    return '$safeBase-$suffix';
  }

  String _randomChar() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return chars[_random.nextInt(chars.length)];
  }

  /// Assembles the real, standalone HTML document served publicly.
  /// Enabled CDN packages are included here too, so a published site
  /// using Bootstrap/Tailwind/etc. actually works for visitors — not
  /// just inside the in-app preview.
  String _buildStandaloneDocument(ProjectModel project) {
    final html = project.indexHtml?.content ?? '';
    final css = project.styleCss?.content ?? '';
    final js = project.scriptJs?.content ?? '';
    final cdnTags = CdnPackageRegistry.tagsForEnabled(project.enabledCdnPackageIds);

    return '''<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${project.name}</title>
$cdnTags
<style>
$css
</style>
</head>
<body>
$html
<script>
$js
</script>
</body>
</html>
''';
  }
}
