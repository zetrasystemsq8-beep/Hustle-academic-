import 'file_node_model.dart';

/// The device orientation used when rendering the live Preview panel.
enum PreviewOrientation {
  portrait,
  landscape,
}

/// A single Web Lab project: a named workspace containing an HTML/CSS/JS
/// file tree plus metadata needed by the Home dashboard, Project Manager,
/// and local storage layer.
class ProjectModel {
  /// Unique identifier, stable across renames.
  final String id;

  /// Human-readable project name shown throughout the UI.
  String name;

  /// Root folder of the project's file tree. Always a [FileNodeType.folder].
  FileNode root;

  /// When the project was first created.
  final DateTime createdAt;

  /// When the project was last opened or saved. Drives the "Recent
  /// Projects" ordering on the Home dashboard.
  DateTime lastOpenedAt;

  /// Optional identifier of the template this project was created from,
  /// if any (null for blank projects, which is the default for beginners).
  final String? templateId;

  /// Last orientation the user previewed this project in, restored the
  /// next time the Preview panel opens.
  PreviewOrientation previewOrientation;

  /// IDs of challenges the learner has successfully completed while
  /// working on this project, if it was created for a Challenge.
  List<String> completedChallengeIds;

  ProjectModel({
    required this.id,
    required this.name,
    required this.root,
    DateTime? createdAt,
    DateTime? lastOpenedAt,
    this.templateId,
    this.previewOrientation = PreviewOrientation.portrait,
    List<String>? completedChallengeIds,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastOpenedAt = lastOpenedAt ?? DateTime.now(),
        completedChallengeIds = completedChallengeIds ?? <String>[];

  /// Finds the first file node in the tree matching [name] (e.g.
  /// "index.html"), searching depth-first. Returns null if not found.
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

  /// Convenience getters for the three core files every project starts
  /// with. May return null for projects whose entry files were deleted
  /// or renamed by the student.
  FileNode? get indexHtml => findFileByName('index.html');
  FileNode? get styleCss => findFileByName('style.css');
  FileNode? get scriptJs => findFileByName('script.js');

  /// Serializes the full project, including its entire file tree, to JSON.
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
    );
  }
}
