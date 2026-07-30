import 'package:flutter/material.dart';
import '../controllers/project_controller.dart';
import '../project_templates/template_registry.dart';
import 'project_explorer_screen.dart';

/// Displays locked, advanced-user-only templates. Beginners are steered
/// toward "New Website" instead; unlocking here is a deliberate,
/// explicit choice rather than a default path.
class TemplatesScreen extends StatefulWidget {
  final ProjectController projectController;

  const TemplatesScreen({super.key, required this.projectController});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  bool _unlocked = false;

  Future<void> _confirmUnlock() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unlock Templates?'),
        content: const Text(
          'Templates are meant for advanced learners as a reference. '
          'Beginners learn best by building from a blank file. Continue anyway?',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Unlock')),
        ],
      ),
    );
    if (confirmed == true) setState(() => _unlocked = true);
  }

  Future<void> _useTemplate(WebLabTemplate template) async {
    await widget.projectController.createFromTemplate(
      name: template.title,
      templateId: template.id,
      starterFiles: template.files,
    );
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectExplorerScreen(projectController: widget.projectController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Templates')),
      body: !_unlocked
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_outline, size: 48),
                    const SizedBox(height: 12),
                    const Text(
                      'Templates are locked for beginners.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'They\'re optional references for advanced users only.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    FilledButton(onPressed: _confirmUnlock, child: const Text('Unlock Anyway')),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: TemplateRegistry.all.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final template = TemplateRegistry.all[index];
                return Card(
                  child: ListTile(
                    title: Text(template.title),
                    subtitle: Text(template.description),
                    trailing: FilledButton.tonal(
                      onPressed: () => _useTemplate(template),
                      child: const Text('Use'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
