import 'package:flutter/foundation.dart';
import '../models/file_node_model.dart';

/// Represents a single open tab in the multi-file Code Editor.
class EditorTab {
  final FileNode file;

  /// Whether this tab has unsaved changes relative to what's persisted.
  bool isDirty;

  EditorTab({required this.file, this.isDirty = false});
}

/// Manages the state of the Code Editor: which files are open as tabs,
/// which tab is active, undo/redo history per file, and dirty tracking.
///
/// Deliberately contains zero UI code — [CodeEditorWidget] renders based
/// on this controller's state, keeping business logic separate from
/// presentation as required.
class EditorController extends ChangeNotifier {
  final List<EditorTab> _openTabs = [];
  String? _activeFileId;

  /// Per-file undo stacks, keyed by file id. Each entry is a snapshot of
  /// file content prior to an edit.
  final Map<String, List<String>> _undoStacks = {};

  /// Per-file redo stacks, keyed by file id.
  final Map<String, List<String>> _redoStacks = {};

  static const int _maxHistoryLength = 100;

  List<EditorTab> get openTabs => List.unmodifiable(_openTabs);

  /// The file currently shown in the editor, or null if no tabs are open.
  FileNode? get activeFile {
    if (_activeFileId == null) return null;
    try {
      return _openTabs.firstWhere((t) => t.file.id == _activeFileId).file;
    } catch (_) {
      return null;
    }
  }

  String? get activeFileId => _activeFileId;

  /// Opens [file] in a new tab (or focuses its existing tab if already
  /// open), then makes it the active tab.
  void openFile(FileNode file) {
    if (!file.isFile) return;
    final alreadyOpen = _openTabs.any((t) => t.file.id == file.id);
    if (!alreadyOpen) {
      _openTabs.add(EditorTab(file: file));
      _undoStacks.putIfAbsent(file.id, () => []);
      _redoStacks.putIfAbsent(file.id, () => []);
    }
    _activeFileId = file.id;
    notifyListeners();
  }

  /// Closes the tab for [file]. If it was the active tab, focuses the
  /// nearest remaining tab.
  void closeFile(FileNode file) {
    final index = _openTabs.indexWhere((t) => t.file.id == file.id);
    if (index == -1) return;

    _openTabs.removeAt(index);
    _undoStacks.remove(file.id);
    _redoStacks.remove(file.id);

    if (_activeFileId == file.id) {
      if (_openTabs.isEmpty) {
        _activeFileId = null;
      } else {
        final nextIndex = index < _openTabs.length ? index : _openTabs.length - 1;
        _activeFileId = _openTabs[nextIndex].file.id;
      }
    }
    notifyListeners();
  }

  /// Switches the active tab to [file], which must already be open.
  void focusFile(FileNode file) {
    if (!_openTabs.any((t) => t.file.id == file.id)) return;
    _activeFileId = file.id;
    notifyListeners();
  }

  /// Applies an edit to [file]'s content, pushing the previous content
  /// onto its undo stack and clearing its redo stack (standard editor
  /// semantics: a fresh edit invalidates the redo history).
  void updateContent(FileNode file, String newContent) {
    if (newContent == file.content) return;

    final undoStack = _undoStacks.putIfAbsent(file.id, () => []);
    undoStack.add(file.content);
    if (undoStack.length > _maxHistoryLength) undoStack.removeAt(0);

    _redoStacks[file.id]?.clear();

    file.content = newContent;
    file.lastModified = DateTime.now();
    _markDirty(file);
    notifyListeners();
  }

  /// Reverts [file] to its previous content snapshot, if any.
  void undo(FileNode file) {
    final undoStack = _undoStacks[file.id];
    if (undoStack == null || undoStack.isEmpty) return;

    final redoStack = _redoStacks.putIfAbsent(file.id, () => []);
    redoStack.add(file.content);

    file.content = undoStack.removeLast();
    _markDirty(file);
    notifyListeners();
  }

  /// Re-applies the most recently undone change to [file], if any.
  void redo(FileNode file) {
    final redoStack = _redoStacks[file.id];
    if (redoStack == null || redoStack.isEmpty) return;

    final undoStack = _undoStacks.putIfAbsent(file.id, () => []);
    undoStack.add(file.content);

    file.content = redoStack.removeLast();
    _markDirty(file);
    notifyListeners();
  }

  bool canUndo(FileNode file) => (_undoStacks[file.id]?.isNotEmpty) ?? false;
  bool canRedo(FileNode file) => (_redoStacks[file.id]?.isNotEmpty) ?? false;

  /// Marks a tab clean after it has been persisted to storage.
  void markSaved(FileNode file) {
    final tab = _findTab(file.id);
    if (tab != null) {
      tab.isDirty = false;
      notifyListeners();
    }
  }

  void _markDirty(FileNode file) {
    final tab = _findTab(file.id);
    if (tab != null) tab.isDirty = true;
  }

  EditorTab? _findTab(String fileId) {
    try {
      return _openTabs.firstWhere((t) => t.file.id == fileId);
    } catch (_) {
      return null;
    }
  }

  /// True if any open tab has unsaved changes.
  bool get hasUnsavedChanges => _openTabs.any((t) => t.isDirty);

  /// Clears all editor state, e.g. when closing a project entirely.
  void reset() {
    _openTabs.clear();
    _undoStacks.clear();
    _redoStacks.clear();
    _activeFileId = null;
    notifyListeners();
  }
}
