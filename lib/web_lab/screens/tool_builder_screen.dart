import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/project_controller.dart';

// ============================================================
// MODELS
// ============================================================

enum LintSeverity { error, warning, info }

extension LintSeverityLabel on LintSeverity {
  String get label {
    switch (this) {
      case LintSeverity.error:
        return 'Error';
      case LintSeverity.warning:
        return 'Warning';
      case LintSeverity.info:
        return 'Info';
    }
  }
}

enum LintTarget { html, css, js }

/// One rule in a student-built linter: a regex pattern, which file type
/// it scans, a severity, and the message shown when it matches. This is
/// genuinely how real linters work under the hood — a set of pattern
/// checks producing diagnostics — just authored by the student instead
/// of a tooling team.
class LintRule {
  final String id;
  String pattern;
  LintTarget target;
  LintSeverity severity;
  String message;
  bool flagOnMatch; // true: match = problem. false: match required, absence = problem.

  LintRule({
    required this.id,
    this.pattern = '',
    this.target = LintTarget.html,
    this.severity = LintSeverity.warning,
    this.message = '',
    this.flagOnMatch = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'pattern': pattern,
        'target': target.name,
        'severity': severity.name,
        'message': message,
        'flagOnMatch': flagOnMatch,
      };

  factory LintRule.fromJson(Map<String, dynamic> json) {
    return LintRule(
      id: json['id'] as String,
      pattern: json['pattern'] as String? ?? '',
      target: LintTarget.values.byName(json['target'] as String? ?? 'html'),
      severity: LintSeverity.values.byName(json['severity'] as String? ?? 'warning'),
      message: json['message'] as String? ?? '',
      flagOnMatch: json['flagOnMatch'] as bool? ?? true,
    );
  }
}

/// A named collection of lint rules — one custom dev tool a student
/// invented, ready to run against any of their projects.
class CustomLinter {
  final String id;
  String name;
  String description;
  List<LintRule> rules;
  DateTime updatedAt;

  CustomLinter({
    required this.id,
    required this.name,
    this.description = '',
    List<LintRule>? rules,
    DateTime? updatedAt,
  })  : rules = rules ?? [],
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'rules': rules.map((r) => r.toJson()).toList(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory CustomLinter.fromJson(Map<String, dynamic> json) {
    return CustomLinter(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      rules: (json['rules'] as List<dynamic>? ?? []).map((r) => LintRule.fromJson(r as Map<String, dynamic>)).toList(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  factory CustomLinter.starterExample() {
    return CustomLinter(
      id: 'starter_${DateTime.now().microsecondsSinceEpoch}',
      name: 'No Inline Styles (example)',
      description: 'Flags any style="..." attribute, encouraging CSS files instead of inline styling.',
      rules: [
        LintRule(id: 'r1', pattern: r'style\s*=\s*"', target: LintTarget.html, severity: LintSeverity.warning, message: 'Avoid inline styles — move this to style.css instead.', flagOnMatch: true),
        LintRule(id: 'r2', pattern: r'<h1', target: LintTarget.html, severity: LintSeverity.error, message: 'Every page needs at least one <h1>.', flagOnMatch: false),
      ],
    );
  }
}

class LintFinding {
  final LintSeverity severity;
  final String message;
  final LintTarget target;

  const LintFinding({required this.severity, required this.message, required this.target});
}

// ============================================================
// REPOSITORY
// ============================================================

class ToolBuilderRepository {
  static const String _storageKey = 'web_lab.custom_linters';

  Future<List<CustomLinter>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List<dynamic>).map((e) => CustomLinter.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<CustomLinter> linters) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(linters.map((l) => l.toJson()).toList()));
  }
}

// ============================================================
// LINT ENGINE
// ============================================================

class LintEngine {
  List<LintFinding> run(CustomLinter linter, {required String html, required String css, required String js}) {
    final findings = <LintFinding>[];

    for (final rule in linter.rules) {
      if (rule.pattern.trim().isEmpty || rule.message.trim().isEmpty) continue;

      final source = switch (rule.target) {
        LintTarget.html => html,
        LintTarget.css => css,
        LintTarget.js => js,
      };

      RegExp regex;
      try {
        regex = RegExp(rule.pattern);
      } catch (e) {
        findings.add(LintFinding(severity: LintSeverity.error, message: 'Rule has an invalid pattern: ${rule.pattern}', target: rule.target));
        continue;
      }

      final hasMatch = regex.hasMatch(source);
      final isProblem = rule.flagOnMatch ? hasMatch : !hasMatch;

      if (isProblem) {
        findings.add(LintFinding(severity: rule.severity, message: rule.message, target: rule.target));
      }
    }

    return findings;
  }
}

// ============================================================
// CONTROLLER
// ============================================================

class ToolBuilderController extends ChangeNotifier {
  final ToolBuilderRepository _repository = ToolBuilderRepository();
  final LintEngine _engine = LintEngine();

