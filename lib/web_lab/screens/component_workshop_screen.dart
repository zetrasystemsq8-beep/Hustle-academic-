import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/design_lab_controller.dart';
import '../controllers/project_controller.dart';
import '../design_lab/design_lab_models.dart';

/// Component Workshop: browse curated starter skeletons (button, card,
/// form, navbar, dashboard panel), edit their HTML/CSS, save your own
/// versions to a personal library that persists across every project,
/// and insert any saved component straight into the currently open
/// project.
class ComponentWorkshopScreen extends StatefulWidget {
  final ProjectController? projectController;

  const ComponentWorkshopScreen({super.key, this.projectController});

  @override
  State<ComponentWorkshopScreen> createState() => _ComponentWorkshopScreenState();
}

class _ComponentWorkshopScreenState extends State<ComponentWorkshopScreen> with SingleTickerProviderStateMixin {
  late final ComponentWorkshopController _controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = ComponentWorkshopController();
    _tabController = TabController(length: 3, vsync: this);
    _controller.loadLibrary();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _loadStarter(ComponentStarter starter) {
    _controller.loadIntoDraft(name: starter.name, category: starter.category, html: starter.html, css: starter.css);
    _tabController.animateTo(1);
  }

  void _loadSaved(SavedComponent component) {
    _controller.loadIntoDraft(name: component.name, category: component.category, html: component.html, css: component.css);
    _tabController.animateTo(1);
  }

  Future<void> _saveDraft() async {
    await _controller.saveDraftToLibrary();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to your library')));
    _tabController.animateTo(2);
  }

  void _copyDraft() {
    Clipboard.setData(ClipboardData(text: '<!-- HTML -->\n${_controller.draftHtml}\n\n/* CSS */\n${_controller.draftCss}'));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied')));
  }

  Future<void> _insertDraft() async {
    final projectController = widget.projectController;
    final project = projectController?.currentProject;
    if (projectController == null || project == null) return;

    final indexFile = project.indexHtml;
    final styleFile = project.styleCss;
    if (indexFile != null) indexFile.content = '${indexFile.content}\n\n${_controller.draftHtml}';
    if (styleFile != null) styleFile.content = '${styleFile.content}\n\n${_controller.draftCss}';

    projectController.notifyProjectChanged();
    await projectController.saveCurrentProject();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inserted into ${project.name}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Workshop'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Starters'), Tab(text: 'Editor'), Tab(text: 'My Library')],
        ),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return TabBarView(
            controller: _tabController,
            children: [_starterList(), _editor(), _library()],
          );
        },
      ),
    );
  }

  Widget _starterList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: ComponentStarterLibrary.all.map((starter) {
        return Card(
          child: ListTile(
            title: Text(starter.name),
            subtitle: Text(starter.category),
            trailing: FilledButton.tonal(onPressed: () => _loadStarter(starter), child: const Text('Edit')),
          ),
        );
      }).toList(),
    );
  }

  Widget _editor() {
    final hasProject = widget.projectController?.currentProject != null;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextFormField(
          initialValue: _controller.draftName,
          decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
          onChanged: (v) => _controller.updateDraft(name: v),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: _controller.draftCategory,
          decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
          onChanged: (v) => _controller.updateDraft(category: v),
        ),
        const SizedBox(height: 16),
        const Text('HTML', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: _controller.draftHtml,
          maxLines: 8,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (v) => _controller.updateDraft(html: v),
        ),
        const SizedBox(height: 16),
        const Text('CSS', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: _controller.draftCss,
          maxLines: 8,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (v) => _controller.updateDraft(css: v),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.copy), label: const Text('Copy'), onPressed: _copyDraft)),
            const SizedBox(width: 12),
            Expanded(child: FilledButton.icon(icon: const Icon(Icons.bookmark_add_outlined), label: const Text('Save'), onPressed: _saveDraft)),
          ],
        ),
        if (hasProject) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(icon: const Icon(Icons.add_box_outlined), label: const Text('Insert into open project'), onPressed: _insertDraft),
          ),
        ],
      ],
    );
  }

  Widget _library() {
    if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
    if (_controller.library.isEmpty) {
      return const Center(child: Text('No saved components yet.', style: TextStyle(color: Colors.grey)));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _controller.library.map((component) {
        return Card(
          child: ListTile(
            title: Text(component.name),
            subtitle: Text(component.category),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () => _loadSaved(component)),
                IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.deleteFromLibrary(component.id)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
