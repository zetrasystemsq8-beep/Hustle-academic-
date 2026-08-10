import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models_and_state.dart';
import 'service.dart';
import 'screens.dart';

class VideoLabHomeScreen extends ConsumerStatefulWidget {
  const VideoLabHomeScreen({super.key});
  @override
  ConsumerState<VideoLabHomeScreen> createState() => _VideoLabHomeScreenState();
}

class _VideoLabHomeScreenState extends ConsumerState<VideoLabHomeScreen> {
  final _service = VideoLabService();
  List<VideoProject> _projects = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final projects = await _service.listProjects();
    if (mounted) {
      setState(() {
        _projects = projects;
        _loading = false;
      });
    }
  }

  Future<void> _openProject(VideoProject project) async {
    ref.read(videoLabProvider.notifier).setProject(project);
    final timeline = await _service.loadTimeline(project.id);
    ref.read(videoLabProvider.notifier).hydrate(
          clips: timeline.clips,
          overlays: timeline.overlays,
          transitions: timeline.transitions,
        );
    if (mounted) {
      await Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoEditorScreen()));
      _load();
    }
  }

  Future<void> _createProject() async {
    String title = '';
    String contentType = 'project_video';

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('New video project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (v) => title = v,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: contentType,
                decoration: const InputDecoration(labelText: 'Content type'),
                items: const [
                  DropdownMenuItem(value: 'project_video', child: Text('Project video')),
                  DropdownMenuItem(value: 'screenshot_trim', child: Text('Screenshot trim')),
                  DropdownMenuItem(value: 'explanation', child: Text('Explanation')),
                  DropdownMenuItem(value: 'new_theory', child: Text('New theory')),
                ],
                onChanged: (v) => setDialogState(() => contentType = v ?? contentType),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );

    if (created != true || title.trim().isEmpty) return;

    final project = await _service.createProject(title: title.trim(), contentType: contentType);
    await _openProject(project);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Lab')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createProject,
        icon: const Icon(Icons.add),
        label: const Text('New project'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _projects.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.movie_creation_outlined, size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      Text('No video projects yet', style: TextStyle(color: Colors.grey.shade600)),
                      const SizedBox(height: 4),
                      Text(
                        'Tap "New project" to get started',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                  itemCount: _projects.length,
                  itemBuilder: (context, i) {
                    final p = _projects[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const Icon(Icons.movie),
                        title: Text(p.title),
                        subtitle: Text('${p.contentType} · ${p.status}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _openProject(p),
                      ),
                    );
                  },
                ),
    );
  }
}
