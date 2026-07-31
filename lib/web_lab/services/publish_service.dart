import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/project_model.dart';

/// Result of a successful publish: the slug used and the public URL the
/// site is now reachable at.
class PublishResult {
  final String slug;
  final String publicUrl;

  const PublishResult({required this.slug, required this.publicUrl});
}

/// Publishes a project's HTML/CSS/JS as a real, publicly hosted static
/// site using Supabase Storage — no custom backend server required.
///
/// Every call is scoped to the `web-lab-published-sites` bucket and the
/// `web_lab_published_projects` table, both created specifically for
/// this feature, so this never touches data belonging to any other app
/// sharing the same Supabase project.
class PublishService {
  static const String _bucketName = 'web-lab-published-sites';
  static const String _tableName = 'web_lab_published_projects';

  final SupabaseClient _client = Supabase.instance.client;
  final Random _random = Random();

  /// Publishes [project]. If [existingSlug] is provided (the project was
  /// already published before), the same slug is reused so the URL stays
  /// stable across republishes — otherwise a new slug is generated.
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

  /// Removes a previously published site's file and metadata row.
  Future<void> unpublish(String slug) async {
    await _client.storage.from(_bucketName).remove(['$slug/index.html']);
    await _client.from(_tableName).delete().eq('slug', slug);
  }

  /// Computes the public URL for a given slug without any network call —
  /// used to redisplay a link for an already-published project.
  String publicUrlForSlug(String slug) {
    return _client.storage.from(_bucketName).getPublicUrl('$slug/index.html');
  }

  /// Generates a URL-safe slug from the project's name plus a random
  /// suffix, keeping published URLs short while avoiding collisions
  /// between two students naming their projects the same thing.
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

  /// Assembles a single standalone HTML document from the project's
  /// index.html, style.css, and script.js — this is the actual file
  /// uploaded and served publicly. No console bridge is injected here
  /// (unlike the in-app Preview), since visitors to the published site
  /// aren't debugging it in Web Lab's Console panel.
  String _buildStandaloneDocument(ProjectModel project) {
    final html = project.indexHtml?.content ?? '';
    final css = project.styleCss?.content ?? '';
    final js = project.scriptJs?.content ?? '';

    return '''<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${project.name}</title>
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
