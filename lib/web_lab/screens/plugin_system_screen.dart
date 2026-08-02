import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'automation_engine_screen.dart' show AutomationRepository, AutomationWorkflow;
import 'language_factory_screen.dart' show LanguageFactoryRepository, LanguageSpec;
import 'tool_builder_screen.dart' show ToolBuilderRepository, CustomLinter;

// ============================================================
// MODELS
// ============================================================

enum PluginType { language, automationWorkflow, linter }

extension PluginTypeLabel on PluginType {
  String get label {
    switch (this) {
      case PluginType.language:
        return 'Language (Language Factory)';
      case PluginType.automationWorkflow:
        return 'Workflow (Automation Engine)';
      case PluginType.linter:
        return 'Tool (Tool Builder)';
    }
  }

  IconData get icon {
    switch (this) {
      case PluginType.language:
        return Icons.translate;
      case PluginType.automationWorkflow:
        return Icons.bolt_outlined;
      case PluginType.linter:
        return Icons.build_outlined;
    }
  }
}

/// A published plugin: some other tool's saved data (a language spec, a
/// workflow, a linter) packaged with metadata so it's installable into
/// another student's own local library for that same tool — genuine
/// reuse across the whole Innovation Engine, not a separate system.
class PluginPackage {
  final String id;
  final String name;
  final String description;
  final PluginType type;
  final String? authorName;
  final Map<String, dynamic> payload;
  final DateTime createdAt;

