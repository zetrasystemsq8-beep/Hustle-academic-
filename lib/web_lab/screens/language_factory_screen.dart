import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ============================================================
// MODELS
// ============================================================

/// One transformation rule in an invented language: whenever [pattern]
/// (a regex, written by the student) matches in their source code, it's
/// replaced with [replacement] — which can reference captured groups
/// via $1, $2, etc., the same way real macro systems and early
/// source-to-source compilers work.
class LanguageRule {
  final String id;
  String pattern;
  String replacement;
  String description;

  LanguageRule({
    required this.id,
    required this.pattern,
    required this.replacement,
    this.description = '',
  });

  Map<String, dynamic> toJson() => {'id': id, 'pattern': pattern, 'replacement': replacement, 'description': description};

  factory LanguageRule.fromJson(Map<String, dynamic> json) {
    return LanguageRule(
      id: json['id'] as String,
      pattern: json['pattern'] as String,
      replacement: json['replacement'] as String,
      description: json['description'] as String? ?? '',
    );
  }
}

/// An invented mini-language: a named set of [LanguageRule]s plus sample
/// code written in that language, ready to compile down to real
/// JavaScript and run.
class LanguageSpec {
  final String id;
  String name;
  String description;
  List<LanguageRule> rules;
  String sampleCode;
  final DateTime createdAt;
  DateTime updatedAt;

  LanguageSpec({
    required this.id,
    required this.name,
    this.description = '',
    List<LanguageRule>? rules,
    this.sampleCode = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : rules = rules ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'rules': rules.map((r) => r.toJson()).toList(),
        'sampleCode': sampleCode,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory LanguageSpec.fromJson(Map<String, dynamic> json) {
    return LanguageSpec(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      rules: (json['rules'] as List<dynamic>? ?? []).map((r) => LanguageRule.fromJson(r as Map<String, dynamic>)).toList(),
      sampleCode: json['sampleCode'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  /// A starter language with two simple rules, shown to a first-time
  /// visitor as a working example to learn the mechanism from before
  /// inventing their own from scratch.
  factory LanguageSpec.starterExample() {
    return LanguageSpec(
      id: 'starter_${DateTime.now().microsecondsSinceEpoch}',
      name: 'RepeatLang (example)',
      description: 'A tiny example language with a "repeat N times { ... }" keyword that compiles to a real for-loop.',
      rules: [
        LanguageRule(
          id: 'r1',
          pattern: r'repeat\s+(\d+)\s+times\s*\{([\s\S]*?)\}',
          replacement: r'for (let i = 0; i < $1; i++) {$2}',
          description: '"repeat N times { ... }" becomes a for-loop that runs N times.',
        ),
        LanguageRule(
          id: 'r2',
          pattern: r'say\s+(.+);',
          replacement: r'console.log($1);',
          description: '"say <value>;" becomes console.log(<value>);',
        ),
      ],
      sampleCode: 'repeat 3 times {\n  say "Hello from my language!";\n}\n',
    );
  }
}

// ============================================================
// REPOSITORY
// ============================================================

class LanguageFactoryRepository {
  static const String _storageKey = 'web_lab.language_factory';

  Future<List<LanguageSpec>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => LanguageSpec.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<LanguageSpec> specs) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(specs.map((s) => s.toJson()).toList()));
  }
}

// ============================================================
// COMPILER
// ============================================================

/// Result of compiling source code written in an invented language.
class CompileResult {
  final String compiledJs;
  final String? error;
  final int passesUsed;

  const CompileResult({required this.compiledJs, this.error, required this.passesUsed});
}

/// Applies a [LanguageSpec]'s rules to source code repeatedly, so rules
/// can expand into text that another rule then also matches (e.g. a
/// custom loop keyword expanding into something containing another
/// custom keyword). Stops once a pass makes no further change, or after
/// a safety cap, so a badly-written rule set can't hang the compiler.
class LanguageCompiler {
  static const int _maxPasses = 25;

  CompileResult compile(LanguageSpec spec, String sourceCode) {
    var current = sourceCode;
    var passes = 0;

    try {
      for (passes = 1; passes <= _maxPasses; passes++) {
        var changed = false;
        for (final rule in spec.rules) {
          if (rule.pattern.trim().isEmpty) continue;
          final regex = RegExp(rule.pattern);
          final next = current.replaceAllMapped(regex, (match) {
            changed = true;
            return _applyReplacement(rule.replacement, match);
          });
          current = next;
        }
        if (!changed) break;
      }
    } catch (e) {
      return CompileResult(compiledJs: '', error: 'Rule error: ${e.toString()}', passesUsed: passes);
    }

    return CompileResult(compiledJs: current, passesUsed: passes);
  }

  String _applyReplacement(String template, RegExpMatch match) {
    var result = template;
    for (var i = match.groupCount; i >= 1; i--) {
      result = result.replaceAll('\$$i', match.group(i) ?? '');
    }
    return result;
  }
}

// ============================================================
// CONTROLLER
// ============================================================

class LanguageFactoryController extends ChangeNotifier {
  final LanguageFactoryRepository _repository = LanguageFactoryRepository();
  final LanguageCompiler _compiler = LanguageCompiler();

  List<LanguageSpec> _specs = [];
  bool _isLoading = false;

  List<LanguageSpec> get specs => List.unmodifiable(_specs);
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _specs = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<LanguageSpec> createBlank(String name) async {
    final spec = LanguageSpec(id: '${DateTime.now().microsecondsSinceEpoch}', name: name);
    _specs.add(spec);
    await _repository.saveAll(_specs);
    notifyListeners();
    return spec;
  }

  Future<LanguageSpec> createFromExample() async {
    final spec = LanguageSpec.starterExample();
    _specs.add(spec);
    await _repository.saveAll(_specs);
    notifyListeners();
    return spec;
  }

  Future<void> save(LanguageSpec spec) async {
    spec.updatedAt = DateTime.now();
    await _repository.saveAll(_specs);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _specs.removeWhere((s) => s.id == id);
    await _repository.saveAll(_specs);
    notifyListeners();
  }

  void addRule(LanguageSpec spec) {
    spec.rules.add(LanguageRule(id: '${DateTime.now().microsecondsSinceEpoch}', pattern: '', replacement: ''));
    notifyListeners();
  }

  void removeRule(LanguageSpec spec, String ruleId) {
    spec.rules.removeWhere((r) => r.id == ruleId);
    notifyListeners();
  }

  CompileResult compile(LanguageSpec spec, String sourceCode) => _compiler.compile(spec, sourceCode);
}

// ============================================================
// SCREENS
// ============================================================

/// Lists every invented language, plus a way to start from the working
/// example or a completely blank one.
class LanguageFactoryListScreen extends StatefulWidget {
  const LanguageFactoryListScreen({super.key});

  @override
  State<LanguageFactoryListScreen> createState() => _LanguageFactoryListScreenState();
}

class _LanguageFactoryListScreenState extends State<LanguageFactoryListScreen> {
  late final LanguageFactoryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LanguageFactoryController();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createBlank() async {
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name your language'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final spec = await _controller.createBlank(name.trim());
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => LanguageEditorScreen(controller: _controller, spec: spec)));
  }