  List<CustomLinter> _linters = [];
  bool _isLoading = false;

  List<CustomLinter> get linters => List.unmodifiable(_linters);
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _linters = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<CustomLinter> createBlank(String name) async {
    final linter = CustomLinter(id: '${DateTime.now().microsecondsSinceEpoch}', name: name);
    _linters.add(linter);
    await _repository.saveAll(_linters);
    notifyListeners();
    return linter;
  }

  Future<CustomLinter> createFromExample() async {
    final linter = CustomLinter.starterExample();
    _linters.add(linter);
    await _repository.saveAll(_linters);
    notifyListeners();
    return linter;
  }

  Future<void> save(CustomLinter linter) async {
    linter.updatedAt = DateTime.now();
    await _repository.saveAll(_linters);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _linters.removeWhere((l) => l.id == id);
    await _repository.saveAll(_linters);
    notifyListeners();
  }

  void addRule(CustomLinter linter) {
    linter.rules.add(LintRule(id: '${DateTime.now().microsecondsSinceEpoch}'));
    notifyListeners();
  }

  void removeRule(CustomLinter linter, String ruleId) {
    linter.rules.removeWhere((r) => r.id == ruleId);
    notifyListeners();
  }

  List<LintFinding> run(CustomLinter linter, {required String html, required String css, required String js}) => _engine.run(linter, html: html, css: css, js: js);
}

// ============================================================
// SCREENS
// ============================================================

class ToolBuilderListScreen extends StatefulWidget {
  final ProjectController projectController;

  const ToolBuilderListScreen({super.key, required this.projectController});

  @override
  State<ToolBuilderListScreen> createState() => _ToolBuilderListScreenState();
}

class _ToolBuilderListScreenState extends State<ToolBuilderListScreen> {
  late final ToolBuilderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ToolBuilderController();
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
        title: const Text('Name your tool'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final linter = await _controller.createBlank(name.trim());
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => ToolEditorScreen(controller: _controller, linter: linter, projectController: widget.projectController)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tool Builder')),
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
                  subtitle: const Text('A linter that flags inline styles and requires an <h1>.'),
                  trailing: FilledButton(
                    onPressed: () async {
                      final linter = await _controller.createFromExample();
                      if (!mounted) return;
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ToolEditorScreen(controller: _controller, linter: linter, projectController: widget.projectController)));
                    },
                    child: const Text('Try it'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_controller.linters.isEmpty)
                Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Center(child: Text('No custom tools yet — build your own linter.', style: TextStyle(color: Colors.grey.shade600))))
              else
                ..._controller.linters.map((linter) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(linter.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${linter.rules.length} rule${linter.rules.length == 1 ? '' : 's'}'),
                        trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.delete(linter.id)),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ToolEditorScreen(controller: _controller, linter: linter, projectController: widget.projectController))),
                      ),
                    )),
            ],
          );
        },
      ),
    );
  }
}

class ToolEditorScreen extends StatefulWidget {
  final ToolBuilderController controller;
  final CustomLinter linter;
  final ProjectController projectController;

  const ToolEditorScreen({super.key, required this.controller, required this.linter, required this.projectController});

