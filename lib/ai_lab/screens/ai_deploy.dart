import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ai_dataset_lab.dart' show AiProject;
import 'ai_training_pipeline.dart' show AiTrainingJob, AiTrainingStatus, AiTrainingService;
import 'ai_collaborators.dart' show AiCollaboratorRepository, AiPermissions;

class AiDeployment {
  final String id;
  final String projectId;
  final String trainingJobId;
  final String modelArtifactPath;
  final String status;
  final DateTime createdAt;

  AiDeployment({
    required this.id,
    required this.projectId,
    required this.trainingJobId,
    required this.modelArtifactPath,
    required this.status,
    required this.createdAt,
  });

  factory AiDeployment.fromJson(Map<String, dynamic> json) => AiDeployment(
        id: json['id'] as String,
        projectId: json['project_id'] as String,
        trainingJobId: json['training_job_id'] as String,
        modelArtifactPath: json['model_artifact_path'] as String,
        status: json['status'] as String,
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      );
}

class AiDeployRepository {
  final SupabaseClient supabase;
  AiDeployRepository(this.supabase);

  Future<List<AiDeployment>> listDeployments(String projectId) async {
    final response = await supabase
        .from('ai_deployments')
        .select()
        .eq('project_id', projectId)
        .order('created_at', ascending: false);
    return (response as List).map((d) => AiDeployment.fromJson(d)).toList();
  }

  Future<AiDeployment> deploy({
    required String projectId,
    required AiTrainingJob job,
  }) async {
    await supabase.from('ai_deployments').update({'status': 'inactive'}).eq('project_id', projectId).eq('status', 'active');

    final id = '${DateTime.now().microsecondsSinceEpoch}_deploy';
    final row = {
      'id': id,
      'project_id': projectId,
      'training_job_id': job.id,
      'model_artifact_path': job.modelArtifactPath,
      'status': 'active',
    };
    await supabase.from('ai_deployments').insert(row);
    return AiDeployment.fromJson({...row, 'created_at': DateTime.now().toIso8601String()});
  }

  Future<void> undeploy(String id) async {
    await supabase.from('ai_deployments').update({'status': 'inactive'}).eq('id', id);
  }
}

class AiDeployScreen extends StatefulWidget {
  final AiProject project;
  const AiDeployScreen({super.key, required this.project});

  @override
  State<AiDeployScreen> createState() => _AiDeployScreenState();
}

class _AiDeployScreenState extends State<AiDeployScreen> {
  late final AiTrainingService _trainingService;
  late final AiDeployRepository _deployRepository;

  List<AiTrainingJob> _availableJobs = [];
  List<AiDeployment> _deployments = [];
  bool _isLoading = true;
  bool _isDeploying = false;
  AiPermissions? _permissions;

  @override
  void initState() {
    super.initState();
    _trainingService = AiTrainingService(Supabase.instance.client);
    _deployRepository = AiDeployRepository(Supabase.instance.client);
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
    final jobs = await _trainingService.listJobs(widget.project.id);
    final deployments = await _deployRepository.listDeployments(widget.project.id);
    if (!mounted) return;
    setState(() {
      _availableJobs = jobs.where((j) => j.status == AiTrainingStatus.complete && j.modelArtifactPath != null).toList();
      _deployments = deployments;
      _isLoading = false;
    });
  }

  AiDeployment? get _activeDeployment {
    try {
      return _deployments.firstWhere((d) => d.status == 'active');
    } catch (_) {
      return null;
    }
  }

  Future<void> _deployVersion(AiTrainingJob job) async {
    if (_permissions != null && !_permissions!.canDeploy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only the model owner can deploy a version.')),
      );
      return;
    }
    setState(() => _isDeploying = true);
    try {
      await _deployRepository.deploy(projectId: widget.project.id, job: job);
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deployed')));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Deploy failed: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeploying = false);
    }
  }

  Future<void> _undeploy(AiDeployment deployment) async {
    if (_permissions != null && !_permissions!.canDeploy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only the model owner can undeploy.')),
      );
      return;
    }
    await _deployRepository.undeploy(deployment.id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final active = _activeDeployment;
    final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
    final blocked = _permissions != null && !_permissions!.canDeploy;

    return Scaffold(
      appBar: AppBar(title: Text('Deploy — ${widget.project.name}')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  color: Colors.amber.shade50,
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'This is not an always-on server — Supabase and GitHub are the only infrastructure this app uses. '
                      'A deployed model gets a real, callable trigger, but each call runs a real job and takes '
                      'several seconds to respond (not instant), because it dispatches a real GitHub Actions run.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                if (blocked) ...[
                  const SizedBox(height: 8),
                  const Card(
                    color: Color(0xFFFFEBEE),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Only the model owner can deploy or undeploy versions.', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                if (active == null)
                  const Text('No active deployment.')
                else ...[
                  Text('Active Deployment', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Model: ${active.trainingJobId}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('Deployed: ${active.createdAt.toLocal().toString().split('.').first}'),
                          const SizedBox(height: 12),
                          const Text('Endpoint', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          SelectableText(
                            '$supabaseUrl/functions/v1/trigger-ai-inference',
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          const Text('Example request body', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            color: Colors.black,
                            child: SelectableText(
                              '{\n'
                              '  "inferJobId": "<generate a unique id>",\n'
                              '  "modelPath": "${active.modelArtifactPath}",\n'
                              '  "inputJson": { "feature1": 0 }\n'
                              '}',
                              style: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 11),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Requires the Supabase anon key as a Bearer token / apikey header, same as any Supabase Edge Function call. Poll the ai_inference_jobs table by inferJobId for the result — it is not returned synchronously.',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: blocked ? null : () => _undeploy(active),
                            child: const Text('Undeploy'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                Text('Deploy a Version', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                if (_availableJobs.isEmpty)
                  const Text('No completed training runs with a saved model yet.')
                else
                  ..._availableJobs.map(
                    (job) => Card(
                      child: ListTile(
                        title: Text(job.createdAt.toLocal().toString().split('.').first),
                        subtitle: Text('Accuracy: ${job.metrics?['accuracy'] ?? '—'}'),
                        trailing: _isDeploying
                            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                            : FilledButton(
                                onPressed: blocked ? null : () => _deployVersion(job),
                                child: const Text('Deploy'),
                              ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
