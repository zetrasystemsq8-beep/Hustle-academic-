import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/project_model.dart';
import '../research/research_models.dart';
import '../research/rfc_models.dart';
import 'experiment_runner_screen.dart' show ExperimentRepository, Experiment;

// ============================================================
// CITATION MODEL + REPOSITORY (Supabase-backed — citations are
// cross-user by nature, someone else's template being reused)
// ============================================================

class CitationRecord {
  final String templateId;
  final String templateTitle;
  final String newProjectName;
  final DateTime createdAt;

  const CitationRecord({
    required this.templateId,
    required this.templateTitle,
    required this.newProjectName,
    required this.createdAt,
  });

  factory CitationRecord.fromRow(Map<String, dynamic> row) {
    return CitationRecord(
      templateId: row['template_id'] as String,
      templateTitle: row['template_title'] as String,
      newProjectName: row['new_project_name'] as String,
      createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

/// Records and reads the lineage of community templates: every time a
/// student's shared work gets reused by someone else, that's a citation
/// — the actual mechanism of "this is how ideas get carried forward
/// inside the institute" rather than just a copy nobody can trace.
class CitationRepository {
  static const String _tableName = 'web_lab_citations';
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> record({required String templateId, required String templateTitle, required String newProjectName}) async {
    await _client.from(_tableName).insert({
      'template_id': templateId,
      'template_title': templateTitle,
      'new_project_name': newProjectName,
    });
  }

  Future<List<CitationRecord>> fetchAll() async {
    final rows = await _client.from(_tableName).select().order('created_at', ascending: false);
    return (rows as List).map((r) => CitationRecord.fromRow(r as Map<String, dynamic>)).toList();
  }
}

// ============================================================
// CONTROLLER
// ============================================================

/// Owns two views onto "legacy": the institute-wide Citation Chain (who
/// built on whose published work), and one project's own Knowledge
/// Graph (how its research, proposals, and experiments connect).
class LegacyController extends ChangeNotifier {
  final CitationRepository _citationRepository = CitationRepository();
  final RfcRepository _rfcRepository = RfcRepository();
  final ExperimentRepository _experimentRepository = ExperimentRepository();
  final ResearchNotebookRepository _notebookRepository = ResearchNotebookRepository();

  List<CitationRecord> _citations = [];
  bool _isLoadingCitations = false;
  String? _citationsError;

  List<RfcDocument> _projectRfcs = [];
  List<Experiment> _projectExperiments = [];
  ResearchNotebook? _projectNotebook;
  bool _isLoadingGraph = false;

  List<CitationRecord> get citations => List.unmodifiable(_citations);
  bool get isLoadingCitations => _isLoadingCitations;
  String? get citationsError => _citationsError;

  List<RfcDocument> get projectRfcs => List.unmodifiable(_projectRfcs);
  List<Experiment> get projectExperiments => List.unmodifiable(_projectExperiments);
  ResearchNotebook? get projectNotebook => _projectNotebook;
  bool get isLoadingGraph => _isLoadingGraph;

  /// Groups raw citation records by template, so the Citation Chain
  /// screen can show "Portfolio Starter → reused 4 times" rather than a
  /// flat, repetitive list.
  Map<String, List<CitationRecord>> get citationsByTemplate {
    final grouped = <String, List<CitationRecord>>{};
    for (final citation in _citations) {
      grouped.putIfAbsent(citation.templateId, () => []).add(citation);
    }
    return grouped;
  }

  Future<void> loadCitations() async {
    _isLoadingCitations = true;
    _citationsError = null;
    notifyListeners();
    try {
      _citations = await _citationRepository.fetchAll();
    } catch (e) {
      _citationsError = 'Could not load the citation chain. Check your connection.';
    }
    _isLoadingCitations = false;
    notifyListeners();
  }

  Future<void> loadKnowledgeGraphFor(String projectId) async {
    _isLoadingGraph = true;
    notifyListeners();

    final allRfcs = await _rfcRepository.loadAll();
    final allExperiments = await _experimentRepository.loadAll();

    _projectRfcs = allRfcs.where((r) => r.projectId == projectId).toList();
    _projectExperiments = allExperiments.where((e) => e.projectId == projectId).toList();
    _projectNotebook = await _notebookRepository.load(projectId);

    _isLoadingGraph = false;
    notifyListeners();
  }
}

// ============================================================
// SCREENS
// ============================================================

/// Institute-wide view: which shared templates became the seed for the
/// most derivative work — literal, traceable "legacy" rather than a
/// figure of speech.
class CitationChainScreen extends StatefulWidget {
  const CitationChainScreen({super.key});

  @override
  State<CitationChainScreen> createState() => _CitationChainScreenState();
}

class _CitationChainScreenState extends State<CitationChainScreen> {
  late final LegacyController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LegacyController();
    _controller.loadCitations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Citation Chain')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoadingCitations) return const Center(child: CircularProgressIndicator());
          if (_controller.citationsError != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text(_controller.citationsError!), TextButton(onPressed: _controller.loadCitations, child: const Text('Retry'))],
              ),
            );
          }

