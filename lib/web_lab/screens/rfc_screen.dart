import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../research/rfc_models.dart';

/// Owns the full list of RFCs and all mutation logic.
class RfcController extends ChangeNotifier {
  final RfcRepository _repository = RfcRepository();
  List<RfcDocument> _rfcs = [];
  bool _isLoading = false;

  List<RfcDocument> get rfcs => List.unmodifiable(_rfcs);
  bool get isLoading => _isLoading;

  List<RfcDocument> forProject(String projectId) => _rfcs.where((r) => r.projectId == projectId).toList();

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _rfcs = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<RfcDocument> create(String title, String projectId) async {
    final rfc = RfcDocument(id: '${DateTime.now().microsecondsSinceEpoch}', title: title, projectId: projectId);
    _rfcs.add(rfc);
    await _repository.saveAll(_rfcs);
    notifyListeners();
    return rfc;
  }

  Future<void> update(RfcDocument rfc) async {
    rfc.updatedAt = DateTime.now();
    await _repository.saveAll(_rfcs);
    notifyListeners();
  }

  Future<void> setStatus(RfcDocument rfc, RfcStatus status) async {
    rfc.status = status;
    await update(rfc);
  }

  Future<void> delete(String id) async {
    _rfcs.removeWhere((r) => r.id == id);
    await _repository.saveAll(_rfcs);
    notifyListeners();
  }
}

/// Lists every RFC across all projects — the institute's proposal
/// registry.
class RfcListScreen extends StatefulWidget {
  final String? filterProjectId;
  final String? filterProjectName;

  const RfcListScreen({super.key, this.filterProjectId, this.filterProjectName});

  @override
  State<RfcListScreen> createState() => _RfcListScreenState();
}

class _RfcListScreenState extends State<RfcListScreen> {
  late final RfcController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RfcController();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createNew() async {
    if (widget.filterProjectId == null) return;
    final titleController = TextEditingController();
    final title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New RFC'),
        content: TextField(controller: titleController, autofocus: true, decoration: const InputDecoration(hintText: 'e.g. "A faster way to structure flexbox layouts"')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, titleController.text), child: const Text('Create')),
        ],
      ),
    );
    if (title == null || title.trim().isEmpty) return;

    final rfc = await _controller.create(title.trim(), widget.filterProjectId!);
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => RfcEditorScreen(controller: _controller, rfc: rfc)));
  }

  Color _statusColor(RfcStatus status) {
    switch (status) {
      case RfcStatus.draft:
        return Colors.grey;
      case RfcStatus.underReview:
        return Colors.orange;
      case RfcStatus.accepted:
        return Colors.green;
      case RfcStatus.rejected:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.filterProjectName != null ? 'RFCs — ${widget.filterProjectName}' : 'All RFCs')),
      floatingActionButton: widget.filterProjectId != null
          ? FloatingActionButton(onPressed: _createNew, child: const Icon(Icons.add))
          : null,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());

          final list = widget.filterProjectId != null ? _controller.forProject(widget.filterProjectId!) : _controller.rfcs;

          if (list.isEmpty) {
            return const Center(child: Text('No RFCs yet.', style: TextStyle(color: Colors.grey)));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final rfc = list[index];
              return Card(
                child: ListTile(
                  title: Text(rfc.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Updated ${rfc.updatedAt.month}/${rfc.updatedAt.day}'),
                  trailing: Chip(
                    label: Text(rfc.status.label, style: const TextStyle(fontSize: 11)),
                    backgroundColor: _statusColor(rfc.status).withOpacity(0.15),
                    labelStyle: TextStyle(color: _statusColor(rfc.status)),
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RfcEditorScreen(controller: _controller, rfc: rfc))),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Edits one RFC's structured sections — Motivation, Design,
/// Alternatives, Open Questions — plus its review status.
class RfcEditorScreen extends StatefulWidget {
  final RfcController controller;
  final RfcDocument rfc;

  const RfcEditorScreen({super.key, required this.controller, required this.rfc});

  @override
  State<RfcEditorScreen> createState() => _RfcEditorScreenState();
}

class _RfcEditorScreenState extends State<RfcEditorScreen> {
  late final TextEditingController _motivationController;
  late final TextEditingController _designController;
  late final TextEditingController _alternativesController;
  late final TextEditingController _openQuestionsController;

  @override
  void initState() {
    super.initState();
    _motivationController = TextEditingController(text: widget.rfc.motivation);
    _designController = TextEditingController(text: widget.rfc.design);
    _alternativesController = TextEditingController(text: widget.rfc.alternatives);
    _openQuestionsController = TextEditingController(text: widget.rfc.openQuestions);
  }

  @override
  void dispose() {
    _motivationController.dispose();
    _designController.dispose();
    _alternativesController.dispose();
    _openQuestionsController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    widget.rfc.motivation = _motivationController.text;
    widget.rfc.design = _designController.text;
    widget.rfc.alternatives = _alternativesController.text;
    widget.rfc.openQuestions = _openQuestionsController.text;
    await widget.controller.update(widget.rfc);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('RFC saved')));
  }

  Widget _section(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(hint, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          const SizedBox(height: 6),
          TextField(controller: controller, maxLines: 5, decoration: const InputDecoration(border: OutlineInputBorder())),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rfc.title),
        actions: [
          IconButton(icon: const Icon(Icons.save_outlined), onPressed: _save),
          PopupMenuButton<RfcStatus>(
            onSelected: (status) => widget.controller.setStatus(widget.rfc, status),
            itemBuilder: (context) => RfcStatus.values.map((s) => PopupMenuItem(value: s, child: Text('Mark as ${s.label}'))).toList(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section('Motivation', 'Why does this idea matter? What problem does it solve?', _motivationController),
          _section('Design', 'How would it actually work? Describe the mechanism.', _designController),
          _section('Alternatives', 'What other approaches did you consider, and why not those?', _alternativesController),
          _section('Open Questions', 'What don\'t you know yet? What needs testing?', _openQuestionsController),
        ],
      ),
    );
  }
}