  Future<void> _createFromExample() async {
    final spec = await _controller.createFromExample();
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => LanguageEditorScreen(controller: _controller, spec: spec)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Language Factory')),
      floatingActionButton: FloatingActionButton(onPressed: _createBlank, child: const Icon(Icons.add)),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: Colors.indigo.withOpacity(0.08),
                child: ListTile(
                  leading: const Icon(Icons.lightbulb_outline, color: Colors.indigo),
                  title: const Text('See a working example first'),
                  subtitle: const Text('A tiny language with a "repeat" keyword and a "say" keyword.'),
                  trailing: FilledButton(onPressed: _createFromExample, child: const Text('Try it')),
                ),
              ),
              const SizedBox(height: 16),
              if (_controller.specs.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: Text('No languages yet — invent one!', style: TextStyle(color: Colors.grey.shade600))),
                )
              else
                ..._controller.specs.map((spec) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(spec.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${spec.rules.length} rule${spec.rules.length == 1 ? '' : 's'}'),
                      trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.delete(spec.id)),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LanguageEditorScreen(controller: _controller, spec: spec))),
                    ),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}

/// The core workbench: define rules on one tab, write and run code in
/// your invented language on the other — seeing the compiled real
/// JavaScript and the actual console output side by side.
class LanguageEditorScreen extends StatefulWidget {
  final LanguageFactoryController controller;
  final LanguageSpec spec;

  const LanguageEditorScreen({super.key, required this.controller, required this.spec});

  @override
  State<LanguageEditorScreen> createState() => _LanguageEditorScreenState();
}

