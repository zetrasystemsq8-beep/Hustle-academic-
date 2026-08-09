import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_dataset_lab.dart' show AiProject;

// ============================================================
// AI LAB — Python Workspace
//
// Real: file tree CRUD, Python syntax highlighting, code editing,
// undo/redo, find & replace, persistence to Supabase (ai_workspaces
// table — one row per project, whole tree as jsonb, same shape as
// Mobile Lab's local MobileFileNode tree but server-persisted since
// AI Lab has no local-only storage layer).
//
// NOT real yet, honestly marked: "Run" does not execute Python.
// Execution requires sandboxed container infrastructure — that's
// the Training Pipeline deliverable, not this one.
// ============================================================

// ============================================================
// MODELS
// ============================================================

enum AiFileNodeType { file, folder }

class AiWorkspaceFileNode {
  final String id;
  String name;
  final AiFileNodeType type;
  String content;
  List<AiWorkspaceFileNode> children;
  bool isExpanded;
  DateTime lastModified;

  AiWorkspaceFileNode({
    required this.id,
    required this.name,
    required this.type,
    this.content = '',
    List<AiWorkspaceFileNode>? children,
    this.isExpanded = false,
    DateTime? lastModified,
  })  : children = children ?? <AiWorkspaceFileNode>[],
        lastModified = lastModified ?? DateTime.now();

  bool get isFolder => type == AiFileNodeType.folder;
  bool get isFile => type == AiFileNodeType.file;

  String get extension {
    if (isFolder) return '';
    final dot = name.lastIndexOf('.');
    if (dot == -1 || dot == name.length - 1) return '';
    return name.substring(dot + 1).toLowerCase();
  }

  AiWorkspaceFileNode deepCopy({String? newId, String? newName}) {
    return AiWorkspaceFileNode(
      id: newId ?? _generateId(),
      name: newName ?? name,
      type: type,
      content: content,
      children: children.map((c) => c.deepCopy()).toList(),
      isExpanded: isExpanded,
      lastModified: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type.name,
        'content': content,
        'children': children.map((c) => c.toJson()).toList(),
        'isExpanded': isExpanded,
        'lastModified': lastModified.toIso8601String(),
      };

  factory AiWorkspaceFileNode.fromJson(Map<String, dynamic> json) {
    return AiWorkspaceFileNode(
      id: json['id'] as String,
      name: json['name'] as String,
      type: AiFileNodeType.values.byName(json['type'] as String),
      content: json['content'] as String? ?? '',
      children: (json['children'] as List<dynamic>? ?? [])
          .map((c) => AiWorkspaceFileNode.fromJson(c as Map<String, dynamic>))
          .toList(),
      isExpanded: json['isExpanded'] as bool? ?? false,
      lastModified: DateTime.tryParse(json['lastModified'] as String? ?? '') ?? DateTime.now(),
    );
  }

  static String _generateId() =>
      '${DateTime.now().microsecondsSinceEpoch}_${identityHashCode(Object())}';

  @override
  bool operator ==(Object other) => other is AiWorkspaceFileNode && other.id == id;
  @override
  int get hashCode => id.hashCode;
}

/// The whole workspace = one root folder tree, scoped to what an AI
/// project actually needs: src/, requirements.txt, README.md.
/// Datasets are NOT part of this tree — they live in ai_datasets /
/// the ai-datasets Storage bucket (previous deliverable), referenced
/// by path from code, same separation real ML projects use.
class AiWorkspace {
  final String projectId;
  AiWorkspaceFileNode root;
  DateTime updatedAt;

