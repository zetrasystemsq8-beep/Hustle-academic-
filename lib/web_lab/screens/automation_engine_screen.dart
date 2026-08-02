import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/project_controller.dart';

// ============================================================
// MODELS
// ============================================================

enum TriggerType { pageLoad, elementClick, timerInterval }
enum ConditionType { none, elementTextEquals, variableEquals }
enum ActionType { setText, setStyleProperty, toggleVisibility, incrementVariable, runCustomJs, showAlert }

extension TriggerTypeLabel on TriggerType {
  String get label {
    switch (this) {
      case TriggerType.pageLoad:
        return 'When the page loads';
      case TriggerType.elementClick:
        return 'When an element is clicked';
      case TriggerType.timerInterval:
        return 'Every N seconds';
    }
  }
}

extension ConditionTypeLabel on ConditionType {
  String get label {
    switch (this) {
      case ConditionType.none:
        return 'Always run';
      case ConditionType.elementTextEquals:
        return 'If element text equals...';
      case ConditionType.variableEquals:
        return 'If a variable equals...';
    }
  }
}

extension ActionTypeLabel on ActionType {
  String get label {
    switch (this) {
      case ActionType.setText:
        return 'Set element text';
      case ActionType.setStyleProperty:
        return 'Set a CSS property';
      case ActionType.toggleVisibility:
        return 'Show / hide element';
      case ActionType.incrementVariable:
        return 'Increment a variable';
      case ActionType.runCustomJs:
        return 'Run custom JavaScript';
      case ActionType.showAlert:
        return 'Show an alert message';
    }
  }
}

/// One automation rule: a trigger, an optional condition gating it, and
/// a sequence of actions run in order — the actual building block of
/// "an automation platform," made concrete rather than abstract.
class AutomationRule {
  final String id;
  String name;
  TriggerType trigger;
  String triggerSelector; // for elementClick
  int triggerIntervalSeconds; // for timerInterval

  ConditionType condition;
  String conditionSelector;
  String conditionValue;

  List<AutomationAction> actions;

  AutomationRule({
    required this.id,
    required this.name,
    this.trigger = TriggerType.pageLoad,
    this.triggerSelector = '',
    this.triggerIntervalSeconds = 5,
    this.condition = ConditionType.none,
    this.conditionSelector = '',
    this.conditionValue = '',
    List<AutomationAction>? actions,
  }) : actions = actions ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'trigger': trigger.name,
        'triggerSelector': triggerSelector,
        'triggerIntervalSeconds': triggerIntervalSeconds,
        'condition': condition.name,
        'conditionSelector': conditionSelector,
        'conditionValue': conditionValue,
        'actions': actions.map((a) => a.toJson()).toList(),
      };

  factory AutomationRule.fromJson(Map<String, dynamic> json) {
    return AutomationRule(
      id: json['id'] as String,
      name: json['name'] as String,
      trigger: TriggerType.values.byName(json['trigger'] as String? ?? 'pageLoad'),
      triggerSelector: json['triggerSelector'] as String? ?? '',
      triggerIntervalSeconds: json['triggerIntervalSeconds'] as int? ?? 5,
      condition: ConditionType.values.byName(json['condition'] as String? ?? 'none'),
      conditionSelector: json['conditionSelector'] as String? ?? '',
      conditionValue: json['conditionValue'] as String? ?? '',
      actions: (json['actions'] as List<dynamic>? ?? []).map((a) => AutomationAction.fromJson(a as Map<String, dynamic>)).toList(),
    );
  }
}

class AutomationAction {
  final String id;
  ActionType type;
  String targetSelector;
  String property; // for setStyleProperty
  String value;
  String variableName; // for incrementVariable

  AutomationAction({
    required this.id,
    required this.type,
    this.targetSelector = '',
    this.property = '',
    this.value = '',
    this.variableName = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'targetSelector': targetSelector,
        'property': property,
        'value': value,
        'variableName': variableName,
      };

  factory AutomationAction.fromJson(Map<String, dynamic> json) {
    return AutomationAction(
      id: json['id'] as String,
      type: ActionType.values.byName(json['type'] as String),
      targetSelector: json['targetSelector'] as String? ?? '',
      property: json['property'] as String? ?? '',
      value: json['value'] as String? ?? '',
      variableName: json['variableName'] as String? ?? '',
    );
  }
}

/// A named collection of rules — one automation "program" a student
/// builds for their project.
class AutomationWorkflow {
  final String id;
  final String projectId;
  String name;
  List<AutomationRule> rules;
  DateTime updatedAt;

