import 'package:flutter/material.dart';
import '../controllers/console_controller.dart';
import '../controllers/editor_controller.dart';
import '../controllers/preview_controller.dart';
import '../controllers/project_controller.dart';
import '../models/file_node_model.dart';
import '../editor/code_editor_widget.dart';
import '../widgets/editor_tab_bar.dart';
import 'preview_screen.dart';

/// The main coding workspace: a multi-file, multi-tab code editor over
/// the currently open project. Wraps [EditorController] state and wires
/// edits back into the project's file tree and local storage.
class EditorScreen extends StatefulWidget {
  final ProjectController projectController;
  final FileNode? initialFile;

  const EditorScreen({super.key, required this.projectController, this.initialFile});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late final EditorController _editorController;
  late final PreviewController _previewController;
  late final ConsoleController _consoleController;

  @override
  void initState() {
    super.initState();
    _editorController = EditorController();
    _previewController = PreviewController();
    _consoleController = ConsoleController();
    if (widget.initialFile != null) {
      _editorController.openFile(widget.initialFile!);
    }
  }

  @override
  void dispose() {
    _editorController.dispose();
    _previewController.dispose();
    _consoleController.dispose();
    super.dispose();
  }

  Future<void> _saveAll() async {
    for (final tab in _editorController.openTabs) {
      _editorController.markSaved(tab.file);
    }
    await widget.projectController.saveCurrentProject();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Project saved')));
  }

  void _openPreview() {
    final project = widget.projectController.currentProject;
    if (project == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          project: project,
          previewController: _previewController,
          consoleController: _consoleController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.projectController.currentProject;
    if (project == null) {
      return const Scaffold(body: Center(child: Text('No project open.')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: [
          IconButton(tooltip: 'Save', icon: const Icon(Icons.save_outlined), onPressed: _saveAll),
          IconButton(tooltip: 'Preview', icon: const Icon(Icons.play_arrow), onPressed: _openPreview),
        ],
      ),
      body: AnimatedBuilder(
        animation: _editorController,
        builder: (context, _) {
          final activeFile = _editorController.activeFile;

          return Column(
            children: [
              EditorTabBar(
                tabs: _editorController.openTabs,
                activeFileId: _editorController.activeFileId,
                onTabSelected: (tab) => _editorController.focusFile(tab.file),
                onTabClosed: (tab) => _editorController.closeFile(tab.file),
              ),
              Expanded(
                child: activeFile == null
                    ? const Center(
                        child: Text(
                          'Select a file from the Project Explorer to start editing.',
                          style: TextStyle(color: Colors.white54),
                        ),
                      )
                    : CodeEditorWidget(
                        key: ValueKey(activeFile.id),
                        file: activeFile,
                        onChanged: (text) => _editorController.updateContent(activeFile, text),
                        onUndo: () => _editorController.undo(activeFile),
                        onRedo: () => _editorController.redo(activeFile),
                        canUndo: _editorController.canUndo(activeFile),
                        canRedo: _editorController.canRedo(activeFile),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