  AiWorkspace({
    required this.projectId,
    required this.root,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  static AiWorkspaceFileNode buildStarterTree(String projectName) {
    final root = AiWorkspaceFileNode(
      id: AiWorkspaceFileNode._generateId(),
      name: projectName,
      type: AiFileNodeType.folder,
      isExpanded: true,
    );

    final src = AiWorkspaceFileNode(
      id: AiWorkspaceFileNode._generateId(),
      name: 'src',
      type: AiFileNodeType.folder,
      isExpanded: true,
    );

    final trainPy = AiWorkspaceFileNode(
      id: AiWorkspaceFileNode._generateId(),
      name: 'train.py',
      type: AiFileNodeType.file,
      content: '''"""
Training entry point for $projectName.

This script is executed by the Training Pipeline as a real job
(CPU, on a GitHub Actions runner) — not simulated locally. Keep
this file runnable end-to-end: load data, build a model, fit it,
report metrics, save the model artifact.
"""

import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
import joblib


def load_dataset(csv_path: str, label_column: str):
    df = pd.read_csv(csv_path)
    X = df.drop(columns=[label_column])
    y = df[label_column]
    return X, y


def main():
    # TODO: replace with your dataset's actual storage path and
    # label column, as configured in Dataset Lab.
    X, y = load_dataset("dataset.csv", label_column="label")

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    model = LogisticRegression(max_iter=1000)
    model.fit(X_train, y_train)

    predictions = model.predict(X_test)
    accuracy = accuracy_score(y_test, predictions)
    print(f"Validation accuracy: {accuracy:.4f}")

    joblib.dump(model, "model.joblib")
    print("Saved model.joblib")


if __name__ == "__main__":
    main()
''',
    );

    final modelPy = AiWorkspaceFileNode(
      id: AiWorkspaceFileNode._generateId(),
      name: 'model.py',
      type: AiFileNodeType.file,
      content: '''"""
Model definition for $projectName.

Keep model construction separate from the training loop so it can
be reused for inference/evaluation without re-running train.py.
"""

from sklearn.linear_model import LogisticRegression


def build_model():
    return LogisticRegression(max_iter=1000)
''',
    );

    src.children.addAll([trainPy, modelPy]);
    root.children.add(src);

    final requirements = AiWorkspaceFileNode(
      id: AiWorkspaceFileNode._generateId(),
      name: 'requirements.txt',
      type: AiFileNodeType.file,
      content: '''pandas
scikit-learn
joblib
numpy
''',
    );
    root.children.add(requirements);

    final readme = AiWorkspaceFileNode(
      id: AiWorkspaceFileNode._generateId(),
      name: 'README.md',
      type: AiFileNodeType.file,
      content: '''# $projectName

An AI project built in AI Lab.

## Structure

- `src/train.py` — training entry point
- `src/model.py` — model definition
- `requirements.txt` — Python dependencies

## Training

Training runs as a real job on the Training Pipeline once you press
Train in the project dashboard — it is not simulated locally.
''',
    );
    root.children.add(readme);

    return root;
  }
}

// ============================================================
// REPOSITORY — Supabase-backed (one row per project)
// ============================================================

class AiWorkspaceRepository {
  final SupabaseClient supabase;
  AiWorkspaceRepository(this.supabase);

  Future<AiWorkspace> loadOrCreate(AiProject project) async {
    final response = await supabase
        .from('ai_workspaces')
        .select()
        .eq('project_id', project.id)
        .maybeSingle();

    if (response != null) {
      return AiWorkspace(
        projectId: project.id,
        root: AiWorkspaceFileNode.fromJson(response['root_json'] as Map<String, dynamic>),
        updatedAt: DateTime.tryParse(response['updated_at'] as String? ?? '') ?? DateTime.now(),
      );
    }

    final root = AiWorkspace.buildStarterTree(project.name);
    final workspace = AiWorkspace(projectId: project.id, root: root);
    await supabase.from('ai_workspaces').insert({
      'project_id': project.id,
      'root_json': workspace.root.toJson(),
      'updated_at': workspace.updatedAt.toIso8601String(),
    });
    return workspace;
  }

  Future<void> save(AiWorkspace workspace) async {
    workspace.updatedAt = DateTime.now();
    await supabase.from('ai_workspaces').update({
      'root_json': workspace.root.toJson(),
      'updated_at': workspace.updatedAt.toIso8601String(),
    }).eq('project_id', workspace.projectId);
  }
}

// ============================================================
// FILE SYSTEM OPERATIONS
// ============================================================

class AiWorkspaceFileSystemService {
  String generateId() => AiWorkspaceFileNode._generateId();

  AiWorkspaceFileNode createFile(AiWorkspaceFileNode parent, String name) {
    _assertUniqueName(parent, name);
    final node = AiWorkspaceFileNode(id: generateId(), name: name, type: AiFileNodeType.file);
    parent.children.add(node);
    return node;
  }

  AiWorkspaceFileNode createFolder(AiWorkspaceFileNode parent, String name) {
    _assertUniqueName(parent, name);
    final node = AiWorkspaceFileNode(id: generateId(), name: name, type: AiFileNodeType.folder);
    parent.children.add(node);
    return node;
  }

  void renameNode(AiWorkspaceFileNode parent, AiWorkspaceFileNode node, String newName) {
    if (newName == node.name) return;
    _assertUniqueName(parent, newName, excluding: node);
    node.name = newName;
    node.lastModified = DateTime.now();
  }

  void deleteNode(AiWorkspaceFileNode parent, AiWorkspaceFileNode node) {
    parent.children.removeWhere((c) => c.id == node.id);
  }

  AiWorkspaceFileNode duplicateNode(AiWorkspaceFileNode parent, AiWorkspaceFileNode node) {
    final baseName = _stripExtension(node.name);
    final ext = node.extension.isEmpty ? '' : '.${node.extension}';
    var candidate = '$baseName copy$ext';
    var counter = 2;
    while (parent.children.any((c) => c.name == candidate)) {
      candidate = '$baseName copy $counter$ext';
      counter++;
    }
    final copy = node.deepCopy(newId: generateId(), newName: candidate);
    parent.children.add(copy);
    return copy;
  }

  void toggleExpanded(AiWorkspaceFileNode folder) {
    if (!folder.isFolder) return;
    folder.isExpanded = !folder.isExpanded;
  }

  void _assertUniqueName(AiWorkspaceFileNode parent, String name, {AiWorkspaceFileNode? excluding}) {
    final clash = parent.children.any((c) => c.name == name && (excluding == null || c.id != excluding.id));
    if (clash) throw ArgumentError('"$name" already exists in this folder.');
  }

  String _stripExtension(String name) {
    final dot = name.lastIndexOf('.');
    if (dot <= 0) return name;
    return name.substring(0, dot);
  }
}

// ============================================================
// PYTHON SYNTAX HIGHLIGHTING — real tokenizer
// ============================================================

enum AiPyTokenType { plain, keyword, builtin, string, number, comment, decorator, punctuation, selfParam }

class AiPySyntaxToken {
  final String text;
  final AiPyTokenType type;
  const AiPySyntaxToken(this.text, this.type);
}

class AiPythonSyntaxHighlighter {
  static const Set<String> _keywords = {
    'False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await', 'break',
    'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'finally',
    'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'nonlocal',
    'not', 'or', 'pass', 'raise', 'return', 'try', 'while', 'with', 'yield',
  };

  static const Set<String> _builtins = {
    'print', 'len', 'range', 'str', 'int', 'float', 'bool', 'list', 'dict',
    'set', 'tuple', 'open', 'type', 'isinstance', 'enumerate', 'zip', 'map',
    'filter', 'sum', 'min', 'max', 'sorted', 'reversed', 'super', 'input',
  };

  // Order matters: triple-quoted strings must be matched before single/double,
  // f-strings before plain strings.
  static final RegExp _pattern = RegExp(
    r'(#.*$)'
    r"|('''[\s\S]*?'''|" r'"""[\s\S]*?""")'
    r'|((?:f|r|b|rb|fr)?"(?:[^"\\]|\\.)*"|(?:f|r|b|rb|fr)?' r"'(?:[^'\\]|\\.)*')"
    r'|(@[a-zA-Z_][a-zA-Z0-9_.]*)'
    r'|(\b\d+\.?\d*\b)'
    r'|([{}()\[\]:;,.])'
    r'|(\bself\b)'
    r'|(\b[a-zA-Z_][a-zA-Z0-9_]*\b)',
    multiLine: true,
  );

  static List<AiPySyntaxToken> tokenize(String source) {
    final tokens = <AiPySyntaxToken>[];
    var lastEnd = 0;
    for (final match in _pattern.allMatches(source)) {
      if (match.start > lastEnd) {
        tokens.add(AiPySyntaxToken(source.substring(lastEnd, match.start), AiPyTokenType.plain));
      }
      tokens.add(AiPySyntaxToken(match.group(0)!, _classify(match)));
      lastEnd = match.end;
    }
    if (lastEnd < source.length) {
      tokens.add(AiPySyntaxToken(source.substring(lastEnd), AiPyTokenType.plain));
    }
    return tokens;
  }

  static AiPyTokenType _classify(RegExpMatch match) {
    if (match.group(1) != null) return AiPyTokenType.comment;
    if (match.group(2) != null) return AiPyTokenType.string;
    if (match.group(3) != null) return AiPyTokenType.string;
    if (match.group(4) != null) return AiPyTokenType.decorator;
    if (match.group(5) != null) return AiPyTokenType.number;
    if (match.group(6) != null) return AiPyTokenType.punctuation;
    if (match.group(7) != null) return AiPyTokenType.selfParam;
    if (match.group(8) != null) {
      final word = match.group(8)!;
      if (_keywords.contains(word)) return AiPyTokenType.keyword;
      if (_builtins.contains(word)) return AiPyTokenType.builtin;
      return AiPyTokenType.plain;
    }
    return AiPyTokenType.plain;
  }
}

class AiPyColorScheme {
  final TextStyle baseStyle;
  final Color keyword, builtin, string, number, comment, decorator, punctuation, selfParam;

  const AiPyColorScheme({
    required this.baseStyle,
    required this.keyword,
    required this.builtin,
    required this.string,
    required this.number,
    required this.comment,
    required this.decorator,
    required this.punctuation,
    required this.selfParam,
  });

  factory AiPyColorScheme.dark() => const AiPyColorScheme(
        baseStyle: TextStyle(color: Color(0xFFD4D4D4), fontFamily: 'monospace', fontSize: 14, height: 1.5),
        keyword: Color(0xFF569CD6),
        builtin: Color(0xFF4EC9B0),
        string: Color(0xFFCE9178),
        number: Color(0xFFB5CEA8),
        comment: Color(0xFF6A9955),
        decorator: Color(0xFFDCDCAA),
        punctuation: Color(0xFFD4D4D4),
        selfParam: Color(0xFF9CDCFE),
      );

  TextStyle styleFor(AiPyTokenType type) {
    final color = switch (type) {
      AiPyTokenType.plain => baseStyle.color,
      AiPyTokenType.keyword => keyword,
      AiPyTokenType.builtin => builtin,
      AiPyTokenType.string => string,
      AiPyTokenType.number => number,
      AiPyTokenType.comment => comment,
      AiPyTokenType.decorator => decorator,
      AiPyTokenType.punctuation => punctuation,
      AiPyTokenType.selfParam => selfParam,
    };
    final fontStyle = type == AiPyTokenType.comment ? FontStyle.italic : FontStyle.normal;
    return baseStyle.copyWith(color: color, fontStyle: fontStyle);
  }
}

// ============================================================
// EDITOR STATE — tabs, undo/redo, search (same design as Mobile
// Lab's MobileEditorController, retyped for AiWorkspaceFileNode)
// ============================================================

class AiEditorTab {
  final AiWorkspaceFileNode file;
  bool isDirty;
  AiEditorTab({required this.file, this.isDirty = false});
}

class AiEditorController extends ChangeNotifier {
  final List<AiEditorTab> _openTabs = [];
  String? _activeFileId;
  final Map<String, List<String>> _undoStacks = {};
  final Map<String, List<String>> _redoStacks = {};
  static const int _maxHistoryLength = 100;

  List<AiEditorTab> get openTabs => List.unmodifiable(_openTabs);
  String? get activeFileId => _activeFileId;

  AiWorkspaceFileNode? get activeFile {
    if (_activeFileId == null) return null;
    try {
      return _openTabs.firstWhere((t) => t.file.id == _activeFileId).file;
    } catch (_) {
      return null;
    }
  }

  void openFile(AiWorkspaceFileNode file) {
    if (!file.isFile) return;
    if (!_openTabs.any((t) => t.file.id == file.id)) {
      _openTabs.add(AiEditorTab(file: file));
      _undoStacks.putIfAbsent(file.id, () => []);
      _redoStacks.putIfAbsent(file.id, () => []);
    }
    _activeFileId = file.id;
    notifyListeners();
  }

  void closeFile(AiWorkspaceFileNode file) {
    final index = _openTabs.indexWhere((t) => t.file.id == file.id);
    if (index == -1) return;
    _openTabs.removeAt(index);
    _undoStacks.remove(file.id);
    _redoStacks.remove(file.id);
    if (_activeFileId == file.id) {
      _activeFileId = _openTabs.isEmpty
          ? null
          : _openTabs[index < _openTabs.length ? index : _openTabs.length - 1].file.id;
    }
    notifyListeners();
  }

  void focusFile(AiWorkspaceFileNode file) {
    if (!_openTabs.any((t) => t.file.id == file.id)) return;
    _activeFileId = file.id;
    notifyListeners();
  }

  void updateContent(AiWorkspaceFileNode file, String newContent) {
    if (newContent == file.content) return;
    final undoStack = _undoStacks.putIfAbsent(file.id, () => []);
    undoStack.add(file.content);
    if (undoStack.length > _maxHistoryLength) undoStack.removeAt(0);
    _redoStacks[file.id]?.clear();
    file.content = newContent;
    file.lastModified = DateTime.now();
    _findTab(file.id)?.isDirty = true;
    notifyListeners();
  }

  void undo(AiWorkspaceFileNode file) {
    final undoStack = _undoStacks[file.id];
    if (undoStack == null || undoStack.isEmpty) return;
    _redoStacks.putIfAbsent(file.id, () => []).add(file.content);
    file.content = undoStack.removeLast();
    _findTab(file.id)?.isDirty = true;
    notifyListeners();
  }

  void redo(AiWorkspaceFileNode file) {
    final redoStack = _redoStacks[file.id];
    if (redoStack == null || redoStack.isEmpty) return;
    _undoStacks.putIfAbsent(file.id, () => []).add(file.content);
    file.content = redoStack.removeLast();
    _findTab(file.id)?.isDirty = true;
    notifyListeners();
  }

  bool canUndo(AiWorkspaceFileNode file) => (_undoStacks[file.id]?.isNotEmpty) ?? false;
  bool canRedo(AiWorkspaceFileNode file) => (_redoStacks[file.id]?.isNotEmpty) ?? false;

  void markSaved(AiWorkspaceFileNode file) {
    final tab = _findTab(file.id);
    if (tab != null) {
      tab.isDirty = false;
      notifyListeners();
    }
  }

  bool get hasUnsavedChanges => _openTabs.any((t) => t.isDirty);

  AiEditorTab? _findTab(String fileId) {
    try {
      return _openTabs.firstWhere((t) => t.file.id == fileId);
    } catch (_) {
      return null;
    }
  }
}

class AiSearchMatch {
  final int start;
  final int end;
  const AiSearchMatch(this.start, this.end);
}

class AiEditorSearchEngine {
  static List<AiSearchMatch> findAll(String source, String query) {
    if (query.isEmpty) return [];
    final matches = <AiSearchMatch>[];
    final lowerSource = source.toLowerCase();
    final lowerQuery = query.toLowerCase();
    var start = 0;
    while (true) {
      final index = lowerSource.indexOf(lowerQuery, start);
      if (index == -1) break;
      matches.add(AiSearchMatch(index, index + query.length));
      start = index + query.length;
    }
    return matches;
  }

  static String replaceOne(String source, AiSearchMatch match, String replacement) =>
      source.replaceRange(match.start, match.end, replacement);

  static String replaceAll(String source, String query, String replacement) {
    if (query.isEmpty) return source;
    return source.replaceAll(RegExp(RegExp.escape(query), caseSensitive: false), replacement);
  }
}

// ============================================================
// FILE ICONS
// ============================================================

class AiFileIcons {
  static IconData iconFor(AiWorkspaceFileNode node) {
    if (node.isFolder) return node.isExpanded ? Icons.folder_open : Icons.folder;
    switch (node.extension) {
      case 'py':
        return Icons.code;
      case 'txt':
        return Icons.description_outlined;
      case 'md':
        return Icons.article_outlined;
      case 'yaml':
      case 'yml':
        return Icons.settings_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  static Color colorFor(AiWorkspaceFileNode node) {
    if (node.isFolder) return const Color(0xFFDCB67A);
    switch (node.extension) {
      case 'py':
        return const Color(0xFF3776AB);
      case 'txt':
        return const Color(0xFFB0B0B0);
      case 'md':
        return const Color(0xFF519ABA);
      default:
        return const Color(0xFFB0B0B0);
    }
  }
}

// ============================================================
// SEARCH BAR WIDGET
// ============================================================

class AiEditorSearchBar extends StatefulWidget {
  final int matchCount;
  final int currentIndex;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final ValueChanged<String> onReplaceOne;
  final ValueChanged<String> onReplaceAll;
  final VoidCallback onClose;

  const AiEditorSearchBar({
    super.key,
    required this.matchCount,
    required this.currentIndex,
    required this.onQueryChanged,
    required this.onNext,
    required this.onPrevious,
    required this.onReplaceOne,
    required this.onReplaceAll,
    required this.onClose,
  });

  @override
  State<AiEditorSearchBar> createState() => _AiEditorSearchBarState();
}

class _AiEditorSearchBarState extends State<AiEditorSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _replaceController = TextEditingController();
  bool _showReplace = false;

  @override
  void dispose() {
    _searchController.dispose();
    _replaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasMatches = widget.matchCount > 0;

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: const InputDecoration(isDense: true, hintText: 'Find', border: OutlineInputBorder()),
                    onChanged: widget.onQueryChanged,
                  ),
                ),
                const SizedBox(width: 8),
                Text('${hasMatches ? widget.currentIndex + 1 : 0}/${widget.matchCount}'),
                IconButton(icon: const Icon(Icons.keyboard_arrow_up), onPressed: hasMatches ? widget.onPrevious : null),
                IconButton(icon: const Icon(Icons.keyboard_arrow_down), onPressed: hasMatches ? widget.onNext : null),
                IconButton(icon: Icon(_showReplace ? Icons.expand_less : Icons.expand_more), onPressed: () => setState(() => _showReplace = !_showReplace)),
                IconButton(icon: const Icon(Icons.close), onPressed: widget.onClose),
              ],
            ),
            if (_showReplace) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(child: TextField(controller: _replaceController, decoration: const InputDecoration(isDense: true, hintText: 'Replace', border: OutlineInputBorder()))),
                  const SizedBox(width: 8),
                  TextButton(onPressed: hasMatches ? () => widget.onReplaceOne(_replaceController.text) : null, child: const Text('Replace')),
                  TextButton(onPressed: hasMatches ? () => widget.onReplaceAll(_replaceController.text) : null, child: const Text('All')),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CODE EDITOR WIDGET
// ============================================================

class AiCodeEditorWidget extends StatefulWidget {
  final AiWorkspaceFileNode file;
  final ValueChanged<String> onChanged;
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final bool canUndo;
  final bool canRedo;