  AutomationWorkflow({
    required this.id,
    required this.projectId,
    required this.name,
    List<AutomationRule>? rules,
    DateTime? updatedAt,
  })  : rules = rules ?? [],
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'projectId': projectId,
        'name': name,
        'rules': rules.map((r) => r.toJson()).toList(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory AutomationWorkflow.fromJson(Map<String, dynamic> json) {
    return AutomationWorkflow(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      name: json['name'] as String,
      rules: (json['rules'] as List<dynamic>? ?? []).map((r) => AutomationRule.fromJson(r as Map<String, dynamic>)).toList(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

// ============================================================
// REPOSITORY
// ============================================================

class AutomationRepository {
  static const String _storageKey = 'web_lab.automation_workflows';

  Future<List<AutomationWorkflow>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => AutomationWorkflow.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<AutomationWorkflow> workflows) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(workflows.map((w) => w.toJson()).toList()));
  }
}

// ============================================================
// JS COMPILER — turns the visual rule set into real, readable JS
// ============================================================

class AutomationCompiler {
  /// Generates the actual `<script>` body implementing every rule in
  /// [workflow] — real DOM APIs, real event listeners, real setInterval
  /// — nothing simulated. This is the code that would actually get
  /// pasted into script.js if a student wanted to "graduate" out of the
  /// visual builder later.
  String compile(AutomationWorkflow workflow) {
    final buffer = StringBuffer();
    buffer.writeln('// Generated by Automation Engine — workflow "${workflow.name}"');
    buffer.writeln('var __automationVars = {};');
    buffer.writeln();

    for (final rule in workflow.rules) {
      final actionsJs = rule.actions.map(_compileAction).join('\n    ');
      final conditionJs = _compileCondition(rule);
      final body = conditionJs.isEmpty
          ? '    $actionsJs'
          : '    if ($conditionJs) {\n      ${actionsJs.replaceAll('\n    ', '\n      ')}\n    }';

      switch (rule.trigger) {
        case TriggerType.pageLoad:
          buffer.writeln('// Rule: ${rule.name}');
          buffer.writeln('(function () {');
          buffer.writeln(body);
          buffer.writeln('})();');
          break;
        case TriggerType.elementClick:
          buffer.writeln('// Rule: ${rule.name}');
          buffer.writeln('document.querySelectorAll(${_jsString(rule.triggerSelector)}).forEach(function (el) {');
          buffer.writeln('  el.addEventListener("click", function () {');
          buffer.writeln(body);
          buffer.writeln('  });');
          buffer.writeln('});');
          break;
        case TriggerType.timerInterval:
          buffer.writeln('// Rule: ${rule.name}');
          buffer.writeln('setInterval(function () {');
          buffer.writeln(body);
          buffer.writeln('}, ${rule.triggerIntervalSeconds * 1000});');
          break;
      }
      buffer.writeln();
    }

    return buffer.toString();
  }

  String _compileCondition(AutomationRule rule) {
    switch (rule.condition) {
      case ConditionType.none:
        return '';
      case ConditionType.elementTextEquals:
        return 'document.querySelector(${_jsString(rule.conditionSelector)}) && document.querySelector(${_jsString(rule.conditionSelector)}).innerText === ${_jsString(rule.conditionValue)}';
      case ConditionType.variableEquals:
        return '__automationVars[${_jsString(rule.conditionSelector)}] == ${_jsString(rule.conditionValue)}';
    }
  }

  String _compileAction(AutomationAction action) {
    switch (action.type) {
      case ActionType.setText:
        return 'document.querySelectorAll(${_jsString(action.targetSelector)}).forEach(function (el) { el.innerText = ${_jsString(action.value)}; });';
      case ActionType.setStyleProperty:
        return 'document.querySelectorAll(${_jsString(action.targetSelector)}).forEach(function (el) { el.style.${_camelCase(action.property)} = ${_jsString(action.value)}; });';
      case ActionType.toggleVisibility:
        return 'document.querySelectorAll(${_jsString(action.targetSelector)}).forEach(function (el) { el.style.display = (el.style.display === "none") ? "" : "none"; });';
      case ActionType.incrementVariable:
        return '__automationVars[${_jsString(action.variableName)}] = (__automationVars[${_jsString(action.variableName)}] || 0) + 1;';
      case ActionType.runCustomJs:
        return action.value;
      case ActionType.showAlert:
        return 'alert(${_jsString(action.value)});';
    }
  }

  String _jsString(String value) => jsonEncode(value);

  String _camelCase(String cssProperty) {
    final parts = cssProperty.split('-');
    if (parts.length == 1) return cssProperty;
    return parts.first + parts.skip(1).map((p) => p.isEmpty ? '' : p[0].toUpperCase() + p.substring(1)).join();
  }
}

// ============================================================
// CONTROLLER
// ============================================================

class AutomationController extends ChangeNotifier {
  final AutomationRepository _repository = AutomationRepository();
  final AutomationCompiler _compiler = AutomationCompiler();
  List<AutomationWorkflow> _all = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<AutomationWorkflow> forProject(String projectId) => _all.where((w) => w.projectId == projectId).toList();

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _all = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<AutomationWorkflow> create(String name, String projectId) async {
    final workflow = AutomationWorkflow(id: '${DateTime.now().microsecondsSinceEpoch}', projectId: projectId, name: name);
    _all.add(workflow);
    await _repository.saveAll(_all);
    notifyListeners();
    return workflow;
  }

  Future<void> save(AutomationWorkflow workflow) async {
    workflow.updatedAt = DateTime.now();
    await _repository.saveAll(_all);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _all.removeWhere((w) => w.id == id);
    await _repository.saveAll(_all);
    notifyListeners();
  }

  void addRule(AutomationWorkflow workflow) {
    workflow.rules.add(AutomationRule(id: '${DateTime.now().microsecondsSinceEpoch}', name: 'New Rule'));
    notifyListeners();
  }

  void removeRule(AutomationWorkflow workflow, String ruleId) {
    workflow.rules.removeWhere((r) => r.id == ruleId);
    notifyListeners();
  }

  void addAction(AutomationRule rule) {
    rule.actions.add(AutomationAction(id: '${DateTime.now().microsecondsSinceEpoch}', type: ActionType.setText));
    notifyListeners();
  }

  void removeAction(AutomationRule rule, String actionId) {
    rule.actions.removeWhere((a) => a.id == actionId);
    notifyListeners();
  }

  String compile(AutomationWorkflow workflow) => _compiler.compile(workflow);

  Future<void> insertIntoProject(ProjectController projectController, AutomationWorkflow workflow) async {
    final project = projectController.currentProject;
    final scriptFile = project?.scriptJs;
    if (project == null || scriptFile == null) return;
    scriptFile.content = '${scriptFile.content}\n\n${compile(workflow)}';
    projectController.notifyProjectChanged();
    await projectController.saveCurrentProject();
  }
}

// ============================================================
// SCREENS
// ============================================================

class AutomationListScreen extends StatefulWidget {
  final ProjectController projectController;

  const AutomationListScreen({super.key, required this.projectController});

  @override
  State<AutomationListScreen> createState() => _AutomationListScreenState();
}

class _AutomationListScreenState extends State<AutomationListScreen> {
  late final AutomationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AutomationController();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createNew() async {
    final project = widget.projectController.currentProject;
    if (project == null) return;
    final nameController = TextEditingController(text: 'My Workflow');
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New workflow'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final workflow = await _controller.create(name.trim(), project.id);
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => WorkflowEditorScreen(controller: _controller, workflow: workflow, projectController: widget.projectController)));
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.projectController.currentProject;
    if (project == null) return const Scaffold(body: Center(child: Text('No project open.')));

    return Scaffold(
      appBar: AppBar(title: Text('Automation — ${project.name}')),
      floatingActionButton: FloatingActionButton(onPressed: _createNew, child: const Icon(Icons.add)),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
          final list = _controller.forProject(project.id);

          if (list.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('No workflows yet. A workflow is: "when this happens, do this."', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final workflow = list[index];
              return Card(
                child: ListTile(
                  title: Text(workflow.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${workflow.rules.length} rule${workflow.rules.length == 1 ? '' : 's'}'),
                  trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.delete(workflow.id)),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WorkflowEditorScreen(controller: _controller, workflow: workflow, projectController: widget.projectController))),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class WorkflowEditorScreen extends StatefulWidget {
  final AutomationController controller;
  final AutomationWorkflow workflow;
  final ProjectController projectController;

  const WorkflowEditorScreen({super.key, required this.controller, required this.workflow, required this.projectController});

  @override
  State<WorkflowEditorScreen> createState() => _WorkflowEditorScreenState();
}

class _WorkflowEditorScreenState extends State<WorkflowEditorScreen> {
  bool _showCode = false;

  Future<void> _editRule(AutomationRule rule) async {
    await showDialog(
      context: context,
      builder: (context) => _RuleEditorDialog(controller: widget.controller, rule: rule, onChanged: () => setState(() {})),
    );
    await widget.controller.save(widget.workflow);
  }

  Future<void> _insertIntoProject() async {
    await widget.controller.insertIntoProject(widget.projectController, widget.workflow);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to script.js')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workflow.name),
        actions: [
          IconButton(icon: Icon(_showCode ? Icons.tune : Icons.code), onPressed: () => setState(() => _showCode = !_showCode)),
        ],
      ),
      body: _showCode ? _buildCodeView() : _buildRulesView(),
      floatingActionButton: _showCode
          ? null
          : FloatingActionButton(
              onPressed: () {
                widget.controller.addRule(widget.workflow);
                widget.controller.save(widget.workflow);
                setState(() {});
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  Widget _buildRulesView() {
    if (widget.workflow.rules.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('No rules yet. Tap + to add: Trigger → Condition (optional) → Actions.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: widget.workflow.rules.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final rule = widget.workflow.rules[index];
        return Card(
          child: ListTile(
            title: Text(rule.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${rule.trigger.label} · ${rule.actions.length} action${rule.actions.length == 1 ? '' : 's'}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, size: 18),
              onPressed: () {
                widget.controller.removeRule(widget.workflow, rule.id);
                widget.controller.save(widget.workflow);
                setState(() {});
              },
            ),
            onTap: () => _editRule(rule),
          ),
        );
      },
    );
  }

  Widget _buildCodeView() {
    final code = widget.controller.compile(widget.workflow);
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFD4D4D4)))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.save_outlined), label: const Text('Insert into script.js'), onPressed: _insertIntoProject)),
        ),
      ],
    );
  }
}

