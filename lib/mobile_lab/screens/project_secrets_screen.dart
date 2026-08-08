import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'project_secrets_service.dart';

// ============================================================
// PROJECT SECRETS SCREEN — manage per-project API keys / env
// values. Reachable from the editor's AppBar (key icon).
// ============================================================

class ProjectSecretsScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  const ProjectSecretsScreen({
    required this.projectId,
    required this.projectName,
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectSecretsScreen> createState() => _ProjectSecretsScreenState();
}

class _ProjectSecretsScreenState extends State<ProjectSecretsScreen> {
  late final ProjectSecretsService _service;
  List<ProjectSecret> _secrets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _service = ProjectSecretsService(
      supabase: Supabase.instance.client,
      userId: Supabase.instance.client.auth.currentUser!.id,
    );
    _loadSecrets();
  }

  Future<void> _loadSecrets() async {
    setState(() => _isLoading = true);
    final secrets = await _service.listSecrets(widget.projectId);
    if (!mounted) return;
    setState(() {
      _secrets = secrets;
      _isLoading = false;
    });
  }

  Future<void> _addOrEditSecret({ProjectSecret? existing}) async {
    final keyController = TextEditingController(text: existing?.key ?? '');
    final valueController = TextEditingController(text: existing?.value ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existing == null ? 'Add Secret' : 'Edit Secret'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyController,
              enabled: existing == null,
              decoration: const InputDecoration(
                labelText: 'Key',
                hintText: 'e.g. NEWS_API_KEY',
              ),
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(
                labelText: 'Value',
                hintText: 'Paste your API key or value',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            Text(
              'Read it in your Dart code with:\nString.fromEnvironment(\'${keyController.text.isEmpty ? "KEY" : keyController.text}\')',
              style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'monospace'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );

    if (result != true) return;

    final key = keyController.text.trim().toUpperCase().replaceAll(RegExp(r'[^A-Z0-9_]'), '_');
    final value = valueController.text.trim();
    if (key.isEmpty || value.isEmpty) return;

    await _service.upsertSecret(projectId: widget.projectId, key: key, value: value);
    await _loadSecrets();
  }

  Future<void> _deleteSecret(ProjectSecret secret) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete "${secret.key}"?'),
        content: const Text('Any future builds will no longer have access to this value.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await _service.deleteSecret(secret.id);
    await _loadSecrets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secrets — ${widget.projectName}'),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addOrEditSecret(),
        icon: const Icon(Icons.add),
        label: const Text('Add Secret'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _secrets.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _secrets.length,
                  itemBuilder: (context, index) => _buildSecretCard(_secrets[index]),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.key_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('No secrets yet', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Add API keys here so your app can call real services. '
              'They get built into your APK — never bundled with your source code.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecretCard(ProjectSecret secret) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.vpn_key_outlined),
        title: Text(secret.key, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        subtitle: const Text('••••••••••••'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              onPressed: () => _addOrEditSecret(existing: secret),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
              onPressed: () => _deleteSecret(secret),
            ),
          ],
        ),
      ),
    );
  }
}