  const AiCodeEditorWidget({
    super.key,
    required this.file,
    required this.onChanged,
    this.onUndo,
    this.onRedo,
    this.canUndo = false,
    this.canRedo = false,
  });

  @override
  State<AiCodeEditorWidget> createState() => _AiCodeEditorWidgetState();
}

class _AiCodeEditorWidgetState extends State<AiCodeEditorWidget> {
  late TextEditingController _controller;
  final ScrollController _codeScrollController = ScrollController();
  final ScrollController _lineNumberScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  bool _showSearch = false;
  String _searchQuery = '';
  List<AiSearchMatch> _matches = [];
  int _currentMatchIndex = 0;

  static const Map<String, String> _bracketPairs = {'(': ')', '[': ']', '{': '}'};

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.file.content);
    _codeScrollController.addListener(_syncLineNumberScroll);
  }

  @override
  void didUpdateWidget(covariant AiCodeEditorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file.id != widget.file.id || _controller.text != widget.file.content) {
      final selection = _controller.selection;
      _controller.text = widget.file.content;
      if (selection.start <= widget.file.content.length) _controller.selection = selection;
      if (oldWidget.file.id != widget.file.id) {
        _showSearch = false;
        _searchQuery = '';
        _matches = [];
        _currentMatchIndex = 0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _codeScrollController.dispose();
    _lineNumberScrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _syncLineNumberScroll() {
    if (_lineNumberScrollController.hasClients) {
      _lineNumberScrollController.jumpTo(_codeScrollController.offset);
    }
  }

  int get _lineCount => '\n'.allMatches(_controller.text).length + 1;

  void _handleChanged(String newText) {
    widget.onChanged(newText);
    if (_searchQuery.isNotEmpty) _recomputeMatches();
  }

  void _handleBracketAutoClose(String typed) {
    if (!_bracketPairs.containsKey(typed)) return;
    final closing = _bracketPairs[typed]!;
    final selection = _controller.selection;
    final text = _controller.text;
    final newText = text.replaceRange(selection.start, selection.start, closing);
    _controller.value = TextEditingValue(text: newText, selection: TextSelection.collapsed(offset: selection.start));
  }

  /// Python cares about indentation semantically, so this is more
  /// than cosmetic: preserves current indent, adds one level after
  /// a line ending in ':' (def/class/if/for/while/etc).
  void _handleNewLine() {
    final selection = _controller.selection;
    final text = _controller.text;
    final beforeCursor = text.substring(0, selection.start);
    final lastNewline = beforeCursor.lastIndexOf('\n');
    final currentLine = beforeCursor.substring(lastNewline + 1);
    final leadingWhitespace = RegExp(r'^[ \t]*').stringMatch(currentLine) ?? '';
    final extraIndent = currentLine.trimRight().endsWith(':') ? '    ' : '';
    final insertion = '\n$leadingWhitespace$extraIndent';
    final newText = text.replaceRange(selection.start, selection.start, insertion);
    final newOffset = selection.start + insertion.length;
    _controller.value = TextEditingValue(text: newText, selection: TextSelection.collapsed(offset: newOffset));
    widget.onChanged(newText);
  }

  void _recomputeMatches() {
    setState(() {
      _matches = AiEditorSearchEngine.findAll(_controller.text, _searchQuery);
      if (_matches.isEmpty) {
        _currentMatchIndex = 0;
      } else if (_currentMatchIndex >= _matches.length) {
        _currentMatchIndex = 0;
      }
    });
    if (_matches.isNotEmpty) _selectMatch(_matches[_currentMatchIndex]);
  }

  void _selectMatch(AiSearchMatch match) {
    _controller.selection = TextSelection(baseOffset: match.start, extentOffset: match.end);
  }

  void _onSearchQueryChanged(String query) {
    _searchQuery = query;
    _recomputeMatches();
  }

  void _goToNextMatch() {
    if (_matches.isEmpty) return;
    setState(() => _currentMatchIndex = (_currentMatchIndex + 1) % _matches.length);
    _selectMatch(_matches[_currentMatchIndex]);
  }

  void _goToPreviousMatch() {
    if (_matches.isEmpty) return;
    setState(() => _currentMatchIndex = (_currentMatchIndex - 1 + _matches.length) % _matches.length);
    _selectMatch(_matches[_currentMatchIndex]);
  }

  void _replaceCurrentMatch(String replacement) {
    if (_matches.isEmpty) return;
    final match = _matches[_currentMatchIndex];
    final newText = AiEditorSearchEngine.replaceOne(_controller.text, match, replacement);
    final newOffset = match.start + replacement.length;
    _controller.value = TextEditingValue(text: newText, selection: TextSelection.collapsed(offset: newOffset));
    widget.onChanged(newText);
    _recomputeMatches();
  }

  void _replaceAllMatches(String replacement) {
    if (_searchQuery.isEmpty) return;
    final newText = AiEditorSearchEngine.replaceAll(_controller.text, _searchQuery, replacement);
    _controller.value = TextEditingValue(text: newText, selection: TextSelection.collapsed(offset: newText.length));
    widget.onChanged(newText);
    _recomputeMatches();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AiPyColorScheme.dark();

    return Container(
      color: const Color(0xFF1E1E1E),
      child: Stack(
        children: [
          Column(
            children: [
              _buildToolbar(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buildLineNumbers(colors), Expanded(child: _buildCodeField(colors))],
                ),
              ),
            ],
          ),
          if (_showSearch)
            Positioned(
              top: 48,
              left: 8,
              right: 8,
              child: AiEditorSearchBar(
                matchCount: _matches.length,
                currentIndex: _currentMatchIndex,
                onQueryChanged: _onSearchQueryChanged,
                onNext: _goToNextMatch,
                onPrevious: _goToPreviousMatch,
                onReplaceOne: _replaceCurrentMatch,
                onReplaceAll: _replaceAllMatches,
                onClose: () => setState(() {
                  _showSearch = false;
                  _searchQuery = '';
                  _matches = [];
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    final isPython = widget.file.extension == 'py';
    return Container(
      height: 40,
      color: const Color(0xFF252526),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(widget.file.name, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          const Spacer(),
          IconButton(tooltip: 'Undo', icon: const Icon(Icons.undo, size: 18, color: Colors.white70), onPressed: widget.canUndo ? widget.onUndo : null),
          IconButton(tooltip: 'Redo', icon: const Icon(Icons.redo, size: 18, color: Colors.white70), onPressed: widget.canRedo ? widget.onRedo : null),
          IconButton(tooltip: 'Find & Replace', icon: const Icon(Icons.search, size: 18, color: Colors.white70), onPressed: () => setState(() => _showSearch = !_showSearch)),
          if (isPython)
            IconButton(
              tooltip: 'Run (coming soon — needs the Training Pipeline)',
              icon: const Icon(Icons.play_arrow, size: 18, color: Colors.white24),
              onPressed: null,
            ),
        ],
      ),
    );
  }

  Widget _buildLineNumbers(AiPyColorScheme colors) {
    return Container(
      width: 44,
      color: const Color(0xFF1E1E1E),
      child: SingleChildScrollView(
        controller: _lineNumberScrollController,
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              _lineCount,
              (i) => Text('${i + 1}', style: colors.baseStyle.copyWith(color: Colors.white24, fontSize: 13)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeField(AiPyColorScheme colors) {
    return SingleChildScrollView(
      controller: _codeScrollController,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          maxLines: null,
          minLines: 20,
          cursorColor: Colors.white,
          style: colors.baseStyle,
          decoration: const InputDecoration(isDense: true, border: InputBorder.none),
          onChanged: (text) {
            final selectionOffset = _controller.selection.baseOffset;
            _handleChanged(text);
            if (text.length > widget.file.content.length && selectionOffset > 0) {
              final added = text[selectionOffset - 1];
              if (added == '\n') {
                _handleNewLine();
              } else if (_bracketPairs.containsKey(added)) {
                _handleBracketAutoClose(added);
              }
            }
          },
          buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
        ),
      ),
    );
  }
}

// ============================================================
// FILE TREE WIDGET
// ============================================================

class AiFileTreeWidget extends StatelessWidget {
  final AiWorkspaceFileNode root;
  final String? activeFileId;
  final ValueChanged<AiWorkspaceFileNode> onFileTap;
  final ValueChanged<AiWorkspaceFileNode> onToggleFolder;
  final void Function(AiWorkspaceFileNode parent, AiWorkspaceFileNode node) onRename;
  final void Function(AiWorkspaceFileNode parent, AiWorkspaceFileNode node) onDelete;
  final void Function(AiWorkspaceFileNode parent, AiWorkspaceFileNode node) onDuplicate;
  final void Function(AiWorkspaceFileNode parent) onCreateFile;
  final void Function(AiWorkspaceFileNode parent) onCreateFolder;

  const AiFileTreeWidget({
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
  });

  @override
  Widget build(BuildContext context) {
    final rows = _buildChildRows(root, depth: 0);
    if (rows.isEmpty) {
      return const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('This project has no files yet.', style: TextStyle(color: Colors.grey))));
    }
    return ListView(padding: const EdgeInsets.symmetric(vertical: 8), children: rows);
  }

  List<Widget> _buildChildRows(AiWorkspaceFileNode node, {required int depth}) {
    final widgets = <Widget>[];
    for (final child in node.children) {
      widgets.add(_buildRow(node, child, depth));
      if (child.isFolder && child.isExpanded) widgets.addAll(_buildChildRows(child, depth: depth + 1));
    }
    return widgets;
  }

  Widget _buildRow(AiWorkspaceFileNode parent, AiWorkspaceFileNode node, int depth) {
    return _AiFileTreeRow(
      node: node,
      depth: depth,
      isActive: node.id == activeFileId,
      onTap: () => node.isFolder ? onToggleFolder(node) : onFileTap(node),
      onRename: () => onRename(parent, node),
      onDelete: () => onDelete(parent, node),
      onDuplicate: () => onDuplicate(parent, node),
      onCreateFile: node.isFolder ? () => onCreateFile(node) : null,
      onCreateFolder: node.isFolder ? () => onCreateFolder(node) : null,
    );
  }
}

class _AiFileTreeRow extends StatelessWidget {
  final AiWorkspaceFileNode node;
  final int depth;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onDuplicate;
  final VoidCallback? onCreateFile;
  final VoidCallback? onCreateFolder;

  const _AiFileTreeRow({
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
                Icon(node.isExpanded ? Icons.expand_more : Icons.chevron_right, size: 18, color: theme.colorScheme.onSurfaceVariant)
              else
                const SizedBox(width: 18),
              const SizedBox(width: 4),
              Icon(AiFileIcons.iconFor(node), size: 18, color: AiFileIcons.colorFor(node)),
              const SizedBox(width: 8),
              Expanded(child: Text(node.name, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyMedium)),
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

// ============================================================
// SCREENS
// ============================================================

class AiWorkspaceExplorerScreen extends StatefulWidget {
  final AiProject project;
  const AiWorkspaceExplorerScreen({super.key, required this.project});

  @override
  State<AiWorkspaceExplorerScreen> createState() => _AiWorkspaceExplorerScreenState();
}

class _AiWorkspaceExplorerScreenState extends State<AiWorkspaceExplorerScreen> {
  late final AiWorkspaceRepository _repository;
  final AiWorkspaceFileSystemService _fileSystem = AiWorkspaceFileSystemService();
  AiWorkspace? _workspace;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _repository = AiWorkspaceRepository(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    final workspace = await _repository.loadOrCreate(widget.project);
    if (!mounted) return;
    setState(() {
      _workspace = workspace;
      _isLoading = false;
    });
  }

  Future<void> _persist() async {
    if (_workspace == null) return;
    await _repository.save(_workspace!);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

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
          FilledButton(style: FilledButton.styleFrom(backgroundColor: Colors.red), onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _createFile(AiWorkspaceFileNode parent) async {
    final name = await _promptForName('New File');
    if (name == null || name.trim().isEmpty) return;
    try {
      _fileSystem.createFile(parent, name.trim());
      setState(() {});
      await _persist();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _createFolder(AiWorkspaceFileNode parent) async {
    final name = await _promptForName('New Folder');
    if (name == null || name.trim().isEmpty) return;
    try {
      _fileSystem.createFolder(parent, name.trim());
      setState(() {});
      await _persist();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _rename(AiWorkspaceFileNode parent, AiWorkspaceFileNode node) async {
    final name = await _promptForName('Rename', initial: node.name);
    if (name == null || name.trim().isEmpty) return;
    try {
      _fileSystem.renameNode(parent, node, name.trim());
      setState(() {});
      await _persist();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _delete(AiWorkspaceFileNode parent, AiWorkspaceFileNode node) async {
    final confirmed = await _confirmDelete(node.name);
    if (!confirmed) return;
    _fileSystem.deleteNode(parent, node);
    setState(() {});
    await _persist();
  }

  Future<void> _duplicate(AiWorkspaceFileNode parent, AiWorkspaceFileNode node) async {
    _fileSystem.duplicateNode(parent, node);
    setState(() {});
    await _persist();
  }

  void _toggleFolder(AiWorkspaceFileNode node) {
    _fileSystem.toggleExpanded(node);
    setState(() {});
  }

  void _openInEditor(AiWorkspaceFileNode file) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AiCodeEditorScreen(
          project: widget.project,
          workspace: _workspace!,
          repository: _repository,
          initialFile: file,
        ),
      ),
    ).then((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _workspace == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
        actions: [
          IconButton(tooltip: 'New File', icon: const Icon(Icons.note_add_outlined), onPressed: () => _createFile(_workspace!.root)),
          IconButton(tooltip: 'New Folder', icon: const Icon(Icons.create_new_folder_outlined), onPressed: () => _createFolder(_workspace!.root)),
        ],
      ),
      body: AiFileTreeWidget(
        root: _workspace!.root,
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
  }
}

class AiCodeEditorScreen extends StatefulWidget {
  final AiProject project;
  final AiWorkspace workspace;
  final AiWorkspaceRepository repository;
  final AiWorkspaceFileNode? initialFile;

  const AiCodeEditorScreen({
    super.key,
    required this.project,
    required this.workspace,
    required this.repository,
    this.initialFile,
  });

  @override
  State<AiCodeEditorScreen> createState() => _AiCodeEditorScreenState();
}

class _AiCodeEditorScreenState extends State<AiCodeEditorScreen> {
  late final AiEditorController _editorController;

  @override
  void initState() {
    super.initState();
    _editorController = AiEditorController();
    if (widget.initialFile != null) _editorController.openFile(widget.initialFile!);
  }

  @override
  void dispose() {
    _editorController.dispose();
    super.dispose();
  }

  Future<void> _saveAll() async {
    for (final tab in _editorController.openTabs) {
      _editorController.markSaved(tab.file);
    }
    await widget.repository.save(widget.workspace);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Workspace saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
        actions: [
          IconButton(tooltip: 'Save', icon: const Icon(Icons.save_outlined), onPressed: _saveAll),
        ],
      ),
      body: AnimatedBuilder(
        animation: _editorController,
        builder: (context, _) {
          final activeFile = _editorController.activeFile;
          return Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: activeFile == null
                    ? const Center(child: Text('Select a file from the Project Explorer to start editing.', style: TextStyle(color: Colors.white54)))
                    : AiCodeEditorWidget(
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

  Widget _buildTabBar() {
    if (_editorController.openTabs.isEmpty) return const SizedBox.shrink();
    return Container(
      height: 40,
      color: const Color(0xFF252526),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _editorController.openTabs.length,
        itemBuilder: (context, index) {
          final tab = _editorController.openTabs[index];
          final isActive = tab.file.id == _editorController.activeFileId;
          return InkWell(
            onTap: () => _editorController.focusFile(tab.file),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF1E1E1E) : Colors.transparent,
                border: Border(bottom: BorderSide(color: isActive ? Colors.lightBlueAccent : Colors.transparent, width: 2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(AiFileIcons.iconFor(tab.file), size: 14, color: AiFileIcons.colorFor(tab.file)),
                  const SizedBox(width: 6),
                  Text(tab.file.name, style: TextStyle(fontSize: 12, color: isActive ? Colors.white : Colors.white60)),
                  const SizedBox(width: 6),
                  if (tab.isDirty) const Padding(padding: EdgeInsets.only(right: 4), child: CircleAvatar(radius: 3, backgroundColor: Colors.white70)),
                  InkWell(onTap: () => _editorController.closeFile(tab.file), child: const Icon(Icons.close, size: 14, color: Colors.white38)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