class _RuleEditorDialog extends StatefulWidget {
  final AutomationController controller;
  final AutomationRule rule;
  final VoidCallback onChanged;

  const _RuleEditorDialog({required this.controller, required this.rule, required this.onChanged});

  @override
  State<_RuleEditorDialog> createState() => _RuleEditorDialogState();
}

class _RuleEditorDialogState extends State<_RuleEditorDialog> {
  late TextEditingController _nameController;
  late TextEditingController _triggerSelectorController;
  late TextEditingController _conditionSelectorController;
  late TextEditingController _conditionValueController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.rule.name);
    _triggerSelectorController = TextEditingController(text: widget.rule.triggerSelector);
    _conditionSelectorController = TextEditingController(text: widget.rule.conditionSelector);
    _conditionValueController = TextEditingController(text: widget.rule.conditionValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Rule'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Rule name'), onChanged: (v) => widget.rule.name = v),
              const SizedBox(height: 12),
              const Text('Trigger', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<TriggerType>(
                isExpanded: true,
                value: widget.rule.trigger,
                items: TriggerType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.label))).toList(),
                onChanged: (v) => setState(() => widget.rule.trigger = v!),
              ),
              if (widget.rule.trigger == TriggerType.elementClick)
                TextField(controller: _triggerSelectorController, decoration: const InputDecoration(labelText: 'CSS selector (e.g. #myButton)'), onChanged: (v) => widget.rule.triggerSelector = v),
              if (widget.rule.trigger == TriggerType.timerInterval)
                Row(
                  children: [
                    const Text('Every'),
                    Expanded(child: Slider(value: widget.rule.triggerIntervalSeconds.toDouble().clamp(1, 60), min: 1, max: 60, onChanged: (v) => setState(() => widget.rule.triggerIntervalSeconds = v.round()))),
                    Text('${widget.rule.triggerIntervalSeconds}s'),
                  ],
                ),
              const Divider(),
              const Text('Condition', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<ConditionType>(
                isExpanded: true,
                value: widget.rule.condition,
                items: ConditionType.values.map((c) => DropdownMenuItem(value: c, child: Text(c.label))).toList(),
                onChanged: (v) => setState(() => widget.rule.condition = v!),
              ),
              if (widget.rule.condition != ConditionType.none) ...[
                TextField(controller: _conditionSelectorController, decoration: InputDecoration(labelText: widget.rule.condition == ConditionType.elementTextEquals ? 'CSS selector' : 'Variable name'), onChanged: (v) => widget.rule.conditionSelector = v),
                TextField(controller: _conditionValueController, decoration: const InputDecoration(labelText: 'Equals value'), onChanged: (v) => widget.rule.conditionValue = v),
              ],
              const Divider(),
              Row(children: [const Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), IconButton(icon: const Icon(Icons.add), onPressed: () { widget.controller.addAction(widget.rule); setState(() {}); })]),
              ...widget.rule.actions.map((action) => _ActionEditorRow(action: action, onRemove: () { widget.controller.removeAction(widget.rule, action.id); setState(() {}); }, onChanged: () => setState(() {}))),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(onPressed: () { widget.onChanged(); Navigator.pop(context); }, child: const Text('Done')),
      ],
    );
  }
}

