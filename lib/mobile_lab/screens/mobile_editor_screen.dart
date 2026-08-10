import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'build_service.dart';
import 'build_center_screen.dart';
import 'build_history_screen.dart';
import 'project_secrets_screen.dart';
import 'mobile_templates_screen.dart';
import 'mobile_icon_picker_service.dart';
import 'mobile_package_picker_screen.dart';

// ============================================================
// MODELS — a Flutter project's editable file tree
// ============================================================

enum MobileFileNodeType { file, folder }

class MobileFileNode {
  final String id;
  String name;
  final MobileFileNodeType type;
  String content;
  List<MobileFileNode> children;
  bool isExpanded;
  DateTime lastModified;

  MobileFileNode({
    required this.id,
    required this.name,
    required this.type,
    this.content = '',
    List<MobileFileNode>? children,
    this.isExpanded = false,
    DateTime? lastModified,
  })  : children = children ?? <MobileFileNode>[],
        lastModified = lastModified ?? DateTime.now();

  bool get isFolder => type == MobileFileNodeType.folder;
  bool get isFile => type == MobileFileNodeType.file;

  String get extension {
    if (isFolder) return '';
    final dotIndex = name.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == name.length - 1) return '';
    return name.substring(dotIndex + 1).toLowerCase();
  }

  MobileFileNode deepCopy({String? newId, String? newName}) {
    return MobileFileNode(
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

  factory MobileFileNode.fromJson(Map<String, dynamic> json) {
    return MobileFileNode(
      id: json['id'] as String,
      name: json['name'] as String,
      type: MobileFileNodeType.values.byName(json['type'] as String),
      content: json['content'] as String? ?? '',
      children: (json['children'] as List<dynamic>? ?? [])
          .map((c) => MobileFileNode.fromJson(c as Map<String, dynamic>))
          .toList(),
      isExpanded: json['isExpanded'] as bool? ?? false,
      lastModified: DateTime.tryParse(json['lastModified'] as String? ?? '') ?? DateTime.now(),
    );
  }

  static String _generateId() =>
      '${DateTime.now().microsecondsSinceEpoch}_${identityHashCode(Object())}';

  @override
  bool operator ==(Object other) => other is MobileFileNode && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class MobileProject {
  final String id;
  String name;
  MobileFileNode root;
  final DateTime createdAt;
  DateTime lastOpenedAt;
  String? githubRepoUrl;
  String? lastBuildApkUrl;

  /// Base64-encoded PNG bytes of the student's custom app icon. When
  /// null, MobileProjectZipper embeds Hustle Academy's bundled default
  /// icon instead — so no generated app ever ships with the plain
  /// Flutter logo.
  String? customIconBase64;

  MobileProject({
    required this.id,
    required this.name,
    required this.root,
    DateTime? createdAt,
    DateTime? lastOpenedAt,
    this.githubRepoUrl,
    this.lastBuildApkUrl,
    this.customIconBase64,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastOpenedAt = lastOpenedAt ?? DateTime.now();

  MobileFileNode? findFileByPath(String path) {
    final parts = path.split('/');
    MobileFileNode? current = root;
    for (final part in parts) {
      if (current == null) return null;
      final match = current.children.where((c) => c.name == part);
      current = match.isEmpty ? null : match.first;
    }
    return current;
  }

  MobileFileNode? get mainDart => findFileByPath('lib/main.dart');
  MobileFileNode? get pubspecYaml => findFileByPath('pubspec.yaml');

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'root': root.toJson(),
        'createdAt': createdAt.toIso8601String(),
        'lastOpenedAt': lastOpenedAt.toIso8601String(),
        'githubRepoUrl': githubRepoUrl,
        'lastBuildApkUrl': lastBuildApkUrl,
        'customIconBase64': customIconBase64,
      };

  factory MobileProject.fromJson(Map<String, dynamic> json) {
    return MobileProject(
      id: json['id'] as String,
      name: json['name'] as String,
      root: MobileFileNode.fromJson(json['root'] as Map<String, dynamic>),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      lastOpenedAt: DateTime.tryParse(json['lastOpenedAt'] as String? ?? '') ?? DateTime.now(),
      githubRepoUrl: json['githubRepoUrl'] as String?,
      lastBuildApkUrl: json['lastBuildApkUrl'] as String?,
      customIconBase64: json['customIconBase64'] as String?,
    );
  }

  static MobileFileNode buildStarterTree(String projectName) {
    final packageName = projectName.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9_]'), '_');
    final root = MobileFileNode(id: MobileFileNode._generateId(), name: projectName, type: MobileFileNodeType.folder, isExpanded: true);

    final libFolder = MobileFileNode(id: MobileFileNode._generateId(), name: 'lib', type: MobileFileNodeType.folder, isExpanded: true);
    final mainFile = MobileFileNode(
      id: MobileFileNode._generateId(),
      name: 'main.dart',
      type: MobileFileNodeType.file,
      content: '''import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$projectName',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$projectName')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text('\$_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
''',
    );
    libFolder.children.add(mainFile);
    root.children.add(libFolder);

    final pubspecFile = MobileFileNode(
      id: MobileFileNode._generateId(),
      name: 'pubspec.yaml',
      type: MobileFileNodeType.file,
      content: '''name: $packageName
description: A new Flutter project built in Mobile Lab.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  flutter_launcher_icons: ^0.14.1

flutter:
  uses-material-design: true
  assets:
    - assets/icon.png

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon.png"
''',
    );
    root.children.add(pubspecFile);

    return root;
  }
}

// ============================================================
// PROJECT ZIPPER — packs a MobileProject's file tree into a
// Flutter-shaped zip, plus assets/icon.png (the student's custom
// icon if set, otherwise Hustle Academy's bundled default — so no
// generated app ever ships with the plain Flutter logo).
// ============================================================

class MobileProjectZipper {
  static Future<List<int>> zip(MobileProject project) async {
    final archive = Archive();
    _addNode(archive, project.root, '');

    final iconBytes = await MobileIconPickerService.resolveIconBytes(project.customIconBase64);
    archive.addFile(ArchiveFile('assets/icon.png', iconBytes.length, iconBytes));

    final zipData = ZipEncoder().encode(archive);
    return zipData;
  }

  static void _addNode(Archive archive, MobileFileNode node, String pathPrefix) {
    final nodePath = pathPrefix.isEmpty ? node.name : '$pathPrefix/${node.name}';

    if (node.isFile) {
      final bytes = Uint8List.fromList(utf8.encode(node.content));
      archive.addFile(ArchiveFile(nodePath, bytes.length, bytes));
      return;
    }

    for (final child in node.children) {
      _addNode(archive, child, nodePath);
    }
  }
}

// ============================================================
// STORAGE
// ============================================================

class MobileProjectRepository {
  static const String _indexKey = 'mobile_lab.project_index';
  static const String _projectPrefix = 'mobile_lab.project.';

  Future<void> saveProject(MobileProject project) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_projectPrefix${project.id}', jsonEncode(project.toJson()));
    final index = await _loadIndex();
    index.removeWhere((e) => e['id'] == project.id);
    index.add({'id': project.id, 'name': project.name, 'lastOpenedAt': project.lastOpenedAt.toIso8601String()});
    await prefs.setString(_indexKey, jsonEncode(index));
  }

  Future<MobileProject?> loadProject(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_projectPrefix$id');
    if (raw == null) return null;
    return MobileProject.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<List<Map<String, dynamic>>> _loadIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_indexKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List<dynamic>).map((e) => e as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> listProjects() async {
    final index = await _loadIndex();
    index.sort((a, b) => (b['lastOpenedAt'] as String).compareTo(a['lastOpenedAt'] as String));
    return index;
  }

  Future<void> deleteProject(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_projectPrefix$id');
    final index = await _loadIndex();
    index.removeWhere((e) => e['id'] == id);
    await prefs.setString(_indexKey, jsonEncode(index));
  }
}

// ============================================================
// FILE SYSTEM OPERATIONS
// ============================================================

class MobileFileSystemService {
  String generateId() => MobileFileNode._generateId();

  MobileFileNode createFile(MobileFileNode parent, String name) {
    _assertUniqueName(parent, name);
    final node = MobileFileNode(id: generateId(), name: name, type: MobileFileNodeType.file);
    parent.children.add(node);
    return node;
  }

  MobileFileNode createFolder(MobileFileNode parent, String name) {
    _assertUniqueName(parent, name);
    final node = MobileFileNode(id: generateId(), name: name, type: MobileFileNodeType.folder);
    parent.children.add(node);
    return node;
  }

  void renameNode(MobileFileNode parent, MobileFileNode node, String newName) {
    if (newName == node.name) return;
    _assertUniqueName(parent, newName, excluding: node);
    node.name = newName;
    node.lastModified = DateTime.now();
  }

  void deleteNode(MobileFileNode parent, MobileFileNode node) {
    parent.children.removeWhere((c) => c.id == node.id);
  }

  MobileFileNode duplicateNode(MobileFileNode parent, MobileFileNode node) {
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

  void moveNode(MobileFileNode oldParent, MobileFileNode newParent, MobileFileNode node) {
    if (identical(newParent, node) || _isDescendant(node, newParent)) {
      throw ArgumentError('Cannot move a folder into itself or its own child.');
    }
    _assertUniqueName(newParent, node.name);
    oldParent.children.removeWhere((c) => c.id == node.id);
    newParent.children.add(node);
  }

  void toggleExpanded(MobileFileNode folder) {
    if (!folder.isFolder) return;
    folder.isExpanded = !folder.isExpanded;
  }

  void _assertUniqueName(MobileFileNode parent, String name, {MobileFileNode? excluding}) {
    final clash = parent.children.any((c) => c.name == name && (excluding == null || c.id != excluding.id));
    if (clash) throw ArgumentError('"$name" already exists in this folder.');
  }

  String _stripExtension(String name) {
    final dotIndex = name.lastIndexOf('.');
    if (dotIndex <= 0) return name;
    return name.substring(0, dotIndex);
  }

  bool _isDescendant(MobileFileNode node, MobileFileNode candidate) {
    for (final child in node.children) {
      if (identical(child, candidate)) return true;
      if (_isDescendant(child, candidate)) return true;
    }
    return false;
  }
}

// ============================================================
// SYNTAX HIGHLIGHTING
// ============================================================

enum MobileLanguage { dart, yaml, plain }

enum MobileTokenType { plain, keyword, type, string, number, comment, annotation, punctuation, yamlKey }

class MobileSyntaxToken {
  final String text;
  final MobileTokenType type;

  const MobileSyntaxToken(this.text, this.type);
}

class MobileSyntaxHighlighter {
  static MobileLanguage languageForExtension(String extension) {
    switch (extension.toLowerCase()) {
      case 'dart':
        return MobileLanguage.dart;
      case 'yaml':
      case 'yml':
        return MobileLanguage.yaml;
      default:
        return MobileLanguage.plain;
    }
  }

  static TextSpan highlight(String source, MobileLanguage language, MobileEditorColorScheme colors) {
    final tokens = _tokenize(source, language);
    return TextSpan(
      style: colors.baseStyle,
      children: tokens.map((t) => TextSpan(text: t.text, style: colors.styleFor(t.type))).toList(),
    );
  }

  static List<MobileSyntaxToken> _tokenize(String source, MobileLanguage language) {
    switch (language) {
      case MobileLanguage.dart:
        return _tokenizeDart(source);
      case MobileLanguage.yaml:
        return _tokenizeYaml(source);
      case MobileLanguage.plain:
        return [MobileSyntaxToken(source, MobileTokenType.plain)];
    }
  }

  static const Set<String> _dartKeywords = {
    'abstract', 'as', 'assert', 'async', 'await', 'break', 'case', 'catch', 'class', 'const',
    'continue', 'default', 'do', 'dynamic', 'else', 'enum', 'extends', 'extension', 'factory',
    'false', 'final', 'finally', 'for', 'Function', 'get', 'if', 'implements', 'import', 'in',
    'is', 'library', 'mixin', 'new', 'null', 'on', 'operator', 'part', 'required', 'rethrow',
    'return', 'set', 'static', 'super', 'switch', 'this', 'throw', 'true', 'try', 'typedef',
    'var', 'void', 'while', 'with', 'yield', 'late', 'sealed',
  };

  static const Set<String> _dartCommonTypes = {
    'int', 'double', 'String', 'bool', 'List', 'Map', 'Set', 'Widget', 'StatelessWidget',
    'StatefulWidget', 'State', 'BuildContext', 'Object', 'Future', 'Stream', 'Duration',
  };

  static final RegExp _dartPattern = RegExp(
    r'(//.*$)'
    r'|(/\*[\s\S]*?\*/)'
    r'|("(?:[^"\\]|\\.)*"|' r"'(?:[^'\\]|\\.)*')"
    r'|(@[a-zA-Z_][a-zA-Z0-9_]*)'
    r'|(\b\d+\.?\d*\b)'
    r'|([{}();,.])'
    r'|(\b[a-zA-Z_$][a-zA-Z0-9_$]*\b)',
    multiLine: true,
  );

  static List<MobileSyntaxToken> _tokenizeDart(String source) {
    return _tokenizeWithMatcher(source, _dartPattern, (match) {
      if (match.group(1) != null || match.group(2) != null) return MobileTokenType.comment;
      if (match.group(3) != null) return MobileTokenType.string;
      if (match.group(4) != null) return MobileTokenType.annotation;
      if (match.group(5) != null) return MobileTokenType.number;
      if (match.group(6) != null) return MobileTokenType.punctuation;
      if (match.group(7) != null) {
        final word = match.group(7)!;
        if (_dartKeywords.contains(word)) return MobileTokenType.keyword;
        if (_dartCommonTypes.contains(word)) return MobileTokenType.type;
        if (word.isNotEmpty && word[0] == word[0].toUpperCase() && word[0] != word[0].toLowerCase()) return MobileTokenType.type;
        return MobileTokenType.plain;
      }
      return MobileTokenType.plain;
    });
  }

  static final RegExp _yamlPattern = RegExp(
    r'(#.*$)'
    r'|("(?:[^"\\]|\\.)*"|' r"'(?:[^'\\]|\\.)*')"
    r'|(^\s*[a-zA-Z0-9_.-]+(?=\s*:))'
    r'|(\b\d+\.?\d*\b)'
    r'|([:\-])',
    multiLine: true,
  );

  static List<MobileSyntaxToken> _tokenizeYaml(String source) {
    return _tokenizeWithMatcher(source, _yamlPattern, (match) {
      if (match.group(1) != null) return MobileTokenType.comment;
      if (match.group(2) != null) return MobileTokenType.string;
      if (match.group(3) != null) return MobileTokenType.yamlKey;
      if (match.group(4) != null) return MobileTokenType.number;
      if (match.group(5) != null) return MobileTokenType.punctuation;
      return MobileTokenType.plain;
    });
  }

  static List<MobileSyntaxToken> _tokenizeWithMatcher(
    String source,
    RegExp pattern,
    MobileTokenType Function(RegExpMatch match) classify,
  ) {
    final tokens = <MobileSyntaxToken>[];
    var lastEnd = 0;
    for (final match in pattern.allMatches(source)) {
      if (match.start > lastEnd) tokens.add(MobileSyntaxToken(source.substring(lastEnd, match.start), MobileTokenType.plain));
      tokens.add(MobileSyntaxToken(match.group(0)!, classify(match)));
      lastEnd = match.end;
    }
    if (lastEnd < source.length) tokens.add(MobileSyntaxToken(source.substring(lastEnd), MobileTokenType.plain));
    return tokens;
  }
}

class MobileEditorColorScheme {
  final TextStyle baseStyle;
  final Color keyword, type, string, number, comment, annotation, punctuation, yamlKey;

  const MobileEditorColorScheme({
    required this.baseStyle,
    required this.keyword,
    required this.type,
    required this.string,
    required this.number,
    required this.comment,
    required this.annotation,
    required this.punctuation,
    required this.yamlKey,
  });

  factory MobileEditorColorScheme.dark() {
    return const MobileEditorColorScheme(
      baseStyle: TextStyle(color: Color(0xFFD4D4D4), fontFamily: 'monospace', fontSize: 14, height: 1.5),
      keyword: Color(0xFF569CD6),
      type: Color(0xFF4EC9B0),
      string: Color(0xFFCE9178),
      number: Color(0xFFB5CEA8),
      comment: Color(0xFF6A9955),
      annotation: Color(0xFFDCDCAA),
      punctuation: Color(0xFFD4D4D4),
      yamlKey: Color(0xFF9CDCFE),
    );
  }

  TextStyle styleFor(MobileTokenType type) {
    final color = switch (type) {
      MobileTokenType.plain => baseStyle.color,
      MobileTokenType.keyword => keyword,
      MobileTokenType.type => this.type,
      MobileTokenType.string => string,
      MobileTokenType.number => number,
      MobileTokenType.comment => comment,
      MobileTokenType.annotation => annotation,
      MobileTokenType.punctuation => punctuation,
      MobileTokenType.yamlKey => yamlKey,
    };
    final fontStyle = type == MobileTokenType.comment ? FontStyle.italic : FontStyle.normal;
    return baseStyle.copyWith(color: color, fontStyle: fontStyle);
  }
}

// ============================================================
// EDITOR STATE
// ============================================================

class MobileEditorTab {
  final MobileFileNode file;
  bool isDirty;

  MobileEditorTab({required this.file, this.isDirty = false});
}

class MobileEditorController extends ChangeNotifier {
  final List<MobileEditorTab> _openTabs = [];
  String? _activeFileId;
  final Map<String, List<String>> _undoStacks = {};
  final Map<String, List<String>> _redoStacks = {};
  static const int _maxHistoryLength = 100;

  List<MobileEditorTab> get openTabs => List.unmodifiable(_openTabs);
  String? get activeFileId => _activeFileId;

  MobileFileNode? get activeFile {
    if (_activeFileId == null) return null;
    try {
      return _openTabs.firstWhere((t) => t.file.id == _activeFileId).file;
    } catch (_) {
      return null;
    }
  }

  void openFile(MobileFileNode file) {
    if (!file.isFile) return;
    if (!_openTabs.any((t) => t.file.id == file.id)) {
      _openTabs.add(MobileEditorTab(file: file));
      _undoStacks.putIfAbsent(file.id, () => []);
      _redoStacks.putIfAbsent(file.id, () => []);
    }
    _activeFileId = file.id;
    notifyListeners();
  }

  void closeFile(MobileFileNode file) {
    final index = _openTabs.indexWhere((t) => t.file.id == file.id);
    if (index == -1) return;
    _openTabs.removeAt(index);
    _undoStacks.remove(file.id);
    _redoStacks.remove(file.id);
    if (_activeFileId == file.id) {
      _activeFileId = _openTabs.isEmpty ? null : _openTabs[index < _openTabs.length ? index : _openTabs.length - 1].file.id;
    }
    notifyListeners();
  }

  void focusFile(MobileFileNode file) {
    if (!_openTabs.any((t) => t.file.id == file.id)) return;
    _activeFileId = file.id;
    notifyListeners();
  }

  void updateContent(MobileFileNode file, String newContent) {
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

  void undo(MobileFileNode file) {
    final undoStack = _undoStacks[file.id];
    if (undoStack == null || undoStack.isEmpty) return;
    _redoStacks.putIfAbsent(file.id, () => []).add(file.content);
    file.content = undoStack.removeLast();
    _markDirty(file);
    notifyListeners();
  }

  void redo(MobileFileNode file) {
    final redoStack = _redoStacks[file.id];
    if (redoStack == null || redoStack.isEmpty) return;
    _undoStacks.putIfAbsent(file.id, () => []).add(file.content);
    file.content = redoStack.removeLast();
    _markDirty(file);
    notifyListeners();
  }

  bool canUndo(MobileFileNode file) => (_undoStacks[file.id]?.isNotEmpty) ?? false;
  bool canRedo(MobileFileNode file) => (_redoStacks[file.id]?.isNotEmpty) ?? false;

  void markSaved(MobileFileNode file) {
    final tab = _findTab(file.id);
    if (tab != null) {
      tab.isDirty = false;
      notifyListeners();
    }
  }

  void _markDirty(MobileFileNode file) {
    _findTab(file.id)?.isDirty = true;
  }

  MobileEditorTab? _findTab(String fileId) {
    try {
      return _openTabs.firstWhere((t) => t.file.id == fileId);
    } catch (_) {
      return null;
    }
  }

  bool get hasUnsavedChanges => _openTabs.any((t) => t.isDirty);

  void reset() {
    _openTabs.clear();
    _undoStacks.clear();
    _redoStacks.clear();
    _activeFileId = null;
    notifyListeners();
  }
}

class MobileSearchMatch {
  final int start;
  final int end;

  const MobileSearchMatch(this.start, this.end);
}

class MobileEditorSearchEngine {
  static List<MobileSearchMatch> findAll(String source, String query) {
    if (query.isEmpty) return [];
    final matches = <MobileSearchMatch>[];
    final lowerSource = source.toLowerCase();
    final lowerQuery = query.toLowerCase();
    var start = 0;
    while (true) {
      final index = lowerSource.indexOf(lowerQuery, start);
      if (index == -1) break;
      matches.add(MobileSearchMatch(index, index + query.length));
      start = index + query.length;
    }
    return matches;
  }

  static String replaceOne(String source, MobileSearchMatch match, String replacement) =>
      source.replaceRange(match.start, match.end, replacement);

  static String replaceAll(String source, String query, String replacement) {
    if (query.isEmpty) return source;
    return source.replaceAll(RegExp(RegExp.escape(query), caseSensitive: false), replacement);
  }
}

// ============================================================
// PROJECT CONTROLLER
// ============================================================

class MobileProjectController extends ChangeNotifier {
  final MobileProjectRepository _repository = MobileProjectRepository();
  final MobileFileSystemService _fileSystemService = MobileFileSystemService();

  MobileProject? _currentProject;
  List<Map<String, dynamic>> _recentProjects = [];
  bool _isLoading = false;

  MobileProject? get currentProject => _currentProject;
  List<Map<String, dynamic>> get recentProjects => List.unmodifiable(_recentProjects);
  bool get isLoading => _isLoading;
  MobileFileSystemService get fileSystemService => _fileSystemService;

  Future<void> loadRecentProjects() async {
    _isLoading = true;
    notifyListeners();
    _recentProjects = await _repository.listProjects();
    _isLoading = false;
    notifyListeners();
  }

  /// Creates a new project. Pass [treeBuilder] to seed it from a
  /// template (see mobile_templates_screen.dart); otherwise falls
  /// back to the plain counter starter.
  Future<MobileProject> createProject(
    String name, {
    MobileFileNode Function(String projectName)? treeBuilder,
  }) async {
    final root = treeBuilder != null ? treeBuilder(name) : MobileProject.buildStarterTree(name);
    final project = MobileProject(id: _fileSystemService.generateId(), name: name, root: root);
    await _repository.saveProject(project);
    _currentProject = project;
    await loadRecentProjects();
    notifyListeners();
    return project;
  }

  Future<void> openProject(String id) async {
    _isLoading = true;
    notifyListeners();
    final project = await _repository.loadProject(id);
    if (project != null) {
      project.lastOpenedAt = DateTime.now();
      await _repository.saveProject(project);
      _currentProject = project;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveCurrentProject() async {
    final project = _currentProject;
    if (project == null) return;
    await _repository.saveProject(project);
    await loadRecentProjects();
  }

  Future<void> renameCurrentProject(String newName) async {
    final project = _currentProject;
    if (project == null) return;
    project.name = newName;
    project.root.name = newName;
    await saveCurrentProject();
    notifyListeners();
  }

  Future<void> deleteProject(String id) async {
    await _repository.deleteProject(id);
    if (_currentProject?.id == id) _currentProject = null;
    await loadRecentProjects();
  }

  void closeCurrentProject() {
    _currentProject = null;
    notifyListeners();
  }

  void notifyProjectChanged() => notifyListeners();
}

// ============================================================
// FILE ICONS
// ============================================================

class MobileFileIcons {
  static IconData iconFor(MobileFileNode node) {
    if (node.isFolder) return node.isExpanded ? Icons.folder_open : Icons.folder;
    switch (node.extension) {
      case 'dart':
        return Icons.code;
      case 'yaml':
      case 'yml':
        return Icons.settings_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  static Color colorFor(MobileFileNode node) {
    if (node.isFolder) return const Color(0xFFDCB67A);
    switch (node.extension) {
      case 'dart':
        return const Color(0xFF0175C2);
      case 'yaml':
      case 'yml':
        return const Color(0xFFCB171E);
      default:
        return const Color(0xFFB0B0B0);
    }
  }
}

// ============================================================
// EDITOR SEARCH BAR WIDGET
// ============================================================

class MobileEditorSearchBar extends StatefulWidget {
  final int matchCount;
  final int currentIndex;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final ValueChanged<String> onReplaceOne;
  final ValueChanged<String> onReplaceAll;
  final VoidCallback onClose;

  const MobileEditorSearchBar({
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
  State<MobileEditorSearchBar> createState() => _MobileEditorSearchBarState();
}

class _MobileEditorSearchBarState extends State<MobileEditorSearchBar> {
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

class MobileCodeEditorWidget extends StatefulWidget {
  final MobileFileNode file;
  final ValueChanged<String> onChanged;
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final bool canUndo;
  final bool canRedo;

  const MobileCodeEditorWidget({
    super.key,
    required this.file,
    required this.onChanged,
    this.onUndo,
    this.onRedo,
    this.canUndo = false,
    this.canRedo = false,
  });

  @override
  State<MobileCodeEditorWidget> createState() => _MobileCodeEditorWidgetState();
}

class _MobileCodeEditorWidgetState extends State<MobileCodeEditorWidget> {
  late TextEditingController _controller;
  final ScrollController _codeScrollController = ScrollController();
  final ScrollController _lineNumberScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  bool _showSearch = false;
  String _searchQuery = '';
  List<MobileSearchMatch> _matches = [];
  int _currentMatchIndex = 0;

  static const Map<String, String> _bracketPairs = {'(': ')', '[': ']', '{': '}'};

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.file.content);
    _codeScrollController.addListener(_syncLineNumberScroll);
  }

  @override
  void didUpdateWidget(covariant MobileCodeEditorWidget oldWidget) {
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
    if (_lineNumberScrollController.hasClients) _lineNumberScrollController.jumpTo(_codeScrollController.offset);
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

  void _handleNewLine() {
    final selection = _controller.selection;
    final text = _controller.text;
    final beforeCursor = text.substring(0, selection.start);
    final lastNewline = beforeCursor.lastIndexOf('\n');
    final currentLine = beforeCursor.substring(lastNewline + 1);
    final leadingWhitespace = RegExp(r'^[ \t]*').stringMatch(currentLine) ?? '';
    final extraIndent = currentLine.trimRight().endsWith('{') || currentLine.trimRight().endsWith('(') || currentLine.trimRight().endsWith('[') ? '  ' : '';
    final insertion = '\n$leadingWhitespace$extraIndent';
    final newText = text.replaceRange(selection.start, selection.start, insertion);
    final newOffset = selection.start + insertion.length;
    _controller.value = TextEditingValue(text: newText, selection: TextSelection.collapsed(offset: newOffset));
    widget.onChanged(newText);
  }

  void _recomputeMatches() {
    setState(() {
      _matches = MobileEditorSearchEngine.findAll(_controller.text, _searchQuery);
      if (_matches.isEmpty) {
        _currentMatchIndex = 0;
      } else if (_currentMatchIndex >= _matches.length) {
        _currentMatchIndex = 0;
      }
    });
    if (_matches.isNotEmpty) _selectMatch(_matches[_currentMatchIndex]);
  }

  void _selectMatch(MobileSearchMatch match) {
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
    final newText = MobileEditorSearchEngine.replaceOne(_controller.text, match, replacement);
    final newOffset = match.start + replacement.length;
    _controller.value = TextEditingValue(text: newText, selection: TextSelection.collapsed(offset: newOffset));
    widget.onChanged(newText);
    _recomputeMatches();
  }

  void _replaceAllMatches(String replacement) {
    if (_searchQuery.isEmpty) return;
    final newText = MobileEditorSearchEngine.replaceAll(_controller.text, _searchQuery, replacement);
    _controller.value = TextEditingValue(text: newText, selection: TextSelection.collapsed(offset: newText.length));
    widget.onChanged(newText);
    _recomputeMatches();
  }

  @override
  Widget build(BuildContext context) {
    final colors = MobileEditorColorScheme.dark();
    final language = MobileSyntaxHighlighter.languageForExtension(widget.file.extension);

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
                  children: [_buildLineNumbers(colors), Expanded(child: _buildCodeField(colors, language))],
                ),
              ),
            ],
          ),
          if (_showSearch)
            Positioned(
              top: 48,
              left: 8,
              right: 8,
              child: MobileEditorSearchBar(
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
        ],
      ),
    );
  }

  Widget _buildLineNumbers(MobileEditorColorScheme colors) {
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
            children: List.generate(_lineCount, (i) => Text('${i + 1}', style: colors.baseStyle.copyWith(color: Colors.white24, fontSize: 13))),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeField(MobileEditorColorScheme colors, MobileLanguage language) {
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
// PROJECT EXPLORER WIDGET
// ============================================================

class MobileFileTreeWidget extends StatelessWidget {
  final MobileFileNode root;
  final String? activeFileId;
  final ValueChanged<MobileFileNode> onFileTap;
  final ValueChanged<MobileFileNode> onToggleFolder;
  final void Function(MobileFileNode parent, MobileFileNode node) onRename;
  final void Function(MobileFileNode parent, MobileFileNode node) onDelete;
  final void Function(MobileFileNode parent, MobileFileNode node) onDuplicate;
  final void Function(MobileFileNode parent) onCreateFile;
  final void Function(MobileFileNode parent) onCreateFolder;

  const MobileFileTreeWidget({
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

  List<Widget> _buildChildRows(MobileFileNode node, {required int depth}) {
    final widgets = <Widget>[];
    for (final child in node.children) {
      widgets.add(_buildRow(node, child, depth));
      if (child.isFolder && child.isExpanded) widgets.addAll(_buildChildRows(child, depth: depth + 1));
    }
    return widgets;
  }

  Widget _buildRow(MobileFileNode parent, MobileFileNode node, int depth) {
    return _MobileFileTreeRow(
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

class _MobileFileTreeRow extends StatelessWidget {
  final MobileFileNode node;
  final int depth;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final VoidCallback onDuplicate;
  final VoidCallback? onCreateFile;
  final VoidCallback? onCreateFolder;

  const _MobileFileTreeRow({
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
              Icon(MobileFileIcons.iconFor(node), size: 18, color: MobileFileIcons.colorFor(node)),
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

class MobileProjectExplorerScreen extends StatefulWidget {
  final MobileProjectController projectController;

  const MobileProjectExplorerScreen({super.key, required this.projectController});

  @override
  State<MobileProjectExplorerScreen> createState() => _MobileProjectExplorerScreenState();
}

class _MobileProjectExplorerScreenState extends State<MobileProjectExplorerScreen> {
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

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _createFile(MobileFileNode parent) async {
    final name = await _promptForName('New File');
    if (name == null || name.trim().isEmpty) return;
    try {
      widget.projectController.fileSystemService.createFile(parent, name.trim());
      widget.projectController.notifyProjectChanged();
      await widget.projectController.saveCurrentProject();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _createFolder(MobileFileNode parent) async {
    final name = await _promptForName('New Folder');
    if (name == null || name.trim().isEmpty) return;
    try {
      widget.projectController.fileSystemService.createFolder(parent, name.trim());
      widget.projectController.notifyProjectChanged();
      await widget.projectController.saveCurrentProject();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _rename(MobileFileNode parent, MobileFileNode node) async {
    final name = await _promptForName('Rename', initial: node.name);
    if (name == null || name.trim().isEmpty) return;
    try {
      widget.projectController.fileSystemService.renameNode(parent, node, name.trim());
      widget.projectController.notifyProjectChanged();
      await widget.projectController.saveCurrentProject();
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _delete(MobileFileNode parent, MobileFileNode node) async {
    final confirmed = await _confirmDelete(node.name);
    if (!confirmed) return;
    widget.projectController.fileSystemService.deleteNode(parent, node);
    widget.projectController.notifyProjectChanged();
    await widget.projectController.saveCurrentProject();
  }

  Future<void> _duplicate(MobileFileNode parent, MobileFileNode node) async {
    widget.projectController.fileSystemService.duplicateNode(parent, node);
    widget.projectController.notifyProjectChanged();
    await widget.projectController.saveCurrentProject();
  }

  void _toggleFolder(MobileFileNode node) {
    widget.projectController.fileSystemService.toggleExpanded(node);
    widget.projectController.notifyProjectChanged();
  }

  void _openInEditor(MobileFileNode file) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MobileEditorScreen(projectController: widget.projectController, initialFile: file)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.projectController,
      builder: (context, _) {
        final project = widget.projectController.currentProject;
        if (project == null) return const Scaffold(body: Center(child: Text('No project open.')));

        return Scaffold(
          appBar: AppBar(
            title: Text(project.name),
            actions: [
              IconButton(tooltip: 'New File', icon: const Icon(Icons.note_add_outlined), onPressed: () => _createFile(project.root)),
              IconButton(tooltip: 'New Folder', icon: const Icon(Icons.create_new_folder_outlined), onPressed: () => _createFolder(project.root)),
            ],
          ),
          body: MobileFileTreeWidget(
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

class MobileEditorScreen extends StatefulWidget {
  final MobileProjectController projectController;
  final MobileFileNode? initialFile;

  const MobileEditorScreen({super.key, required this.projectController, this.initialFile});

  @override
  State<MobileEditorScreen> createState() => _MobileEditorScreenState();
}

class _MobileEditorScreenState extends State<MobileEditorScreen> {
  late final MobileEditorController _editorController;
  late final BuildService _buildService;
  bool _isStartingBuild = false;

  @override
  void initState() {
    super.initState();
    _editorController = MobileEditorController();
    if (widget.initialFile != null) _editorController.openFile(widget.initialFile!);
    _buildService = BuildService(
      supabase: Supabase.instance.client,
      userId: Supabase.instance.client.auth.currentUser!.id,
    );
    _buildService.initialize();
  }

  @override
  void dispose() {
    _editorController.dispose();
    _buildService.dispose();
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

  Future<void> _generateApk(MobileProject project) async {
    if (_isStartingBuild) return;
    setState(() => _isStartingBuild = true);

    await _saveAll();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BuildCenterScreen(
          buildService: _buildService,
          projectId: project.id,
          projectName: project.name,
        ),
      ),
    );

    try {
      final zipBytes = await MobileProjectZipper.zip(project);
      await _buildService.createBuild(
        projectId: project.id,
        projectName: project.name,
        projectZipBytes: zipBytes,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start build: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isStartingBuild = false);
    }
  }

  Future<void> _pickIcon(MobileProject project) async {
    final base64Icon = await MobileIconPickerService.pickIcon();
    if (base64Icon == null) return;
    setState(() => project.customIconBase64 = base64Icon);
    await widget.projectController.saveCurrentProject();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('App icon updated')));
  }

  void _openPackagePicker(MobileProject project) {
    final pubspec = project.pubspecYaml;
    if (pubspec == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MobilePackagePickerScreen(
          currentPubspecContent: pubspec.content,
          onPubspecChanged: (newContent) {
            _editorController.updateContent(pubspec, newContent);
            widget.projectController.saveCurrentProject();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.projectController.currentProject;
    if (project == null) return const Scaffold(body: Center(child: Text('No project open.')));

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: [
          IconButton(tooltip: 'Save', icon: const Icon(Icons.save_outlined), onPressed: _saveAll),
          IconButton(
            tooltip: 'Secrets',
            icon: const Icon(Icons.key_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProjectSecretsScreen(
                  projectId: project.id,
                  projectName: project.name,
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: 'App Icon',
            icon: const Icon(Icons.image_outlined),
            onPressed: () => _pickIcon(project),
          ),
          IconButton(
            tooltip: 'Add Package',
            icon: const Icon(Icons.extension_outlined),
            onPressed: () => _openPackagePicker(project),
          ),
          IconButton(
            tooltip: 'Generate APK',
            icon: _isStartingBuild
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.android),
            onPressed: _isStartingBuild ? null : () => _generateApk(project),
          ),
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
                    : MobileCodeEditorWidget(
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
                  Icon(MobileFileIcons.iconFor(tab.file), size: 14, color: MobileFileIcons.colorFor(tab.file)),
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

class MobileLabHomeScreen extends StatefulWidget {
  const MobileLabHomeScreen({super.key});

  @override
  State<MobileLabHomeScreen> createState() => _MobileLabHomeScreenState();
}

class _MobileLabHomeScreenState extends State<MobileLabHomeScreen> {
  late final MobileProjectController _projectController;

  @override
  void initState() {
    super.initState();
    _projectController = MobileProjectController();
    _projectController.loadRecentProjects();
  }

  @override
  void dispose() {
    _projectController.dispose();
    super.dispose();
  }

  /// Opens the template picker instead of creating a blank project
  /// directly — see mobile_templates_screen.dart for the 10
  /// available starter apps.
  void _createNewProject() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MobileTemplatePickerScreen(projectController: _projectController)),
    );
  }

  void _openBuildHistory() {
    final buildService = BuildService(
      supabase: Supabase.instance.client,
      userId: Supabase.instance.client.auth.currentUser!.id,
    );
    buildService.initialize();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BuildHistoryScreen(buildService: buildService),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Lab'),
        actions: [
          IconButton(
            tooltip: 'My Builds',
            icon: const Icon(Icons.build_circle_outlined),
            onPressed: _openBuildHistory,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: _createNewProject, icon: const Icon(Icons.add), label: const Text('New Project')),
      body: AnimatedBuilder(
        animation: _projectController,
        builder: (context, _) {
          if (_projectController.isLoading) return const Center(child: CircularProgressIndicator());
          final recents = _projectController.recentProjects;
          if (recents.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('No Flutter projects yet — create your first one above.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: recents.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final summary = recents[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.smartphone),
                  title: Text(summary['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () async {
                    await _projectController.openProject(summary['id'] as String);
                    if (!mounted) return;
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MobileProjectExplorerScreen(projectController: _projectController)));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
