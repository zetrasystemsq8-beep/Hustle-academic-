import 'file_node_model.dart';

/// The device orientation used when rendering the live Preview panel.
enum PreviewOrientation {
  portrait,
  landscape,
}

/// A single Web Lab project: a named workspace containing an HTML/CSS/JS
/// file tree plus metadata needed by the Home dashboard, Project Manager,
/// local storage layer, Publish feature, and Package Manager.
class ProjectModel {
  final String id;
  String name;
  FileNode root;
  final DateTime createdAt;
  DateTime lastOpenedAt;
  final String? templateId;
  PreviewOrientation previewOrientation;
  List<String> completedChallengeIds;
  String? publishedSlug;
  DateTime? publishedAt;

  /// IDs of CDN packages (from [CdnPackageRegistry]) currently enabled
  /// for this project. Tags for these are injected automatically into
  /// the assembled preview/published document — the student's own
  /// index.html text is never modified to add them.
  List<String> enabledCdnPackageIds;

  ProjectModel({
    required this.id,
    required this.name,
    required this.root,
    DateTime? createdAt,
    DateTime? lastOpenedAt,
    this.templateId,
    this.previewOrientation = PreviewOrientation.portrait,
    List<String>? completedChallengeIds,
    this.publishedSlug,
    this.publishedAt,
    List<String>? enabledCdnPackageIds,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastOpenedAt = lastOpenedAt ?? DateTime.now(),
        completedChallengeIds = completedChallengeIds ?? <String>[],
        enabledCdnPackageIds = enabledCdnPackageIds ?? <String>[];

  FileNode? findFileByName(String name) {
    FileNode? search(FileNode node) {
      if (node.isFile && node.name == name) return node;
      for (final child in node.children) {
        final result = search(child);
        if (result != null) return result;
      }
      return null;
    }

    return search(root);
  }

  FileNode? get indexHtml => findFileByName('index.html');
  FileNode? get styleCss => findFileByName('style.css');
  FileNode? get scriptJs => findFileByName('script.js');

  bool get isPublished => publishedSlug != null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'root': root.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'lastOpenedAt': lastOpenedAt.toIso8601String(),
      'templateId': templateId,
      'previewOrientation': previewOrientation.name,
      'completedChallengeIds': completedChallengeIds,
      'publishedSlug': publishedSlug,
      'publishedAt': publishedAt?.toIso8601String(),
      'enabledCdnPackageIds': enabledCdnPackageIds,
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      root: FileNode.fromJson(json['root'] as Map<String, dynamic>),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      lastOpenedAt: DateTime.tryParse(json['lastOpenedAt'] as String? ?? ''),
      templateId: json['templateId'] as String?,
      previewOrientation: PreviewOrientation.values.byName(
        json['previewOrientation'] as String? ?? 'portrait',
      ),
      completedChallengeIds:
          (json['completedChallengeIds'] as List<dynamic>? ?? [])
              .map((e) => e as String)
              .toList(),
      publishedSlug: json['publishedSlug'] as String?,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'] as String)
          : null,
      enabledCdnPackageIds: (json['enabledCdnPackageIds'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
    );
  }
}
