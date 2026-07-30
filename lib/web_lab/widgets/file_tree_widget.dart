import 'package:flutter/material.dart';
import '../models/file_node_model.dart';
import '../utils/file_icons.dart';

/// Renders a project's [FileNode] tree as an indented, expandable list,
/// mirroring a VS Code-style Project Explorer. All mutation actions
/// (create/rename/delete/duplicate/move) are delegated via callbacks —
/// this widget only renders state and reports user intent upward.
///
/// Drag-and-drop moving is supported: any row is draggable, and folder
/// rows act as drop targets. Dropping a node onto a folder calls [onMove]
/// with that node and destination folder.
class FileTreeWidget extends StatelessWidget {
  final FileNode root;
  final String? activeFileId;
  final ValueChanged<FileNode> onFileTap;
  final ValueChanged<FileNode> onToggleFolder;
  final void Function(FileNode parent, FileNode node) onRename;
  final void Function(FileNode parent, FileNode node) onDelete;
  final void Function(FileNode parent, FileNode node) onDuplicate;
  final void Function(FileNode parent) onCreateFile;
  final void Function(FileNode parent) onCreateFolder;
  final void Function(FileNode dragged, FileNode targetFolder)? onMove;

  const FileTreeWidget({
    super.key,
    required this.root,
    required this.activeFileId,
    required this.onFileTap,
    required this.onToggleFolder,
    required this.onRename,
    required this.onDelete,
    required this.onDuplicate,
    required this.onCreateFile,
    required this.onCreateFolder,
    this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: _buildNodes(root, depth: 0),
    );
  }

  List<Widget> _buildNodes(FileNode node, {required int depth}) {
    final widgets = <Widget>[];
    final isRootCall = depth == 0;

    if (!isRootCall) {
      final parent = _findParent(root, node) ?? root;

      Widget row = _FileTreeRow(
        node: node,
        depth: depth,
        isActive: node.id == activeFileId,
        onTap: () {
          if (node.isFolder) {
            onToggleFolder(node);
          } else {
            onFileTap(node);
          }
        },
        onRename: () => onRename(parent, node),
        onDelete: () => onDelete(parent, node),
        onDuplicate: () => onDuplicate(parent, node),
        onCreateFile: node.isFolder ? () => onCreateFile(node) : null,
        onCreateFolder: node.isFolder ? () => onCreateFolder(node) : null,
      );

      // Every row is draggable so files and folders alike can be moved.
      row = LongPressDraggable<FileNode>(
        data: node,
        feedback: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.grey.shade900,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FileIcons.iconFor(node), size: 16, color: FileIcons.colorFor(node)),
                const SizedBox(width: 6),
                Text(node.name, style: const TextStyle(color: Colors.white, fontSize: 13)),
              ],
            ),
          ),
        ),
        childWhenDragging: Opacity(opacity: 0.3, child: row),
        child: row,
      );

      // Only folders act as valid drop targets, and a node can never be
      // dropped onto itself.
      if (node.isFolder && onMove != null) {
        row = DragTarget<FileNode>(
          onWillAcceptWithDetails: (details) => details.data.id != node.id,
          onAcceptWithDetails: (details) => onMove!(details.data, node),
          builder: (context, candidateData, rejectedData) {
            final isHovering = candidateData.isNotEmpty;
            return Container(
              decoration: BoxDecoration(
                color: isHovering ? Colors.blueAccent.withOpacity(0.15) : null,
                border: isHovering ? Border.all(color: Colors.blueAccent, width: 1) : null,
              ),
              child: row,
            );
          },
        );
      }

      widgets.add(row);
    }

    if (node.isFolder && (isRootCall || node.isExpanded)) {
      for (final child in node.children) {
        widgets.addAll(_buildNodes(child, depth: isRootCall ? depth : depth + 1));
      }
    }

    return widgets;
  }

  FileNode? _findParent(FileNode current, FileNode target) {
    for (final child in current.children) {
      if (child.id == target.id) return current;
      final found = _findParent(child, target);
      if (found != null) return found;
    }
    return null;
  }
}

/// A single row in the file tree: icon, name, expand/collapse chevron for
/// folders, and a context menu for file operations.
class _FileTreeRow extends StatelessWidget {
  final FileNode node;
  final int depth;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onDuplicate;
  final VoidCallback? onCreateFile;
  final VoidCallback? onCreateFolder;

  const _FileTreeRow({
    required this.node,
    required this.depth,
    required this.isActive,
    required this.onTap,
    required this.onRename,
    required this.onDelete,
    required this.onDuplicate,
    this.onCreateFile,
    this.onCreateFolder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: isActive ? theme.colorScheme.primaryContainer.withOpacity(0.4) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(left: 12.0 + depth * 16, right: 4, top: 8, bottom: 8),
          child: Row(
            children: [
              if (node.isFolder)
                Icon(
                  node.isExpanded ? Icons.expand_more : Icons.chevron_right,
                  size: 18,
                  color: theme.colorScheme.onSurfaceVariant,
                )
              else
                const SizedBox(width: 18),
              const SizedBox(width: 4),
              Icon(
                FileIcons.iconFor(node),
                size: 18,
                color: FileIcons.colorFor(node),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  node.name,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_horiz, size: 18),
                onSelected: (value) {
                  switch (value) {
                    case 'new_file':
                      onCreateFile?.call();
                      break;
                    case 'new_folder':
                      onCreateFolder?.call();
                      break;
                    case 'rename':
                      onRename();
                      break;
                    case 'duplicate':
                      onDuplicate();
                      break;
                    case 'delete':
                      onDelete();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (node.isFolder) ...[
                    const PopupMenuItem(value: 'new_file', child: Text('New File')),
                    const PopupMenuItem(value: 'new_folder', child: Text('New Folder')),
                    const PopupMenuDivider(),
                  ],
                  const PopupMenuItem(value: 'rename', child: Text('Rename')),
                  const PopupMenuItem(value: 'duplicate', child: Text('Duplicate')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
