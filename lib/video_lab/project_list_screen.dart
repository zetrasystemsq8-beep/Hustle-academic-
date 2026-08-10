import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models_and_state.dart';
import 'service.dart';
import 'screens.dart';

const _kBg = Color(0xFF0F0F0F);
const _kAccent = Color(0xFFFF6B00);
const _kSurface = Color(0xFF1C1C1E);

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
          backgroundColor: _kSurface,
          title: const Text('New video project', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: _kAccent)),
                ),
                onChanged: (v) => title = v,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: contentType,
                dropdownColor: _kSurface,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Content type',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
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
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: _kAccent, foregroundColor: Colors.white),
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
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kBg,
        foregroundColor: Colors.white,
        title: const Text('Video Lab'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _kAccent,
        onPressed: _createProject,
        icon: const Icon(Icons.add),
        label: const Text('New project'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: _kAccent))
          : _projects.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.movie_creation_outlined, size: 56, color: Colors.white24),
                      const SizedBox(height: 12),
                      const Text('No video projects yet', style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 4),
                      const Text(
                        'Tap "New project" to get started',
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
                  itemCount: _projects.length,
                  itemBuilder: (context, i) {
                    final p = _projects[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: _kSurface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _kAccent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.movie, color: _kAccent),
                        ),
                        title: Text(p.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('${p.contentType} · ${p.status}', style: const TextStyle(color: Colors.white54)),
                        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
                        onTap: () => _openProject(p),
                      ),
                    );
                  },
                ),
    );
  }
}
