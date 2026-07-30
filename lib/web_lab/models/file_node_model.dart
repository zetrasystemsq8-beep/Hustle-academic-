import 'package:flutter/foundation.dart';

/// Represents the type of a node inside a Web Lab project's file tree.
enum FileNodeType {
  file,
  folder,
}

/// A single node in a project's file/folder tree.
///
/// This mirrors how VS Code represents a workspace: a [FileNode] can either
/// be a leaf (a file with text content) or a branch (a folder containing
/// other [FileNode]s). The tree is fully mutable and is designed to be
/// serialized to/from JSON for local persistence.
class FileNode {
  /// Unique identifier for this node. Generated once on creation and never
  /// reused, so renames/moves don't break references held elsewhere
  /// (open editor tabs, recent files, etc).
  final String id;

  /// Display name of the file or folder, e.g. "index.html" or "assets".
  String name;

  /// Whether this node is a [FileNodeType.file] or [FileNodeType.folder].
  final FileNodeType type;

  /// Raw text content of the file. Always empty for folders.
  String content;

  /// Child nodes, only meaningful when [type] is [FileNodeType.folder].
  List<FileNode> children;

  /// Whether a folder is currently expanded in the Project Explorer UI.
  /// Purely a UI concern, but stored here so tree state survives rebuilds.
  bool isExpanded;

  /// Timestamp of the last modification, used for sorting and displaying
  /// "last edited" info in the explorer.
  DateTime lastModified;

  FileNode({
    required this.id,
    required this.name,
    required this.type,
    this.content = '',
    List<FileNode>? children,
    this.isExpanded = false,
    DateTime? lastModified,
  })  : children = children ?? <FileNode>[],
        lastModified = lastModified ?? DateTime.now();

  /// Convenience getter: true when this node is a folder.
  bool get isFolder => type == FileNodeType.folder;

  /// Convenience getter: true when this node is a file.
  bool get isFile => type == FileNodeType.file;

  /// Returns the file extension (lowercase, without the dot), or an empty
  /// string for folders or extension-less files.
  String get extension {
    if (isFolder) return '';
    final dotIndex = name.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == name.length - 1) return '';
    return name.substring(dotIndex + 1).toLowerCase();
  }

  /// Creates a deep copy of this node and all its descendants.
  ///
  /// Used when duplicating files/folders in the Project Explorer, so the
  /// copy shares no mutable references with the original.
  FileNode deepCopy({String? newId, String? newName}) {
    return FileNode(
      id: newId ?? _generateId(),
      name: newName ?? name,
      type: type,
      content: content,
      children: children.map((c) => c.deepCopy()).toList(),
      isExpanded: isExpanded,
      lastModified: DateTime.now(),
    );
  }

  /// Serializes this node (and its subtree) to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'content': content,
      'children': children.map((c) => c.toJson()).toList(),
      'isExpanded': isExpanded,
      'lastModified': lastModified.toIso8601String(),
    };
  }

  /// Rebuilds a [FileNode] subtree from a JSON map produced by [toJson].
  factory FileNode.fromJson(Map<String, dynamic> json) {
    return FileNode(
      id: json['id'] as String,
      name: json['name'] as String,
      type: FileNodeType.values.byName(json['type'] as String),
      content: json['content'] as String? ?? '',
      children: (json['children'] as List<dynamic>? ?? [])
          .map((c) => FileNode.fromJson(c as Map<String, dynamic>))
          .toList(),
      isExpanded: json['isExpanded'] as bool? ?? false,
      lastModified: DateTime.tryParse(json['lastModified'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  static String _generateId() =>
      '${DateTime.now().microsecondsSinceEpoch}_${identityHashCode(Object())}';

  @override
  bool operator ==(Object other) => other is FileNode && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
