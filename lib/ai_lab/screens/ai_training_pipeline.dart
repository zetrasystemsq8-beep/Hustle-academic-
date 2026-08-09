import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_dataset_lab.dart' show AiProject, AiDataset, AiDatasetRepository;
import 'ai_python_workspace.dart' show AiWorkspace, AiWorkspaceFileNode, AiWorkspaceRepository, AiFileNodeType;

// ============================================================
// AI LAB — Training Pipeline
//
// Real: zips the workspace, uploads it, calls the Edge Function,
// which dispatches the GitHub Actions workflow above. That runner
// genuinely installs requirements.txt and executes train.py on
// CPU. Progress is polled from ai_training_jobs, which the
// workflow itself updates via the Supabase REST API mid-run.
// ============================================================

enum AiTrainingStatus { queued, running, complete, failed }

class AiTrainingJob {
  final String id;
  final String projectId;
  final String? datasetId;
  final String userId;
  final String entryScript;
  AiTrainingStatus status;
  String? logs;
  String? errorLogs;
  Map<String, dynamic>? metrics;
  String? modelArtifactPath;
  final DateTime createdAt;
  DateTime? startedAt;
  DateTime? completedAt;

  AiTrainingJob({
    required this.id,
    required this.projectId,
    this.datasetId,
    required this.userId,
    this.entryScript = 'src/train.py',
    this.status = AiTrainingStatus.queued,
    this.logs,
    this.errorLogs,
    this.metrics,
    this.modelArtifactPath,
    DateTime? createdAt,
    this.startedAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'project_id': projectId,
        'dataset_id': datasetId,
        'user_id': userId,
        'entry_script': entryScript,
        'status': status.name,
        'logs': logs,
        'error_logs': errorLogs,
        'metrics': metrics,
        'model_artifact_path': modelArtifactPath,
        'created_at': createdAt.toIso8601String(),
        'started_at': startedAt?.toIso8601String(),
        'completed_at': completedAt?.toIso8601String(),
      };

  factory AiTrainingJob.fromJson(Map<String, dynamic> json) => AiTrainingJob(
        id: json['id'] as String,
        projectId: json['project_id'] as String,
        datasetId: json['dataset_id'] as String?,
        userId: json['user_id'] as String,
        entryScript: json['entry_script'] as String? ?? 'src/train.py',
        status: AiTrainingStatus.values.byName(json['status'] as String? ?? 'queued'),
        logs: json['logs'] as String?,
        errorLogs: json['error_logs'] as String?,
        metrics: json['metrics'] as Map<String, dynamic>?,
        modelArtifactPath: json['model_artifact_path'] as String?,
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
        startedAt: json['started_at'] != null ? DateTime.tryParse(json['started_at'] as String) : null,
        completedAt: json['completed_at'] != null ? DateTime.tryParse(json['completed_at'] as String) : null,
      );
}

class AiTrainingService {
  final SupabaseClient supabase;
  AiTrainingService(this.supabase);

  static const String _workspaceBucket = 'ai-workspace-zips';

  /// Zips the workspace tree into a flat archive (same approach as
  /// MobileProjectZipper) so the GitHub Actions runner can unzip it
  /// directly into a working directory.
  List<int> _zipWorkspace(AiWorkspace workspace) {
    final archive = Archive();
    _addNode(archive, workspace.root, '');
    return ZipEncoder().encode(archive);
  }

  void _addNode(Archive archive, AiWorkspaceFileNode node, String prefix) {
    final path = prefix.isEmpty ? node.name : '$prefix/${node.name}';
    if (node.type == AiFileNodeType.file) {
      final bytes = Uint8List.fromList(utf8.encode(node.content));
      archive.addFile(ArchiveFile(path, bytes.length, bytes));
      return;
    }
    for (final child in node.children) {
      _addNode(archive, child, path);
    }
  }

  Future<AiTrainingJob> startTraining({
    required AiProject project,
    required AiWorkspace workspace,
    AiDataset? dataset,
    String entryScript = 'src/train.py',
  }) async {
    final jobId = '${DateTime.now().microsecondsSinceEpoch}_${project.userId}';
    final job = AiTrainingJob(
      id: jobId,
      projectId: project.id,
      datasetId: dataset?.id,
      userId: project.userId,
      entryScript: entryScript,
    );

    await supabase.from('ai_training_jobs').insert(job.toJson());

    final zipBytes = _zipWorkspace(workspace);
    final workspacePath = '${project.userId}/${project.id}/$jobId.zip';
    await supabase.storage.from(_workspaceBucket).uploadBinary(
          workspacePath,
          Uint8List.fromList(zipBytes),
        );

    try {
      await supabase.functions.invoke('trigger-ai-training', body: {
        'jobId': jobId,
        'workspacePath': workspacePath,
        'datasetPath': dataset?.storagePath ?? '',
        'entryScript': entryScript,
      });
    } catch (e) {
      await supabase.from('ai_training_jobs').update({
        'status': AiTrainingStatus.failed.name,
        'error_logs': 'Failed to dispatch training job: $e',
        'completed_at': DateTime.now().toIso8601String(),
      }).eq('id', jobId);
      rethrow;
    }

    return job;
  }

