import 'package:flutter/material.dart';
import '../controllers/console_controller.dart';
import '../controllers/editor_controller.dart';
import '../controllers/preview_controller.dart';
import '../controllers/project_controller.dart';
import '../editor/code_editor_widget.dart';
import '../models/file_node_model.dart';
import '../models/project_model.dart';
import '../preview/webview_preview.dart';
import '../widgets/editor_tab_bar.dart';

/// Sandbox: a no-ceremony experimentation space — no project name, no
/// save dialog, just three blank files and an instant live preview.
/// Reuses the exact same editor/preview infrastructure as a real
/// project, fed a throwaway in-memory [ProjectModel] that's never
/// written to storage unless the student explicitly saves it as a real
/// project to keep.
class SandboxScreen extends StatefulWidget {
  /// Optional — when provided, lets the student promote their sandbox
  /// experiment into a real, saved project.
  final ProjectController? projectController;

  const SandboxScreen({super.key, this.projectController});

  @override
  State<SandboxScreen> createState() => _SandboxScreenState();
}

class _SandboxScreenState extends State<SandboxScreen> {
  late final ProjectModel _scratchProject;
  late final EditorController _editorController;
  late final PreviewController _previewController;
  late final ConsoleController _consoleController;
  bool _splitView = true;

  @override
  void initState() {
    super.initState();

    final root = FileNode(id: 'sandbox_root', name: 'Sandbox', type: FileNodeType.folder, isExpanded: true);
    final indexFile = FileNode(id: 'sandbox_html', name: 'index.html', type: FileNodeType.file);
    final styleFile = FileNode(id: 'sandbox_css', name: 'style.css', type: FileNodeType.file);
    final scriptFile = FileNode(id: 'sandbox_js', name: 'script.js', type: FileNodeType.file);
    root.children.addAll([indexFile, styleFile, scriptFile]);

    _scratchProject = ProjectModel(id: 'sandbox', name: 'Sandbox', root: root);
    _editorController = EditorController();
    _previewController = PreviewController();
    _consoleController = ConsoleController();

    _editorController.openFile(indexFile);
    _editorController.openFile(styleFile);
    _editorController.openFile(scriptFile);
    _editorController.focusFile(indexFile);
  }

  @override
  void dispose() {
    _editorController.dispose();
    _previewController.dispose();
    _consoleController.dispose();
    super.dispose();
  }

  Future<void> _saveAsProject() async {
    final projectController = widget.projectController;
    if (projectController == null) return;

    final nameController = TextEditingController(text: 'My Sandbox Project');
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save as a project'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Save')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;

    final project = await projectController.createBlankProject(name.trim());
    project.indexHtml?.content = _scratchProject.indexHtml?.content ?? '';
    project.styleCss?.content = _scratchProject.styleCss?.content ?? '';
    project.scriptJs?.content = _scratchProject.scriptJs?.content ?? '';
    await projectController.saveCurrentProject();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved as "$name" — find it from Home.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox'),
        actions: [
          IconButton(
            tooltip: _splitView ? 'Hide preview' : 'Show preview',
            icon: Icon(_splitView ? Icons.vertical_split : Icons.splitscreen_outlined),
            onPressed: () => setState(() => _splitView = !_splitView),
          ),
          if (widget.projectController != null)
            IconButton(tooltip: 'Save as project', icon: const Icon(Icons.save_outlined), onPressed: _saveAsProject),
        ],
      ),
      body: AnimatedBuilder(
        animation: _editorController,
        builder: (context, _) {
          final activeFile = _editorController.activeFile;
          if (activeFile == null) return const SizedBox.shrink();

          final editor = CodeEditorWidget(
            key: ValueKey(activeFile.id),
            file: activeFile,
            onChanged: (text) {
              _editorController.updateContent(activeFile, text);
              if (_splitView) _previewController.refresh();
            },
            onUndo: () => _editorController.undo(activeFile),
            onRedo: () => _editorController.redo(activeFile),
            canUndo: _editorController.canUndo(activeFile),
            canRedo: _editorController.canRedo(activeFile),
          );

          return Column(
            children: [
              EditorTabBar(
                tabs: _editorController.openTabs,
                activeFileId: _editorController.activeFileId,
                onTabSelected: (tab) => _editorController.focusFile(tab.file),
                onTabClosed: (tab) => _editorController.closeFile(tab.file),
              ),
              Expanded(
                child: _splitView
                    ? Column(
                        children: [
                          Expanded(flex: 3, child: editor),
                          Container(height: 3, color: Colors.black),
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.grey.shade200,
                              child: WebviewPreview(
                                project: _scratchProject,
                                previewController: _previewController,
                                consoleController: _consoleController,
                                showDeviceFrame: false,
                              ),
                            ),
                          ),
                        ],
                      )
                    : editor,
              ),
            ],
          );
        },
      ),
    );
  }
}
