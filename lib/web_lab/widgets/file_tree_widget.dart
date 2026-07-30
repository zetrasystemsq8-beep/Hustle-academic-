import 'package:flutter/material.dart';
import '../models/file_node_model.dart';
import '../utils/file_icons.dart';

/// Renders a project's [FileNode] tree as an indented, expandable list,
/// mirroring a VS Code-style Project Explorer. All mutation actions
/// (create/rename/delete/duplicate/move) are delegated via callbacks —
/// this widget only renders state and reports user intent upward.
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

    // The invisible root folder isn't rendered as a row itself — only
    // its children are, starting the visible tree at depth 0.
    final children = depth == 0 ? node.children : node.children;
    final isRootCall = depth == 0;

    if (!isRootCall) {
      widgets.add(_FileTreeRow(
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
        onRename: () => onRename(_findParent(root, node) ?? root, node),
        onDelete: () => onDelete(_findParent(root, node) ?? root, node),
        onDuplicate: () => onDuplicate(_findParent(root, node) ?? root, node),
        onCreateFile: node.isFolder ? () => onCreateFile(node) : null,
        onCreateFolder: node.isFolder ? () => onCreateFolder(node) : null,
      ));
    }

    if (node.isFolder && (isRootCall || node.isExpanded)) {
      for (final child in children) {
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
