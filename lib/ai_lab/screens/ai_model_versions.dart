import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_dataset_lab.dart' show AiProject;
import 'ai_training_pipeline.dart' show AiTrainingJob, AiTrainingStatus, AiTrainingService;

class AiModelVersionsScreen extends StatefulWidget {
  final AiProject project;
  const AiModelVersionsScreen({super.key, required this.project});

  @override
  State<AiModelVersionsScreen> createState() => _AiModelVersionsScreenState();
}

class _AiModelVersionsScreenState extends State<AiModelVersionsScreen> {
  late final AiTrainingService _service;
  List<AiTrainingJob> _jobs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _service = AiTrainingService(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    final jobs = await _service.listJobs(widget.project.id);
    // Only completed jobs with an artifact are real, usable versions.
    final versioned = jobs.where((j) => j.status == AiTrainingStatus.complete && j.modelArtifactPath != null).toList();
    if (!mounted) return;
    setState(() {
      _jobs = versioned;
      _isLoading = false;
    });
  }

  Future<String> _artifactUrl(String path) async {
    final client = Supabase.instance.client;
    final signed = await client.storage.from('ai-model-artifacts').createSignedUrl(path, 3600);
    return signed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Versions — ${widget.project.name}')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _jobs.isEmpty
              ? const Center(child: Text('No trained model versions yet. Run a successful training job first.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _jobs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    // Newest job = highest version number.
                    final versionNumber = _jobs.length - index;
                    final job = _jobs[index];
                    final accuracy = job.metrics?['accuracy'];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text('v$versionNumber')),
                        title: Text(job.entryScript),
                        subtitle: Text(
                          accuracy != null
                              ? 'Accuracy: ${(accuracy is num ? accuracy.toStringAsFixed(4) : accuracy)} · ${job.completedAt?.toLocal().toString().split('.').first ?? ''}'
                              : job.completedAt?.toLocal().toString().split('.').first ?? '',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.download_outlined),
                          onPressed: () async {
                            final url = await _artifactUrl(job.modelArtifactPath!);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Download link ready — check clipboard or open: $url')),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
