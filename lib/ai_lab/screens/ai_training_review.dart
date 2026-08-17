import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_dataset_lab.dart' show AiProject, AiDataset, AiDatasetRepository, AiDatasetStatsEngine;
import 'ai_collaborators.dart' show AiCollaboratorRepository, AiPermissions;

class AiTrainingSubmission {
  final String id;
  final String projectId;
  final String datasetId;
  final String submittedBy;
  final Map<String, String> rowData;
  final String status;
  final String? reviewedBy;
  final String? reviewNote;
  final DateTime createdAt;
  final DateTime? reviewedAt;

  AiTrainingSubmission({
    required this.id,
    required this.projectId,
    required this.datasetId,
    required this.submittedBy,
    required this.rowData,
    required this.status,
    this.reviewedBy,
    this.reviewNote,
    required this.createdAt,
    this.reviewedAt,
  });

  factory AiTrainingSubmission.fromJson(Map<String, dynamic> json) => AiTrainingSubmission(
        id: json['id'] as String,
        projectId: json['project_id'] as String,
        datasetId: json['dataset_id'] as String,
        submittedBy: json['submitted_by'] as String,
        rowData: Map<String, String>.from(json['row_data'] as Map),
        status: json['status'] as String,
        reviewedBy: json['reviewed_by'] as String?,
        reviewNote: json['review_note'] as String?,
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
        reviewedAt: json['reviewed_at'] != null ? DateTime.tryParse(json['reviewed_at'] as String) : null,
      );
}

class AiActivityLogEntry {
  final String id;
  final String projectId;
  final String actorId;
  final String action;
  final String? detail;
  final DateTime createdAt;

  AiActivityLogEntry({
    required this.id,
    required this.projectId,
    required this.actorId,
    required this.action,
    this.detail,
    required this.createdAt,
  });

  factory AiActivityLogEntry.fromJson(Map<String, dynamic> json) => AiActivityLogEntry(
        id: json['id'] as String,
        projectId: json['project_id'] as String,
        actorId: json['actor_id'] as String,
        action: json['action'] as String,
        detail: json['detail'] as String?,
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      );
}

class AiActivityLogger {
  final SupabaseClient supabase;
  AiActivityLogger(this.supabase);

  Future<void> log({
    required String projectId,
    required String actorId,
    required String action,
    String? detail,
  }) async {
    await supabase.from('ai_activity_log').insert({
      'id': '${DateTime.now().microsecondsSinceEpoch}_log',
      'project_id': projectId,
      'actor_id': actorId,
      'action': action,
      'detail': detail,
    });
  }

  Future<List<AiActivityLogEntry>> list(String projectId, {int limit = 50}) async {
    final response = await supabase
        .from('ai_activity_log')
        .select()
        .eq('project_id', projectId)
        .order('created_at', ascending: false)
        .limit(limit);
    return (response as List).map((e) => AiActivityLogEntry.fromJson(e)).toList();
  }
}

class AiTrainingReviewRepository {
  final SupabaseClient supabase;
  late final AiActivityLogger _logger;
  late final AiDatasetRepository _datasetRepository;
  AiTrainingReviewRepository(this.supabase) {
    _logger = AiActivityLogger(supabase);
    _datasetRepository = AiDatasetRepository(supabase);
  }

  Future<void> submit({
    required String projectId,
    required String datasetId,
    required String submittedBy,
    required Map<String, String> rowData,
  }) async {
    await supabase.from('ai_training_submissions').insert({
      'id': '${DateTime.now().microsecondsSinceEpoch}_sub',
      'project_id': projectId,
      'dataset_id': datasetId,
      'submitted_by': submittedBy,
      'row_data': rowData,
    });
    await _logger.log(projectId: projectId, actorId: submittedBy, action: 'submitted_training_data');
  }

  Future<List<AiTrainingSubmission>> listPending(String projectId) async {
    final response = await supabase
        .from('ai_training_submissions')
        .select()
        .eq('project_id', projectId)
        .eq('status', 'pending')
        .order('created_at', ascending: true);
    return (response as List).map((s) => AiTrainingSubmission.fromJson(s)).toList();
  }

  /// Approving actually appends the row to the real dataset and
  /// saves a new version — this is what makes it "become part of
  /// the model" per your spec, not just a status flip.
  Future<void> approve({
    required AiTrainingSubmission submission,
    required AiDataset dataset,
    required String reviewerId,
  }) async {
    dataset.rows.add(submission.rowData);
    dataset.missingValueCounts =
        AiDatasetStatsEngine.computeMissingValueCounts(dataset.columnNames, dataset.rows);
    dataset.classDistribution =
        AiDatasetStatsEngine.computeClassDistribution(dataset.rows, dataset.labelColumn);
    await _datasetRepository.saveNewVersion(dataset);

    await supabase.from('ai_training_submissions').update({
      'status': 'approved',
      'reviewed_by': reviewerId,
      'reviewed_at': DateTime.now().toIso8601String(),
    }).eq('id', submission.id);

    await _logger.log(
      projectId: submission.projectId,
      actorId: reviewerId,
      action: 'approved_training_data',
      detail: 'Dataset ${dataset.name} → v${dataset.version}',
    );
  }

  Future<void> reject({
    required AiTrainingSubmission submission,
    required String reviewerId,
    String? note,
  }) async {
    await supabase.from('ai_training_submissions').update({
      'status': 'rejected',
      'reviewed_by': reviewerId,
      'review_note': note,
      'reviewed_at': DateTime.now().toIso8601String(),
    }).eq('id', submission.id);

    await _logger.log(projectId: submission.projectId, actorId: reviewerId, action: 'rejected_training_data', detail: note);
  }
}