class _ActionEditorRow extends StatefulWidget {
  final AutomationAction action;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const _ActionEditorRow({required this.action, required this.onRemove, required this.onChanged});

  @override
  State<_ActionEditorRow> createState() => _ActionEditorRowState();
}

class _ActionEditorRowState extends State<_ActionEditorRow> {
  @override
  Widget build(BuildContext context) {
    final action = widget.action;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton<ActionType>(
                  isExpanded: true,
                  value: action.type,
                  items: ActionType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.label, style: const TextStyle(fontSize: 13)))).toList(),
                  onChanged: (v) { setState(() => action.type = v!); widget.onChanged(); },
                ),
              ),
              IconButton(icon: const Icon(Icons.close, size: 16), onPressed: widget.onRemove),
            ],
          ),
          if (action.type != ActionType.incrementVariable && action.type != ActionType.runCustomJs && action.type != ActionType.showAlert)
            TextField(
              decoration: const InputDecoration(labelText: 'CSS selector', isDense: true),
              controller: TextEditingController(text: action.targetSelector),
              onChanged: (v) { action.targetSelector = v; widget.onChanged(); },
            ),
          if (action.type == ActionType.setStyleProperty)
            TextField(
              decoration: const InputDecoration(labelText: 'CSS property (e.g. background-color)', isDense: true),
              controller: TextEditingController(text: action.property),
              onChanged: (v) { action.property = v; widget.onChanged(); },
            ),
          if (action.type == ActionType.incrementVariable)
            TextField(
              decoration: const InputDecoration(labelText: 'Variable name', isDense: true),
              controller: TextEditingController(text: action.variableName),
              onChanged: (v) { action.variableName = v; widget.onChanged(); },
            ),
          if (action.type == ActionType.setText || action.type == ActionType.setStyleProperty || action.type == ActionType.showAlert)
            TextField(
              decoration: InputDecoration(labelText: action.type == ActionType.showAlert ? 'Message' : 'Value', isDense: true),
              controller: TextEditingController(text: action.value),
              onChanged: (v) { action.value = v; widget.onChanged(); },
            ),
          if (action.type == ActionType.runCustomJs)
            TextField(
              decoration: const InputDecoration(labelText: 'JavaScript code', isDense: true),
              controller: TextEditingController(text: action.value),
              maxLines: 3,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              onChanged: (v) { action.value = v; widget.onChanged(); },
            ),
        ],
      ),
    );
  }
}
