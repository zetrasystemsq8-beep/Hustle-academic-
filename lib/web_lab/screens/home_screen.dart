import 'package:flutter/material.dart';
import '../controllers/project_controller.dart';
import '../widgets/project_card.dart';
import 'project_explorer_screen.dart';
import 'templates_screen.dart';
import 'challenges_screen.dart';
import 'labs_hub_screen.dart';

/// The Web Lab entry point: a dashboard with quick actions (New Website,
/// Open Project, Learning Challenges, Labs) and a grid of recent
/// projects.
class HomeScreen extends StatefulWidget {
  final ProjectController projectController;

  const HomeScreen({super.key, required this.projectController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.projectController.loadRecentProjects();
  }

  Future<void> _createNewWebsite() async {
    final name = await _promptForName(context, title: 'New Website', hint: 'My Website');
    if (name == null || name.trim().isEmpty) return;
    await widget.projectController.createBlankProject(name.trim());
    if (!mounted) return;
    _openExplorer();
  }

  Future<String?> _promptForName(
    BuildContext context, {
    required String title,
    required String hint,
  }) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: hint),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _openExplorer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectExplorerScreen(projectController: widget.projectController),
      ),
    );
  }

  void _openTemplates() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TemplatesScreen(projectController: widget.projectController),
      ),
    );
  }

  void _openChallenges() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengesScreen(projectController: widget.projectController),
      ),
    );
  }

  void _openLabs() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LabsHubScreen(projectController: widget.projectController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Web Lab')),
      body: AnimatedBuilder(
        animation: widget.projectController,
        builder: (context, _) {
          final recents = widget.projectController.recentProjects;
          return RefreshIndicator(
            onRefresh: widget.projectController.loadRecentProjects,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Welcome back', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text(
                  'Build a website by writing every line yourself.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 20),
                _buildQuickActions(),
                const SizedBox(height: 28),
                Text('Recent Projects', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                if (recents.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'No projects yet — create your first website above.',
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recents.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.15,
                    ),
                    itemBuilder: (context, index) {
                      final summary = recents[index];
                      return ProjectCard(
                        summary: summary,
                        onOpen: () async {
                          await widget.projectController.openProject(summary.id);
                          if (!mounted) return;
                          _openExplorer();
                        },
                        onRename: () async {
                          final newName = await _promptForName(context, title: 'Rename Project', hint: summary.name);
                          if (newName == null || newName.trim().isEmpty) return;
                          await widget.projectController.renameCurrentProject(newName.trim());
                        },
                        onDuplicate: () => widget.projectController.duplicateProject(summary.id),
                        onDelete: () => widget.projectController.deleteProject(summary.id),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActions() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _QuickActionButton(icon: Icons.add_circle_outline, label: 'New Website', onTap: _createNewWebsite),
        _QuickActionButton(icon: Icons.folder_open_outlined, label: 'Open Project', onTap: _openExplorer),
        _QuickActionButton(icon: Icons.widgets_outlined, label: 'Templates', onTap: _openTemplates),
        _QuickActionButton(icon: Icons.emoji_events_outlined, label: 'Challenges', onTap: _openChallenges),
        _QuickActionButton(icon: Icons.science_outlined, label: 'Labs', onTap: _openLabs),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 150,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, color: theme.colorScheme.onSecondaryContainer),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.colorScheme.onSecondaryContainer, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
