import 'dart:async';
import 'package:flutter/material.dart';
import '../controllers/console_controller.dart';
import '../controllers/editor_controller.dart';
import '../controllers/preview_controller.dart';
import '../controllers/project_controller.dart';
import '../models/file_node_model.dart';
import '../editor/code_editor_widget.dart';
import '../editor/syntax_highlighter.dart';
import '../preview/webview_preview.dart';
import '../widgets/editor_tab_bar.dart';
import '../widgets/quick_reference_panel.dart';
import 'preview_screen.dart';
import 'publish_screen.dart';

/// The main coding workspace: a multi-file, multi-tab code editor over
/// the currently open project. Wraps [EditorController] state and wires
/// edits back into the project's file tree and local storage.
///
/// Supports an optional split view — code on top, a live auto-refreshing
/// preview below — a per-language Quick Reference glossary, and a
/// Publish entry point for making the project a real, live website.
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

  bool _splitView = false;
  Timer? _debounceTimer;

  static const Duration _liveRefreshDelay = Duration(milliseconds: 500);

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
    _debounceTimer?.cancel();
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

  /// Called on every keystroke. In split view, schedules a debounced
  /// live preview refresh so the WebView doesn't reload on every single
  /// character — only once typing pauses briefly.
  void _scheduleLiveRefresh() {
    if (!_splitView) return;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_liveRefreshDelay, () {
      if (mounted) _previewController.refresh();
    });
  }

  void _openFullPreview() {
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

  Future<void> _openPublish() async {
    await _saveAll();
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PublishScreen(projectController: widget.projectController),
      ),
    );
  }

  void _showQuickReference(FileNode file) {
    final language = SyntaxHighlighter.languageForExtension(file.extension);
    QuickReferencePanel.show(context, language);
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
          IconButton(
            tooltip: _splitView ? 'Hide live preview' : 'Show live preview',
            icon: Icon(_splitView ? Icons.vertical_split : Icons.splitscreen_outlined),
            onPressed: () => setState(() => _splitView = !_splitView),
          ),
          IconButton(tooltip: 'Save', icon: const Icon(Icons.save_outlined), onPressed: _saveAll),
          IconButton(tooltip: 'Full Preview', icon: const Icon(Icons.play_arrow), onPressed: _openFullPreview),
          IconButton(tooltip: 'Publish', icon: const Icon(Icons.publish_outlined), onPressed: _openPublish),
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
                    : _splitView
                        ? _buildSplitView(activeFile, project)
                        : _buildEditorOnly(activeFile),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _editorController.activeFile == null
          ? null
          : FloatingActionButton.small(
              tooltip: 'Quick Reference',
              onPressed: () => _showQuickReference(_editorController.activeFile!),
              child: const Icon(Icons.help_outline),
            ),
    );
  }

  Widget _buildEditorOnly(FileNode activeFile) {
    return CodeEditorWidget(
      key: ValueKey(activeFile.id),
      file: activeFile,
      onChanged: (text) {
        _editorController.updateContent(activeFile, text);
        _scheduleLiveRefresh();
      },
      onUndo: () => _editorController.undo(activeFile),
      onRedo: () => _editorController.redo(activeFile),
      canUndo: _editorController.canUndo(activeFile),
      canRedo: _editorController.canRedo(activeFile),
    );
  }

  Widget _buildSplitView(FileNode activeFile, project) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: CodeEditorWidget(
            key: ValueKey(activeFile.id),
            file: activeFile,
            onChanged: (text) {
              _editorController.updateContent(activeFile, text);
              _scheduleLiveRefresh();
            },
            onUndo: () => _editorController.undo(activeFile),
            onRedo: () => _editorController.redo(activeFile),
            canUndo: _editorController.canUndo(activeFile),
            canRedo: _editorController.canRedo(activeFile),
          ),
        ),
        Container(height: 3, color: Colors.black),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey.shade200,
            child: WebviewPreview(
              project: project,
              previewController: _previewController,
              consoleController: _consoleController,
              showDeviceFrame: false,
            ),
          ),
        ),
      ],
    );
  }
}