class _LanguageEditorScreenState extends State<LanguageEditorScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TextEditingController _codeController;
  late final WebViewController _webViewController;

  CompileResult? _lastCompile;
  List<String> _consoleLines = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _codeController = TextEditingController(text: widget.spec.sampleCode);
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('WebLabLangConsole', onMessageReceived: _handleConsoleMessage);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _handleConsoleMessage(JavaScriptMessage message) {
    setState(() => _consoleLines.add(message.message));
  }

  Future<void> _addRule() async {
    widget.controller.addRule(widget.spec);
    await widget.controller.save(widget.spec);
  }

  Future<void> _editRule(LanguageRule rule) async {
    final patternController = TextEditingController(text: rule.pattern);
    final replacementController = TextEditingController(text: rule.replacement);
    final descriptionController = TextEditingController(text: rule.description);

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit rule'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Find (regex pattern)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              TextField(controller: patternController, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
              const SizedBox(height: 12),
              const Text('Replace with (use \$1, \$2 for captured groups)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              TextField(controller: replacementController, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
              const SizedBox(height: 12),
              const Text('Description (optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              TextField(controller: descriptionController),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );

    if (saved != true) return;
    rule.pattern = patternController.text;
    rule.replacement = replacementController.text;
    rule.description = descriptionController.text;
    await widget.controller.save(widget.spec);
    setState(() {});
  }

  Future<void> _run() async {
    widget.spec.sampleCode = _codeController.text;
    await widget.controller.save(widget.spec);

    final result = widget.controller.compile(widget.spec, _codeController.text);
    setState(() {
      _lastCompile = result;
      _consoleLines = [];
    });

    if (result.error != null) return;

    final document = '''
<!DOCTYPE html><html><head><meta charset="UTF-8"></head><body>
<script>
(function () {
  var originalLog = console.log;
  console.log = function () {
    var msg = Array.prototype.slice.call(arguments).map(function (a) {
      try { return typeof a === 'object' ? JSON.stringify(a) : String(a); } catch (e) { return String(a); }
    }).join(' ');
    if (window.WebLabLangConsole) window.WebLabLangConsole.postMessage(msg);
    originalLog.apply(console, arguments);
  };
  try {
${result.compiledJs}
  } catch (e) {
    if (window.WebLabLangConsole) window.WebLabLangConsole.postMessage('Error: ' + e.message);
  }
})();
</script>
</body></html>
''';
    await _webViewController.loadHtmlString(document);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.spec.name),
        bottom: TabBar(controller: _tabController, tabs: const [Tab(text: 'Rules'), Tab(text: 'Write & Run')]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildRulesTab(), _buildRunTab()],
      ),
    );
  }

  Widget _buildRulesTab() {
    return Column(
      children: [
        Expanded(
          child: widget.spec.rules.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No rules yet. A rule is: "when you see this pattern, replace it with this real JavaScript."',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.spec.rules.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final rule = widget.spec.rules[index];
                    return Card(
                      child: ListTile(
                        title: Text(rule.pattern.isEmpty ? '(empty pattern)' : rule.pattern, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
                        subtitle: Text(rule.description.isEmpty ? '→ ${rule.replacement}' : rule.description, style: const TextStyle(fontSize: 12)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18),
                          onPressed: () async {
                            widget.controller.removeRule(widget.spec, rule.id);
                            await widget.controller.save(widget.spec);
                            setState(() {});
                          },
                        ),
                        onTap: () => _editRule(rule),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(icon: const Icon(Icons.add), label: const Text('Add rule'), onPressed: () async { await _addRule(); setState(() {}); }),
          ),
        ),
      ],
    );
  }

  Widget _buildRunTab() {
    return Column(
      children: [
        SizedBox(width: 1, height: 1, child: WebViewWidget(controller: _webViewController)),
        Expanded(
          flex: 2,
          child: Container(
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Write in "${widget.spec.name}"', style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Expanded(
                  child: TextField(
                    controller: _codeController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 13, color: Color(0xFFD4D4D4)),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.play_arrow), label: const Text('Compile & Run'), onPressed: _run)),
        ),
        if (_lastCompile != null)
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey.shade100,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_lastCompile!.error != null)
                      Text(_lastCompile!.error!, style: const TextStyle(color: Colors.red, fontSize: 12))
                    else ...[
                      const Text('Compiled to real JavaScript:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        color: Colors.black87,
                        child: Text(_lastCompile!.compiledJs, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF9CDCFE))),
                      ),
                      const SizedBox(height: 10),
                      const Text('Console output:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ..._consoleLines.map((line) => Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