          final grouped = _controller.citationsByTemplate;
          if (grouped.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('No citations yet — when someone reuses a shared Community Template, it will appear here.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              ),
            );
          }

          final entries = grouped.entries.toList()..sort((a, b) => b.value.length.compareTo(a.value.length));

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final group = entries[index];
              final title = group.value.first.templateTitle;
              return Card(
                child: ExpansionTile(
                  title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Built on ${group.value.length} time${group.value.length == 1 ? '' : 's'}'),
                  children: group.value.map((citation) {
                    return ListTile(
                      dense: true,
                      leading: const Icon(Icons.arrow_forward, size: 16),
                      title: Text(citation.newProjectName),
                      subtitle: Text('${citation.createdAt.month}/${citation.createdAt.day}/${citation.createdAt.year}'),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// One project's Knowledge Graph: how its Research Notebook entries,
/// RFCs, and Experiments connect — a record of the actual thinking
/// behind the project, not just its final code.
class KnowledgeGraphScreen extends StatefulWidget {
  final ProjectModel project;

  const KnowledgeGraphScreen({super.key, required this.project});

  @override
  State<KnowledgeGraphScreen> createState() => _KnowledgeGraphScreenState();
}

class _KnowledgeGraphScreenState extends State<KnowledgeGraphScreen> {
  late final LegacyController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LegacyController();
    _controller.loadKnowledgeGraphFor(widget.project.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _nodeCard({required IconData icon, required Color color, required String title, required List<String> lines}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Icon(icon, color: color, size: 20), const SizedBox(width: 8), Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color))]),
            const SizedBox(height: 8),
            if (lines.isEmpty)
              Text('Nothing here yet', style: TextStyle(color: Colors.grey.shade500, fontSize: 12))
            else
              ...lines.map((line) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Text('• $line', style: const TextStyle(fontSize: 13)))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isForked = widget.project.templateId?.startsWith('community_') ?? false;

    return Scaffold(
      appBar: AppBar(title: Text('Knowledge Graph — ${widget.project.name}')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoadingGraph) return const Center(child: CircularProgressIndicator());

          final notebook = _controller.projectNotebook;
          final hypotheses = notebook?.entriesOfType(ResearchEntryType.hypothesis).length ?? 0;
          final conclusions = notebook?.entriesOfType(ResearchEntryType.conclusion).length ?? 0;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (isForked)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.deepOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [Icon(Icons.call_split, color: Colors.deepOrange, size: 18), SizedBox(width: 8), Expanded(child: Text('This project began as a fork of a shared Community Template.', style: TextStyle(fontSize: 12)))],
                  ),
                ),
              _nodeCard(
                icon: Icons.menu_book_outlined,
                color: Colors.purple,
                title: 'Research Notebook',
                lines: [
                  if (hypotheses > 0 || conclusions > 0) '$hypotheses hypothesis${hypotheses == 1 ? '' : 'es'}, $conclusions conclusion${conclusions == 1 ? '' : 's'}',
                ],
              ),
              _nodeCard(
                icon: Icons.description_outlined,
                color: Colors.blue,
                title: 'RFCs',
                lines: _controller.projectRfcs.map((r) => '${r.title} (${r.status.label})').toList(),
              ),
              _nodeCard(
                icon: Icons.science_outlined,
                color: Colors.teal,
                title: 'Experiments',
                lines: _controller.projectExperiments.map((e) => '${e.title} — ${e.results.length}/${e.variants.length} variants measured').toList(),
              ),
              _nodeCard(
                icon: Icons.public,
                color: Colors.green,
                title: 'Publication',
                lines: [if (widget.project.isPublished) 'Published — live since ${widget.project.publishedAt?.month}/${widget.project.publishedAt?.day}'],
              ),
            ],
          );
        },
      ),
    );
  }
}
