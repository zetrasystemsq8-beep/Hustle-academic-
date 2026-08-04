import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/project_controller.dart';
import 'inventor_profile_screen.dart' show InventorRepository;

/// Lets a student publish their current project as a real, live website
/// with a shareable URL, backed by Supabase Storage. Supports
/// republishing (updates the same URL) and unpublishing. If the student
/// has claimed an Inventor Handle, the publish is attached to it so it
/// appears on their public profile automatically.
class PublishScreen extends StatefulWidget {
  final ProjectController projectController;

  const PublishScreen({super.key, required this.projectController});

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  bool _isBusy = false;
  String? _error;

  Future<void> _publish() async {
    setState(() {
      _isBusy = true;
      _error = null;
    });
    try {
      final handle = await InventorRepository().loadMyHandle();
      await widget.projectController.publishCurrentProject(authorHandle: handle);
    } catch (e) {
      setState(() => _error = 'Publishing failed. Check your connection and try again.');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _unpublish() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unpublish this site?'),
        content: const Text('The link will stop working immediately.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Unpublish'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _isBusy = true);
    try {
      await widget.projectController.unpublishCurrentProject();
    } catch (e) {
      setState(() => _error = 'Could not unpublish. Try again.');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  void _copyLink(String url) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied')));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.projectController,
      builder: (context, _) {
        final project = widget.projectController.currentProject;
        if (project == null) {
          return const Scaffold(body: Center(child: Text('No project open.')));
        }

        final publicUrl = widget.projectController.publicUrlForCurrentProject();
        final isPublished = publicUrl != null;
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(title: const Text('Publish')),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.name, style: theme.textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  isPublished
                      ? 'Your site is live. Publish again anytime to push your latest changes.'
                      : 'Publish your site to get a link anyone can open in a browser.',
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                if (isPublished) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            publicUrl,
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 18),
                          onPressed: () => _copyLink(publicUrl),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('Open'),
                          onPressed: () => launchUrl(Uri.parse(publicUrl), mode: LaunchMode.externalApplication),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          onPressed: () => Share.share(publicUrl),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
                if (_error != null) ...[
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                ],
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isBusy ? null : _publish,
                    child: _isBusy
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(isPublished ? 'Publish Update' : 'Publish'),
                  ),
                ),
                if (isPublished) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _isBusy ? null : _unpublish,
                      child: const Text('Unpublish'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