  @override
  State<ToolEditorScreen> createState() => _ToolEditorScreenState();
}

class _ToolEditorScreenState extends State<ToolEditorScreen> {
  List<LintFinding>? _lastResults;

  Future<void> _editRule(LintRule rule) async {
    final patternController = TextEditingController(text: rule.pattern);
    final messageController = TextEditingController(text: rule.message);
    LintTarget target = rule.target;
    LintSeverity severity = rule.severity;
    bool flagOnMatch = rule.flagOnMatch;

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit rule'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(controller: patternController, decoration: const InputDecoration(labelText: 'Regex pattern'), style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
                const SizedBox(height: 8),
                DropdownButton<LintTarget>(isExpanded: true, value: target, items: LintTarget.values.map((t) => DropdownMenuItem(value: t, child: Text(t.name.toUpperCase()))).toList(), onChanged: (v) => setDialogState(() => target = v!)),
                DropdownButton<LintSeverity>(isExpanded: true, value: severity, items: LintSeverity.values.map((s) => DropdownMenuItem(value: s, child: Text(s.label))).toList(), onChanged: (v) => setDialogState(() => severity = v!)),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Flag when pattern IS found (off = flag when missing)'),
                  value: flagOnMatch,
                  onChanged: (v) => setDialogState(() => flagOnMatch = v),
                ),
                TextField(controller: messageController, decoration: const InputDecoration(labelText: 'Message shown to the student')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
          ],
        ),
      ),
    );

    if (saved != true) return;
    rule.pattern = patternController.text;
    rule.message = messageController.text;
    rule.target = target;
    rule.severity = severity;
    rule.flagOnMatch = flagOnMatch;
    await widget.controller.save(widget.linter);
    setState(() {});
  }

  void _run() {
    final project = widget.projectController.currentProject;
    if (project == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open a project first to run this tool against it.')));
      return;
    }
    setState(() {
      _lastResults = widget.controller.run(
        widget.linter,
        html: project.indexHtml?.content ?? '',
        css: project.styleCss?.content ?? '',
        js: project.scriptJs?.content ?? '',
      );
    });
  }

  Color _colorFor(LintSeverity severity) {
    switch (severity) {
      case LintSeverity.error:
        return Colors.red;
      case LintSeverity.warning:
        return Colors.orange;
      case LintSeverity.info:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.linter.name)),
      floatingActionButton: FloatingActionButton.extended(icon: const Icon(Icons.play_arrow), label: const Text('Run'), onPressed: _run),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [const Text('Rules', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), IconButton(icon: const Icon(Icons.add), onPressed: () async { widget.controller.addRule(widget.linter); await widget.controller.save(widget.linter); setState(() {}); })]),
          ...widget.linter.rules.map((rule) => Card(
                child: ListTile(
                  title: Text(rule.pattern.isEmpty ? '(empty pattern)' : rule.pattern, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                  subtitle: Text(rule.message.isEmpty ? '(no message set)' : rule.message, style: const TextStyle(fontSize: 12)),
                  trailing: IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: () async { widget.controller.removeRule(widget.linter, rule.id); await widget.controller.save(widget.linter); setState(() {}); }),
                  onTap: () => _editRule(rule),
                ),
              )),
          if (_lastResults != null) ...[
            const Divider(height: 32),
            Text('Results (${_lastResults!.length} finding${_lastResults!.length == 1 ? '' : 's'})', style: const TextStyle(fontWeight: FontWeight.bold)),
            if (_lastResults!.isEmpty)
              const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('No issues found.', style: TextStyle(color: Colors.green)))
            else
              ..._lastResults!.map((finding) => ListTile(
                    dense: true,
                    leading: Icon(Icons.circle, size: 10, color: _colorFor(finding.severity)),
                    title: Text(finding.message, style: const TextStyle(fontSize: 13)),
                    subtitle: Text('${finding.severity.label} · ${finding.target.name.toUpperCase()}', style: const TextStyle(fontSize: 11)),
                  )),
          ],
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