  /// Polls job status. The workflow itself writes progress via the
  /// Supabase REST API mid-run (see the "Mark job as running" and
  /// "Report completion" steps in ai-lab-train.yml), so polling this
  /// table reflects real runner state, not a local simulation.
  Stream<AiTrainingJob> watchJob(String jobId) async* {
    while (true) {
      final response = await supabase.from('ai_training_jobs').select().eq('id', jobId).maybeSingle();
      if (response == null) {
        await Future.delayed(const Duration(seconds: 3));
        continue;
      }
      final job = AiTrainingJob.fromJson(response);
      yield job;
      if (job.status == AiTrainingStatus.complete || job.status == AiTrainingStatus.failed) {
        return;
      }
      await Future.delayed(const Duration(seconds: 4));
    }
  }

  Future<List<AiTrainingJob>> listJobs(String projectId) async {
    final response = await supabase
        .from('ai_training_jobs')
        .select()
        .eq('project_id', projectId)
        .order('created_at', ascending: false);
    return (response as List).map((j) => AiTrainingJob.fromJson(j)).toList();
  }
}

// ============================================================
// SCREENS
// ============================================================

class AiTrainingLaunchScreen extends StatefulWidget {
  final AiProject project;
  final AiWorkspace workspace;
  const AiTrainingLaunchScreen({super.key, required this.project, required this.workspace});

  @override
  State<AiTrainingLaunchScreen> createState() => _AiTrainingLaunchScreenState();
}

class _AiTrainingLaunchScreenState extends State<AiTrainingLaunchScreen> {
  late final AiDatasetRepository _datasetRepository;
  late final AiTrainingService _trainingService;
  List<AiDataset> _datasets = [];
  AiDataset? _selectedDataset;
  String _entryScript = 'src/train.py';
  bool _isLoading = true;
  bool _isStarting = false;

  @override
  void initState() {
    super.initState();
    _datasetRepository = AiDatasetRepository(Supabase.instance.client);
    _trainingService = AiTrainingService(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    final datasets = await _datasetRepository.listDatasets(widget.project.id);
    if (!mounted) return;
    setState(() {
      _datasets = datasets;
      _selectedDataset = datasets.isNotEmpty ? datasets.first : null;
      _isLoading = false;
    });
  }

  Future<void> _startTraining() async {
    setState(() => _isStarting = true);
    try {
      final job = await _trainingService.startTraining(
        project: widget.project,
        workspace: widget.workspace,
        dataset: _selectedDataset,
        entryScript: _entryScript,
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AiTrainingProgressScreen(jobId: job.id, projectName: widget.project.name),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start training: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isStarting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Train Model')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (_datasets.isEmpty)
                  const Card(
                    color: Color(0xFFFFF3E0),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('No datasets found — upload one in Dataset Lab first, or train without a bound dataset if your script loads its own data.'),
                    ),
                  )
                else
                  DropdownButtonFormField<AiDataset>(
                    value: _selectedDataset,
                    decoration: const InputDecoration(labelText: 'Dataset'),
                    items: _datasets
                        .map((d) => DropdownMenuItem(value: d, child: Text('${d.name} (v${d.version})')))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedDataset = v),
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _entryScript,
                  decoration: const InputDecoration(labelText: 'Entry script (relative to project root)'),
                  onChanged: (v) => _entryScript = v,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _isStarting ? null : _startTraining,
                  icon: _isStarting
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.play_arrow),
                  label: Text(_isStarting ? 'Starting...' : 'Start Training'),
                ),
              ],
            ),
    );
  }
}

class AiTrainingProgressScreen extends StatefulWidget {
  final String jobId;
  final String projectName;
  const AiTrainingProgressScreen({super.key, required this.jobId, required this.projectName});

  @override
  State<AiTrainingProgressScreen> createState() => _AiTrainingProgressScreenState();
}

class _AiTrainingProgressScreenState extends State<AiTrainingProgressScreen> {
  late final AiTrainingService _service;

  @override
  void initState() {
    super.initState();
    _service = AiTrainingService(Supabase.instance.client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Training — ${widget.projectName}')),
      body: StreamBuilder<AiTrainingJob>(
        stream: _service.watchJob(widget.jobId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final job = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildStatusBadge(job.status),
              const SizedBox(height: 16),
              if (job.status == AiTrainingStatus.complete && job.metrics != null) ...[
                Text('Metrics', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...job.metrics!.entries.map(
                  (e) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(e.key),
                    trailing: Text('${e.value}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const Divider(),
              ],
              if (job.modelArtifactPath != null) ...[
                ListTile(
                  leading: const Icon(Icons.model_training),
                  title: const Text('Model artifact'),
                  subtitle: Text(job.modelArtifactPath!),
                ),
                const Divider(),
              ],
              Text('Logs', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.black,
                child: Text(
                  job.logs ?? job.errorLogs ?? 'Waiting for logs...',
                  style: TextStyle(
                    color: job.status == AiTrainingStatus.failed ? Colors.red[300] : Colors.green[400],
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusBadge(AiTrainingStatus status) {
    Color color;
    String label;
    switch (status) {
      case AiTrainingStatus.complete:
        color = Colors.green;
        label = 'Complete';
        break;
      case AiTrainingStatus.failed:
        color = Colors.red;
        label = 'Failed';
        break;
      case AiTrainingStatus.running:
        color = Colors.orange;
        label = 'Running';
        break;
      case AiTrainingStatus.queued:
        color = Colors.grey;
        label = 'Queued';
        break;
    }
    return Row(
      children: [
        if (status == AiTrainingStatus.running || status == AiTrainingStatus.queued)
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
