import 'dart:math';
import '../models/file_node_model.dart';

/// Provides all file-tree mutation operations used by the Project
/// Explorer: create, rename, delete, duplicate, and move.
///
/// Kept as a stateless service operating on plain [FileNode] trees so it
/// can be unit tested without any Flutter or storage dependency, and so
/// controllers stay thin.
class FileSystemService {
  final Random _random = Random();

  /// Generates a reasonably unique node id. Not cryptographically secure —
  /// collision risk is irrelevant for a single local file tree.
  String generateId() =>
      '${DateTime.now().microsecondsSinceEpoch}_${_random.nextInt(999999)}';

  /// Creates a new file named [name] inside [parent] and returns it.
  /// Throws [ArgumentError] if a sibling with the same name already exists.
  FileNode createFile(FileNode parent, String name) {
    _assertUniqueName(parent, name);
    final node = FileNode(id: generateId(), name: name, type: FileNodeType.file);
    parent.children.add(node);
    parent.lastModified = DateTime.now();
    return node;
  }

  /// Creates a new folder named [name] inside [parent] and returns it.
  /// Throws [ArgumentError] if a sibling with the same name already exists.
  FileNode createFolder(FileNode parent, String name) {
    _assertUniqueName(parent, name);
    final node = FileNode(id: generateId(), name: name, type: FileNodeType.folder);
    parent.children.add(node);
    parent.lastModified = DateTime.now();
    return node;
  }

  /// Renames [node] to [newName], validating uniqueness against its
  /// current [parent]'s other children.
  void renameNode(FileNode parent, FileNode node, String newName) {
    if (newName == node.name) return;
    _assertUniqueName(parent, newName, excluding: node);
    node.name = newName;
    node.lastModified = DateTime.now();
  }

  /// Removes [node] from [parent]'s children. Irreversible — callers
  /// (controllers) are responsible for any confirmation UI.
  void deleteNode(FileNode parent, FileNode node) {
    parent.children.removeWhere((c) => c.id == node.id);
    parent.lastModified = DateTime.now();
  }

  /// Duplicates [node] within [parent], appending " copy" (and a counter
  /// if needed) to keep the name unique, and returns the new node.
  FileNode duplicateNode(FileNode parent, FileNode node) {
    final baseName = _stripExtension(node.name);
    final ext = node.extension.isEmpty ? '' : '.${node.extension}';
    String candidate = '$baseName copy$ext';
    int counter = 2;
    while (_hasChildNamed(parent, candidate)) {
      candidate = '$baseName copy $counter$ext';
      counter++;
    }
    final copy = node.deepCopy(newId: generateId(), newName: candidate);
    parent.children.add(copy);
    parent.lastModified = DateTime.now();
    return copy;
  }

  /// Moves [node] out of [oldParent] and into [newParent], validating that
  /// the destination doesn't already contain a same-named sibling and that
  /// [newParent] isn't [node] itself or one of its own descendants.
  void moveNode(FileNode oldParent, FileNode newParent, FileNode node) {
    if (identical(newParent, node) || _isDescendant(node, newParent)) {
      throw ArgumentError('Cannot move a folder into itself or its own child.');
    }
    _assertUniqueName(newParent, node.name);
    oldParent.children.removeWhere((c) => c.id == node.id);
    newParent.children.add(node);
    node.lastModified = DateTime.now();
  }

  /// Toggles a folder's expanded/collapsed state in the explorer tree.
  void toggleExpanded(FileNode folder) {
    if (!folder.isFolder) return;
    folder.isExpanded = !folder.isExpanded;
  }

  bool _hasChildNamed(FileNode parent, String name) =>
      parent.children.any((c) => c.name == name);

  void _assertUniqueName(FileNode parent, String name, {FileNode? excluding}) {
    final clash = parent.children.any(
      (c) => c.name == name && (excluding == null || c.id != excluding.id),
    );
    if (clash) {
      throw ArgumentError('"$name" already exists in this folder.');
    }
  }

  String _stripExtension(String name) {
    final dotIndex = name.lastIndexOf('.');
    if (dotIndex <= 0) return name;
    return name.substring(0, dotIndex);
  }

  bool _isDescendant(FileNode node, FileNode candidate) {
    for (final child in node.children) {
      if (identical(child, candidate)) return true;
      if (_isDescendant(child, candidate)) return true;
    }
    return false;
  }
}