  const PluginPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.authorName,
    required this.payload,
    required this.createdAt,
  });

  factory PluginPackage.fromRow(Map<String, dynamic> row) {
    return PluginPackage(
      id: row['id'] as String,
      name: row['name'] as String,
      description: row['description'] as String? ?? '',
      type: PluginType.values.byName(row['plugin_type'] as String),
      authorName: row['author_name'] as String?,
      payload: row['payload'] as Map<String, dynamic>,
      createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

// ============================================================
// REPOSITORY
// ============================================================

class PluginRepository {
  static const String _tableName = 'web_lab_plugins';
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<PluginPackage>> fetchAll() async {
    final rows = await _client.from(_tableName).select().order('created_at', ascending: false);
    return (rows as List).map((r) => PluginPackage.fromRow(r as Map<String, dynamic>)).toList();
  }

  Future<void> publish({
    required String name,
    required String description,
    required PluginType type,
    required String? authorName,
    required Map<String, dynamic> payload,
  }) async {
    await _client.from(_tableName).insert({
      'name': name,
      'description': description,
      'plugin_type': type.name,
      'author_name': authorName,
      'payload': payload,
    });
  }
}

// ============================================================
// CONTROLLER
// ============================================================

class PluginController extends ChangeNotifier {
  final PluginRepository _repository = PluginRepository();
  final LanguageFactoryRepository _languageRepository = LanguageFactoryRepository();
  final AutomationRepository _automationRepository = AutomationRepository();
  final ToolBuilderRepository _toolRepository = ToolBuilderRepository();

  List<PluginPackage> _plugins = [];
  bool _isLoading = false;
  String? _error;
  PluginType? _filter;

  bool get isLoading => _isLoading;
  String? get error => _error;
  PluginType? get filter => _filter;

  List<PluginPackage> get filtered => _filter == null ? _plugins : _plugins.where((p) => p.type == _filter).toList();

  void setFilter(PluginType? type) {
    _filter = type;
    notifyListeners();
  }

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _plugins = await _repository.fetchAll();
    } catch (e) {
      _error = 'Could not load plugins. Check your connection.';
    }
    _isLoading = false;
    notifyListeners();
  }

  /// Lists what's locally available to publish, per type — reads
  /// straight from each tool's own repository so this stays a thin
  /// integration layer rather than duplicating any tool's storage.
  Future<List<LanguageSpec>> localLanguages() => _languageRepository.loadAll();
  Future<List<AutomationWorkflow>> localWorkflows() => _automationRepository.loadAll();
  Future<List<CustomLinter>> localLinters() => _toolRepository.loadAll();

  Future<bool> publishLanguage(LanguageSpec spec, String? authorName) async {
    try {
      await _repository.publish(name: spec.name, description: spec.description, type: PluginType.language, authorName: authorName, payload: spec.toJson());
      await load();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> publishWorkflow(AutomationWorkflow workflow, String description, String? authorName) async {
    try {
      await _repository.publish(name: workflow.name, description: description, type: PluginType.automationWorkflow, authorName: authorName, payload: workflow.toJson());
      await load();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> publishLinter(CustomLinter linter, String? authorName) async {
    try {
      await _repository.publish(name: linter.name, description: linter.description, type: PluginType.linter, authorName: authorName, payload: linter.toJson());
      await load();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Installs a fetched [plugin] into the correct local tool's own
  /// storage, using that tool's own model deserialization — after
  /// install, it appears in Language Factory / Automation Engine / Tool
  /// Builder exactly like anything the student built themselves.
  Future<void> install(PluginPackage plugin) async {
    switch (plugin.type) {
      case PluginType.language:
        final languages = await _languageRepository.loadAll();
        languages.add(LanguageSpec.fromJson({...plugin.payload, 'id': '${DateTime.now().microsecondsSinceEpoch}'}));
        await _languageRepository.saveAll(languages);
        break;
      case PluginType.automationWorkflow:
        final workflows = await _automationRepository.loadAll();
        workflows.add(AutomationWorkflow.fromJson({...plugin.payload, 'id': '${DateTime.now().microsecondsSinceEpoch}', 'projectId': ''}));
        await _automationRepository.saveAll(workflows);
        break;
      case PluginType.linter:
        final linters = await _toolRepository.loadAll();
        linters.add(CustomLinter.fromJson({...plugin.payload, 'id': '${DateTime.now().microsecondsSinceEpoch}'}));
        await _toolRepository.saveAll(linters);
        break;
    }
  }
}

// ============================================================
// SCREENS
// ============================================================

class PluginSystemScreen extends StatefulWidget {
  const PluginSystemScreen({super.key});

  @override
  State<PluginSystemScreen> createState() => _PluginSystemScreenState();
}

class _PluginSystemScreenState extends State<PluginSystemScreen> {
  late final PluginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PluginController();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _install(PluginPackage plugin) async {
    await _controller.install(plugin);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Installed "${plugin.name}" — find it in ${plugin.type.label.split(' (').last.replaceAll(')', '')}.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin System')),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.upload_outlined),
        label: const Text('Publish'),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PluginPublishScreen(controller: _controller))),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
          if (_controller.error != null) {
            return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_controller.error!), TextButton(onPressed: _controller.load, child: const Text('Retry'))]));
          }

          return Column(
            children: [
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: const Text('All'), selected: _controller.filter == null, onSelected: (_) => _controller.setFilter(null))),
                    ...PluginType.values.map((t) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(t.label.split(' (').first), selected: _controller.filter == t, onSelected: (_) => _controller.setFilter(t)))),
                  ],
                ),
              ),
              Expanded(
                child: _controller.filtered.isEmpty
                    ? Center(child: Text('No plugins here yet — be the first to publish one!', style: TextStyle(color: Colors.grey.shade600)))
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        itemCount: _controller.filtered.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final plugin = _controller.filtered[index];
                          return Card(
                            child: ListTile(
                              leading: Icon(plugin.type.icon),
                              title: Text(plugin.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${plugin.description}${plugin.authorName != null ? '\nby ${plugin.authorName}' : ''}'),
                              isThreeLine: plugin.authorName != null,
                              trailing: FilledButton.tonal(onPressed: () => _install(plugin), child: const Text('Install')),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PluginPublishScreen extends StatefulWidget {
  final PluginController controller;

  const PluginPublishScreen({super.key, required this.controller});

  @override
  State<PluginPublishScreen> createState() => _PluginPublishScreenState();
}

class _PluginPublishScreenState extends State<PluginPublishScreen> {
  PluginType _selectedType = PluginType.language;
  final TextEditingController _authorController = TextEditingController();

  Future<void> _publishLanguage(LanguageSpec spec) async {
    final success = await widget.controller.publishLanguage(spec, _authorController.text.trim().isEmpty ? null : _authorController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Published!' : 'Failed to publish.')));
    if (success) Navigator.pop(context);
  }

  Future<void> _publishWorkflow(AutomationWorkflow workflow) async {
    final descriptionController = TextEditingController(text: 'A workflow for ${workflow.name}');
    final description = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Describe this workflow'),
        content: TextField(controller: descriptionController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, descriptionController.text), child: const Text('Publish')),
        ],
      ),
    );
    if (description == null) return;
    final success = await widget.controller.publishWorkflow(workflow, description, _authorController.text.trim().isEmpty ? null : _authorController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Published!' : 'Failed to publish.')));
    if (success) Navigator.pop(context);
  }

  Future<void> _publishLinter(CustomLinter linter) async {
    final success = await widget.controller.publishLinter(linter, _authorController.text.trim().isEmpty ? null : _authorController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Published!' : 'Failed to publish.')));
    if (success) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Publish a Plugin')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(controller: _authorController, decoration: const InputDecoration(labelText: 'Your name (optional)', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                SegmentedButton<PluginType>(
                  segments: PluginType.values.map((t) => ButtonSegment(value: t, label: Text(t.label.split(' (').first))).toList(),
                  selected: {_selectedType},
                  onSelectionChanged: (s) => setState(() => _selectedType = s.first),
                ),
              ],
            ),
          ),
          Expanded(
            child: switch (_selectedType) {
              PluginType.language => FutureBuilder<List<LanguageSpec>>(
                  future: widget.controller.localLanguages(),
                  builder: (context, snapshot) {
                    final list = snapshot.data ?? [];
                    if (list.isEmpty) return const Center(child: Text('No languages saved yet in Language Factory.'));
                    return ListView(children: list.map((s) => ListTile(title: Text(s.name), trailing: FilledButton(onPressed: () => _publishLanguage(s), child: const Text('Publish')))).toList());
                  },
                ),
              PluginType.automationWorkflow => FutureBuilder<List<AutomationWorkflow>>(
                  future: widget.controller.localWorkflows(),
                  builder: (context, snapshot) {
                    final list = snapshot.data ?? [];
                    if (list.isEmpty) return const Center(child: Text('No workflows saved yet in Automation Engine.'));
                    return ListView(children: list.map((w) => ListTile(title: Text(w.name), trailing: FilledButton(onPressed: () => _publishWorkflow(w), child: const Text('Publish')))).toList());
                  },
                ),
              PluginType.linter => FutureBuilder<List<CustomLinter>>(
                  future: widget.controller.localLinters(),
                  builder: (context, snapshot) {
                    final list = snapshot.data ?? [];
                    if (list.isEmpty) return const Center(child: Text('No tools saved yet in Tool Builder.'));
                    return ListView(children: list.map((l) => ListTile(title: Text(l.name), trailing: FilledButton(onPressed: () => _publishLinter(l), child: const Text('Publish')))).toList());
                  },
                ),
            },
          ),
        ],
      ),
    );
  }
}
