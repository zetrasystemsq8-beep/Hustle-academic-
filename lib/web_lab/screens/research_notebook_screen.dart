import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../research/research_models.dart';

/// Owns the currently loaded research notebook for one project.
class ResearchNotebookController extends ChangeNotifier {
  final ResearchNotebookRepository _repository = ResearchNotebookRepository();
  ResearchNotebook? _notebook;
  bool _isLoading = false;

  ResearchNotebook? get notebook => _notebook;
  bool get isLoading => _isLoading;

  Future<void> load(String projectId) async {
    _isLoading = true;
    notifyListeners();
    _notebook = await _repository.load(projectId);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addEntry(ResearchEntryType type, String content) async {
    final current = _notebook;
    if (current == null || content.trim().isEmpty) return;

    current.entries.add(ResearchEntry(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      type: type,
      content: content.trim(),
      createdAt: DateTime.now(),
    ));

    await _repository.save(current);
    notifyListeners();
  }
}

/// The Research Notebook: a structured, append-only log for one
/// project's investigations — Hypothesis, Method, Result, Conclusion.
/// This is the foundation every later research system (RFCs, peer
/// review, the knowledge graph) attaches findings to.
class ResearchNotebookScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  const ResearchNotebookScreen({super.key, required this.projectId, required this.projectName});

  @override
  State<ResearchNotebookScreen> createState() => _ResearchNotebookScreenState();
}

class _ResearchNotebookScreenState extends State<ResearchNotebookScreen> {
  late final ResearchNotebookController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ResearchNotebookController();
    _controller.load(widget.projectId);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addEntry(ResearchEntryType type) async {
    final textController = TextEditingController();
    final content = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New ${type.label}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(type.prompt, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            const SizedBox(height: 12),
            TextField(controller: textController, autofocus: true, maxLines: 5),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, textController.text), child: const Text('Save')),
        ],
      ),
    );
    if (content == null || content.trim().isEmpty) return;
    await _controller.addEntry(type, content);
  }

  Color _colorFor(ResearchEntryType type) {
    switch (type) {
      case ResearchEntryType.hypothesis:
        return Colors.purple;
      case ResearchEntryType.method:
        return Colors.blue;
      case ResearchEntryType.result:
        return Colors.orange;
      case ResearchEntryType.conclusion:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Research — ${widget.projectName}')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
          final notebook = _controller.notebook;
          if (notebook == null) return const SizedBox.shrink();

          if (notebook.entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No entries yet. Start with a Hypothesis — what do you think will happen?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            );
          }

          final sorted = List.of(notebook.entries)..sort((a, b) => a.createdAt.compareTo(b.createdAt));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              final entry = sorted[index];
              final color = _colorFor(entry.type);
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                            child: Text(entry.type.label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11)),
                          ),
                          const Spacer(),
                          Text(
                            '${entry.createdAt.month}/${entry.createdAt.day} ${entry.createdAt.hour}:${entry.createdAt.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(entry.content),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: PopupMenuButton<ResearchEntryType>(
        icon: const Icon(Icons.add),
        onSelected: _addEntry,
        itemBuilder: (context) => ResearchEntryType.values
            .map((type) => PopupMenuItem(value: type, child: Text('Add ${type.label}')))
            .toList(),
        child: FloatingActionButton(onPressed: null, child: const Icon(Icons.add)),
      ),
    );
  }
}