// ============================================================
// SCREENS
// ============================================================

class AiSubmitTrainingDataScreen extends StatefulWidget {
  final AiProject project;
  final AiDataset dataset;
  const AiSubmitTrainingDataScreen({super.key, required this.project, required this.dataset});

  @override
  State<AiSubmitTrainingDataScreen> createState() => _AiSubmitTrainingDataScreenState();
}

class _AiSubmitTrainingDataScreenState extends State<AiSubmitTrainingDataScreen> {
  late final Map<String, TextEditingController> _controllers;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controllers = {for (final c in widget.dataset.columnNames) c: TextEditingController()};
  }

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) return;

    setState(() => _isSubmitting = true);
    try {
      final rowData = {for (final e in _controllers.entries) e.key: e.value.text};
      await AiTrainingReviewRepository(Supabase.instance.client).submit(
        projectId: widget.project.id,
        datasetId: widget.dataset.id,
        submittedBy: currentUser.id,
        rowData: rowData,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted for review')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submit failed: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Training Example')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('This row is submitted for review — it will not appear in the dataset until an owner approves it.'),
          const SizedBox(height: 16),
          ...widget.dataset.columnNames.map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: _controllers[c],
                decoration: InputDecoration(labelText: c),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _isSubmitting ? null : _submit,
            icon: _isSubmitting
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.send),
            label: Text(_isSubmitting ? 'Submitting...' : 'Submit for Review'),
          ),
        ],
      ),
    );
  }
}

class AiReviewQueueScreen extends StatefulWidget {
  final AiProject project;
  const AiReviewQueueScreen({super.key, required this.project});

  @override
  State<AiReviewQueueScreen> createState() => _AiReviewQueueScreenState();
}

class _AiReviewQueueScreenState extends State<AiReviewQueueScreen> {
  late final AiTrainingReviewRepository _repository;
  late final AiDatasetRepository _datasetRepository;
  List<AiTrainingSubmission> _submissions = [];
  Map<String, AiDataset> _datasetsById = {};
  bool _isLoading = true;
  AiPermissions? _permissions;

  @override
  void initState() {
    super.initState();
    _repository = AiTrainingReviewRepository(Supabase.instance.client);
    _datasetRepository = AiDatasetRepository(Supabase.instance.client);
    _load();
    _resolvePermissions();
  }

  Future<void> _resolvePermissions() async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) return;
    final role = await AiCollaboratorRepository(Supabase.instance.client)
        .resolveRole(project: widget.project, currentUserId: currentUser.id);
    if (!mounted) return;
    setState(() => _permissions = AiPermissions(role));
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final submissions = await _repository.listPending(widget.project.id);
    final datasets = await _datasetRepository.listDatasets(widget.project.id);
    if (!mounted) return;
    setState(() {
      _submissions = submissions;
      _datasetsById = {for (final d in datasets) d.id: d};
      _isLoading = false;
    });
  }

  Future<void> _approve(AiTrainingSubmission submission) async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) return;
    final dataset = _datasetsById[submission.datasetId];
    if (dataset == null) return;

    try {
      // Fetch the full row set fresh so we don't overwrite concurrent edits.
      final rawText = await _datasetRepository.downloadRawText(dataset);
      final isJson = dataset.storagePath.toLowerCase().endsWith('.json');
      final freshDataset = dataset; // metadata already loaded; row hydration below
      await _repository.approve(submission: submission, dataset: freshDataset, reviewerId: currentUser.id);
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Approved and added to dataset')));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Approve failed: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _reject(AiTrainingSubmission submission) async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) return;
    await _repository.reject(submission: submission, reviewerId: currentUser.id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final canApprove = _permissions == null || _permissions!.canApproveTrainingData;

    return Scaffold(
      appBar: AppBar(title: const Text('Review Queue')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !canApprove
              ? const Center(child: Text('Only the model owner can review submissions.'))
              : _submissions.isEmpty
                  ? const Center(child: Text('No pending submissions.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _submissions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final s = _submissions[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dataset: ${_datasetsById[s.datasetId]?.name ?? s.datasetId}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                ...s.rowData.entries.map((e) => Text('${e.key}: ${e.value}')),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    FilledButton(onPressed: () => _approve(s), child: const Text('Approve')),
                                    const SizedBox(width: 8),
                                    OutlinedButton(onPressed: () => _reject(s), child: const Text('Reject')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}

class AiActivityLogScreen extends StatefulWidget {
  final AiProject project;
  const AiActivityLogScreen({super.key, required this.project});

  @override
  State<AiActivityLogScreen> createState() => _AiActivityLogScreenState();
}

class _AiActivityLogScreenState extends State<AiActivityLogScreen> {
  late final AiActivityLogger _logger;
  List<AiActivityLogEntry> _entries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _logger = AiActivityLogger(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    final entries = await _logger.list(widget.project.id);
    if (!mounted) return;
    setState(() {
      _entries = entries;
      _isLoading = false;
    });
  }

  String _actionLabel(String action) {
    return action.replaceAll('_', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training History')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _entries.isEmpty
              ? const Center(child: Text('No activity yet.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _entries.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final e = _entries[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(_actionLabel(e.action)),
                      subtitle: Text(
                        [
                          if (e.detail != null) e.detail!,
                          e.createdAt.toLocal().toString().split('.').first,
                        ].join(' · '),
                      ),
                    );
                  },
                ),
    );
  }
}
