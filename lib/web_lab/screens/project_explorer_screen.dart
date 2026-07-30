import 'package:flutter/material.dart';
import '../controllers/project_controller.dart';
import '../models/file_node_model.dart';
import '../services/file_system_service.dart';
import '../utils/validators.dart';
import '../widgets/file_tree_widget.dart';
import 'editor_screen.dart';

/// VS Code-style Project Explorer for the currently open project: create,
/// rename, delete, duplicate, and reorganize files and folders before
/// jumping into the Code Editor.
class ProjectExplorerScreen extends StatefulWidget {
  final ProjectController projectController;

  const ProjectExplorerScreen({super.key, required this.projectController});

  @override
  State<ProjectExplorerScreen> createState() => _ProjectExplorerScreenState();
}

class _ProjectExplorerScreenState extends State<ProjectExplorerScreen> {
  final FileSystemService _fileSystemService = FileSystemService();

  Future<String?> _promptForName(String title, {String initial = ''}) {
    final controller = TextEditingController(text: initial);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('OK')),
        ],
      ),
    );
  }

  Future<bool> _confirmDelete(String name) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete "$name"?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _createFile(FileNode parent) async {
    final name = await _promptForName('New File');
    if (name == null) return;
    final error = Validators.validateFileName(name);
    if (error != null) return _showError(error);
    try {
      _fileSystemService.createFile(parent, name.trim());
      widget.projectController.notifyProjectChanged();
      await widget.projectController.saveCurrentProject();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _createFolder(FileNode parent) async {
    final name = await _promptForName('New Folder');
    if (name == null) return;
    final error = Validators.validateFileName(name);
    if (error != null) return _showError(error);
    try {
      _fileSystemService.createFolder(parent, name.trim());
      widget.projectController.notifyProjectChanged();
      await widget.projectController.saveCurrentProject();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _rename(FileNode parent, FileNode node) async {
    final name = await _promptForName('Rename', initial: node.name);
    if (name == null) return;
    final error = Validators.validateFileName(name);
    if (error != null) return _showError(error);
    try {
      _fileSystemService.renameNode(parent, node, name.trim());
      widget.projectController.notifyProjectChanged();
      await widget.projectController.saveCurrentProject();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _delete(FileNode parent, FileNode node) async {
    final confirmed = await _confirmDelete(node.name);
    if (!confirmed) return;
    _fileSystemService.deleteNode(parent, node);
    widget.projectController.notifyProjectChanged();
    await widget.projectController.saveCurrentProject();
  }

  Future<void> _duplicate(FileNode parent, FileNode node) async {
    _fileSystemService.duplicateNode(parent, node);
    widget.projectController.notifyProjectChanged();
    await widget.projectController.saveCurrentProject();
  }

  void _toggleFolder(FileNode node) {
    _fileSystemService.toggleExpanded(node);
    widget.projectController.notifyProjectChanged();
  }

  void _openInEditor(FileNode file) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditorScreen(
          projectController: widget.projectController,
          initialFile: file,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.projectController,
      builder: (context, _) {
        final project = widget.projectController.currentProject;
        if (project == null) {
          return const Scaffold(body: Center(child: Text('No project open.')));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(project.name),
            actions: [
              IconButton(
                tooltip: 'New File',
                icon: const Icon(Icons.note_add_outlined),
                onPressed: () => _createFile(project.root),
              ),
              IconButton(
                tooltip: 'New Folder',
                icon: const Icon(Icons.create_new_folder_outlined),
                onPressed: () => _createFolder(project.root),
              ),
            ],
          ),
          body: FileTreeWidget(
            root: project.root,
            activeFileId: null,
            onFileTap: _openInEditor,
            onToggleFolder: _toggleFolder,
            onRename: _rename,
            onDelete: _delete,
            onDuplicate: _duplicate,
            onCreateFile: _createFile,
            onCreateFolder: _createFolder,
          ),
        );
      },
    );
  }
}
