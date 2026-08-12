import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_dataset_lab.dart' show AiProject;
import 'ai_training_pipeline.dart' show AiTrainingJob, AiTrainingStatus, AiTrainingService;

// ============================================================
// AI LAB — Experiments
//
// Real: reads every ai_training_jobs row for the project — success
// AND failure — and lets you sort/compare them. No new table, no
// simulated data; this is literally your training history.
// ============================================================

enum AiExperimentSort { newest, oldest, accuracyDesc, accuracyAsc }

class AiExperimentsScreen extends StatefulWidget {
  final AiProject project;
  const AiExperimentsScreen({super.key, required this.project});

  @override
  State<AiExperimentsScreen> createState() => _AiExperimentsScreenState();
}

class _AiExperimentsScreenState extends State<AiExperimentsScreen> {
  late final AiTrainingService _service;
  List<AiTrainingJob> _jobs = [];
  bool _isLoading = true;
  AiExperimentSort _sort = AiExperimentSort.newest;
  final Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _service = AiTrainingService(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final jobs = await _service.listJobs(widget.project.id);
    if (!mounted) return;
    setState(() {
      _jobs = jobs;
      _isLoading = false;
    });
  }

  double? _accuracyOf(AiTrainingJob job) {
    final acc = job.metrics?['accuracy'];
    if (acc == null) return null;
    if (acc is num) return acc.toDouble();
    return double.tryParse(acc.toString());
  }

  List<AiTrainingJob> get _sortedJobs {
    final list = [..._jobs];
    switch (_sort) {
      case AiExperimentSort.newest:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case AiExperimentSort.oldest:
        list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case AiExperimentSort.accuracyDesc:
        list.sort((a, b) => (_accuracyOf(b) ?? -1).compareTo(_accuracyOf(a) ?? -1));
        break;
      case AiExperimentSort.accuracyAsc:
        list.sort((a, b) => (_accuracyOf(a) ?? -1).compareTo(_accuracyOf(b) ?? -1));
        break;
    }
    return list;
  }

  void _toggleSelected(String jobId) {
    setState(() {
      if (_selectedIds.contains(jobId)) {
        _selectedIds.remove(jobId);
      } else {
        _selectedIds.add(jobId);
      }
    });
  }

  void _openComparison() {
    final selected = _jobs.where((j) => _selectedIds.contains(j.id)).toList();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AiExperimentComparisonScreen(jobs: selected)),
    );
  }

  Color _statusColor(AiTrainingStatus status) {
    switch (status) {
      case AiTrainingStatus.complete:
        return Colors.green;
      case AiTrainingStatus.failed:
        return Colors.red;
      case AiTrainingStatus.running:
        return Colors.orange;
      case AiTrainingStatus.queued:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobs = _sortedJobs;

    return Scaffold(
      appBar: AppBar(
        title: Text('Experiments — ${widget.project.name}'),
        actions: [
          PopupMenuButton<AiExperimentSort>(
            icon: const Icon(Icons.sort),
            onSelected: (v) => setState(() => _sort = v),
            itemBuilder: (context) => const [
              PopupMenuItem(value: AiExperimentSort.newest, child: Text('Newest first')),
              PopupMenuItem(value: AiExperimentSort.oldest, child: Text('Oldest first')),
              PopupMenuItem(value: AiExperimentSort.accuracyDesc, child: Text('Accuracy: high to low')),
              PopupMenuItem(value: AiExperimentSort.accuracyAsc, child: Text('Accuracy: low to high')),
            ],
          ),
        ],
      ),
      floatingActionButton: _selectedIds.length >= 2
          ? FloatingActionButton.extended(
              onPressed: _openComparison,
              icon: const Icon(Icons.compare_arrows),
              label: Text('Compare (${_selectedIds.length})'),
            )
          : null,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : jobs.isEmpty
              ? const Center(child: Text('No training runs yet.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: jobs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    final accuracy = _accuracyOf(job);
                    final isSelected = _selectedIds.contains(job.id);
                    return Card(
                      color: isSelected ? Colors.indigo.shade50 : null,
                      child: ListTile(
                        leading: Checkbox(
                          value: isSelected,
                          onChanged: (_) => _toggleSelected(job.id),
                        ),
                        title: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _statusColor(job.status).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                job.status.name,
                                style: TextStyle(color: _statusColor(job.status), fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(job.entryScript, overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                        subtitle: Text(
                          [
                            if (accuracy != null) 'Accuracy: ${accuracy.toStringAsFixed(4)}',
                            job.createdAt.toLocal().toString().split('.').first,
                          ].join(' · '),
                        ),
                        onTap: () => _toggleSelected(job.id),
                      ),
                    );
                  },
                ),
    );
  }
}

class AiExperimentComparisonScreen extends StatelessWidget {
  final List<AiTrainingJob> jobs;
  const AiExperimentComparisonScreen({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    // Union of every metric key across the selected jobs — comparison
    // works even if different runs logged different metrics.
    final metricKeys = <String>{};
    for (final job in jobs) {
      metricKeys.addAll(job.metrics?.keys ?? []);
    }
    final sortedKeys = metricKeys.toList()..sort();

    return Scaffold(
      appBar: AppBar(title: Text('Compare ${jobs.length} runs')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columns: [
              const DataColumn(label: Text('')),
              ...jobs.map((j) => DataColumn(label: Text(j.id.split('_').first))),
            ],
            rows: [
              DataRow(cells: [
                const DataCell(Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                ...jobs.map((j) => DataCell(Text(j.status.name))),
              ]),
              DataRow(cells: [
                const DataCell(Text('Entry script', style: TextStyle(fontWeight: FontWeight.bold))),
                ...jobs.map((j) => DataCell(Text(j.entryScript))),
              ]),
              DataRow(cells: [
                const DataCell(Text('Created', style: TextStyle(fontWeight: FontWeight.bold))),
                ...jobs.map((j) => DataCell(Text(j.createdAt.toLocal().toString().split('.').first))),
              ]),
              for (final key in sortedKeys)
                DataRow(cells: [
                  DataCell(Text(key, style: const TextStyle(fontWeight: FontWeight.bold))),
                  ...jobs.map((j) => DataCell(Text('${j.metrics?[key] ?? '—'}'))),
                ]),
            ],
          ),
        ),
      ),
    );
  }
}
