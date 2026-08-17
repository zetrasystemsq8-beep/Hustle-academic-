import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_dataset_lab.dart' show AiProject;
import 'ai_deploy.dart' show AiDeployRepository, AiDeployment;

// ============================================================
// AI LAB — App Integration
//
// Honest scope: this records which Hustle Academy app (a Mobile
// Lab or Web Lab project) a deployed model is linked to, and shows
// the same real endpoint/payload Deploy already provides. It does
// NOT reach into Mobile Lab or Web Lab's code and wire the call for
// you automatically — that requires the app developer to actually
// call the endpoint from their own app code. This screen makes the
// link visible and documented, not automatic.
// ============================================================

class AiAppIntegration {
  final String id;
  final String projectId;
  final String appType; // 'mobile_lab' | 'web_lab'
  final String appProjectId;
  final String appProjectName;
  final String deploymentId;
  final DateTime createdAt;

  AiAppIntegration({
    required this.id,
    required this.projectId,
    required this.appType,
    required this.appProjectId,
    required this.appProjectName,
    required this.deploymentId,
    required this.createdAt,
  });

  factory AiAppIntegration.fromJson(Map<String, dynamic> json) => AiAppIntegration(
        id: json['id'] as String,
        projectId: json['project_id'] as String,
        appType: json['app_type'] as String,
        appProjectId: json['app_project_id'] as String,
        appProjectName: json['app_project_name'] as String,
        deploymentId: json['deployment_id'] as String,
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      );
}

class AiAppIntegrationRepository {
  final SupabaseClient supabase;
  AiAppIntegrationRepository(this.supabase);

  Future<List<AiAppIntegration>> list(String projectId) async {
    final response = await supabase
        .from('ai_app_integrations')
        .select()
        .eq('project_id', projectId)
        .order('created_at', ascending: false);
    return (response as List).map((i) => AiAppIntegration.fromJson(i)).toList();
  }

  Future<void> link({
    required String projectId,
    required String appType,
    required String appProjectId,
    required String appProjectName,
    required String deploymentId,
    required String linkedBy,
  }) async {
    await supabase.from('ai_app_integrations').insert({
      'id': '${DateTime.now().microsecondsSinceEpoch}_link',
      'project_id': projectId,
      'app_type': appType,
      'app_project_id': appProjectId,
      'app_project_name': appProjectName,
      'deployment_id': deploymentId,
      'linked_by': linkedBy,
    });
  }

  Future<void> unlink(String id) async {
    await supabase.from('ai_app_integrations').delete().eq('id', id);
  }
}

class AiAppIntegrationScreen extends StatefulWidget {
  final AiProject project;
  const AiAppIntegrationScreen({super.key, required this.project});

  @override
  State<AiAppIntegrationScreen> createState() => _AiAppIntegrationScreenState();
}

class _AiAppIntegrationScreenState extends State<AiAppIntegrationScreen> {
  late final AiAppIntegrationRepository _integrationRepository;
  late final AiDeployRepository _deployRepository;
  List<AiAppIntegration> _integrations = [];
  AiDeployment? _activeDeployment;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _integrationRepository = AiAppIntegrationRepository(Supabase.instance.client);
    _deployRepository = AiDeployRepository(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    final integrations = await _integrationRepository.list(widget.project.id);
    final deployments = await _deployRepository.listDeployments(widget.project.id);
    AiDeployment? active;
    try {
      active = deployments.firstWhere((d) => d.status == 'active');
    } catch (_) {
      active = null;
    }
    if (!mounted) return;
    setState(() {
      _integrations = integrations;
      _activeDeployment = active;
      _isLoading = false;
    });
  }

  Future<void> _showLinkDialog() async {
    if (_activeDeployment == null) return;
    String appType = 'mobile_lab';
    final nameController = TextEditingController();
    final idController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Link to App'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: appType,
                decoration: const InputDecoration(labelText: 'App type'),
                items: const [
                  DropdownMenuItem(value: 'mobile_lab', child: Text('Mobile Lab project')),
                  DropdownMenuItem(value: 'web_lab', child: Text('Web Lab project')),
                ],
                onChanged: (v) => setDialogState(() => appType = v ?? appType),
              ),
              const SizedBox(height: 12),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'App project name')),
              const SizedBox(height: 12),
              TextField(controller: idController, decoration: const InputDecoration(labelText: 'App project ID')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Link')),
          ],
        ),
      ),
    );

    if (result != true || nameController.text.trim().isEmpty || idController.text.trim().isEmpty) return;
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) return;

    await _integrationRepository.link(
      projectId: widget.project.id,
      appType: appType,
      appProjectId: idController.text.trim(),
      appProjectName: nameController.text.trim(),
      deploymentId: _activeDeployment!.id,
      linkedBy: currentUser.id,
    );
    await _load();
  }

  Future<void> _unlink(AiAppIntegration integration) async {
    await _integrationRepository.unlink(integration.id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Integration')),
      floatingActionButton: _activeDeployment != null
          ? FloatingActionButton.extended(
              onPressed: _showLinkDialog,
              icon: const Icon(Icons.link),
              label: const Text('Link App'),
            )
          : null,
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
                      'This records which app a deployed model is linked to and documents the endpoint. The app developer still needs to call it from their own app code — it is not wired automatically.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_activeDeployment == null)
                  const Text('No active deployment — deploy a model version first.')
                else if (_integrations.isEmpty)
                  const Text('Not linked to any app yet.')
                else
                  ..._integrations.map(
                    (i) => Card(
                      child: ListTile(
                        leading: Icon(i.appType == 'mobile_lab' ? Icons.smartphone : Icons.language),
                        title: Text(i.appProjectName),
                        subtitle: Text('${i.appType == 'mobile_lab' ? 'Mobile Lab' : 'Web Lab'} · linked ${i.createdAt.toLocal().toString().split('.').first}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.link_off),
                          onPressed: () => _unlink(i),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
