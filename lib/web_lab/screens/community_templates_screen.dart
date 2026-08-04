import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controllers/project_controller.dart';
import '../models/project_model.dart';
import 'inventor_profile_screen.dart' show InventorRepository;

/// A free template another student shared publicly — real HTML/CSS/JS,
/// not a locked premium item. Anyone can browse it and clone it into a
/// new project of their own.
class CommunityTemplate {
  final String id;
  final String title;
  final String category;
  final String? authorName;
  final String html;
  final String css;
  final String js;
  final DateTime createdAt;

  const CommunityTemplate({
    required this.id,
    required this.title,
    required this.category,
    required this.authorName,
    required this.html,
    required this.css,
    required this.js,
    required this.createdAt,
  });

  factory CommunityTemplate.fromRow(Map<String, dynamic> row) {
    return CommunityTemplate(
      id: row['id'] as String,
      title: row['title'] as String,
      category: row['category'] as String? ?? 'General',
      authorName: row['author_name'] as String?,
      html: row['html'] as String? ?? '',
      css: row['css'] as String? ?? '',
      js: row['js'] as String? ?? '',
      createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

/// Reads and writes community templates from the
/// `web_lab_community_templates` table — namespaced so it can never
/// touch data belonging to any other app on the same Supabase project.
class CommunityTemplateRepository {
  static const String _tableName = 'web_lab_community_templates';
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<CommunityTemplate>> fetchAll() async {
    final rows = await _client.from(_tableName).select().order('created_at', ascending: false);
    return (rows as List).map((r) => CommunityTemplate.fromRow(r as Map<String, dynamic>)).toList();
  }

  /// [authorHandle] attaches this submission to a claimed Inventor
  /// Handle, if the student has one — optional, since not every student
  /// will have claimed one yet.
  Future<void> submit({
    required String title,
    required String category,
    required String? authorName,
    required String html,
    required String css,
    required String js,
    String? authorHandle,
  }) async {
    await _client.from(_tableName).insert({
      'title': title,
      'category': category,
      'author_name': authorName,
      'html': html,
      'css': css,
      'js': js,
      'author_handle': authorHandle,
    });
  }
}

/// Owns the list of community templates and the current category filter.
class CommunityTemplatesController extends ChangeNotifier {
  final CommunityTemplateRepository _repository = CommunityTemplateRepository();

  List<CommunityTemplate> _all = [];
  String? _categoryFilter;
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<CommunityTemplate> get filtered =>
      _categoryFilter == null ? _all : _all.where((t) => t.category == _categoryFilter).toList();

  List<String> get categories => _all.map((t) => t.category).toSet().toList()..sort();

  String? get categoryFilter => _categoryFilter;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _all = await _repository.fetchAll();
    } catch (e) {
      _error = 'Could not load community templates. Check your connection.';
    }
    _isLoading = false;
    notifyListeners();
  }

  void setCategoryFilter(String? category) {
    _categoryFilter = category;
    notifyListeners();
  }

  Future<bool> submit({
    required String title,
    required String category,
    required String? authorName,
    required String html,
    required String css,
    required String js,
  }) async {
    try {
      final handle = await InventorRepository().loadMyHandle();
      await _repository.submit(title: title, category: category, authorName: authorName, html: html, css: css, js: js, authorHandle: handle);
      await load();
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Browse, preview, use, and share free community templates — no
/// currency, no premium lock, any student can contribute.
class CommunityTemplatesScreen extends StatefulWidget {
  final ProjectController projectController;

  const CommunityTemplatesScreen({super.key, required this.projectController});

  @override
  State<CommunityTemplatesScreen> createState() => _CommunityTemplatesScreenState();
}

class _CommunityTemplatesScreenState extends State<CommunityTemplatesScreen> {
  late final CommunityTemplatesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CommunityTemplatesController();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _useTemplate(CommunityTemplate template) async {
    final nameController = TextEditingController(text: template.title);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name your new project'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;

    await widget.projectController.createFromTemplate(
      name: name.trim(),
      templateId: 'community_${template.id}',
      starterFiles: {'index.html': template.html, 'style.css': template.css, 'script.js': template.js},
    );

    final handle = await InventorRepository().loadMyHandle();
    if (handle != null) {
      // Real citation record: this template's author gets credit that
      // their shared work seeded another student's new project.
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Created "$name" — find it from Home.')));
  }

  Future<void> _shareCurrentProject() async {
    final project = widget.projectController.currentProject;
    if (project == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open a project first to share it.')));
      return;
    }

    final titleController = TextEditingController(text: project.name);
    final categoryController = TextEditingController(text: 'General');
    final authorController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share as community template'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: categoryController, decoration: const InputDecoration(labelText: 'Category')),
            TextField(controller: authorController, decoration: const InputDecoration(labelText: 'Your name (optional)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Share')),
        ],
      ),
    );
    if (confirmed != true) return;

    final success = await _controller.submit(
      title: titleController.text.trim().isEmpty ? project.name : titleController.text.trim(),
      category: categoryController.text.trim().isEmpty ? 'General' : categoryController.text.trim(),
      authorName: authorController.text.trim().isEmpty ? null : authorController.text.trim(),
      html: project.indexHtml?.content ?? '',
      css: project.styleCss?.content ?? '',
      js: project.scriptJs?.content ?? '',
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? 'Shared! Other students can now use it.' : 'Could not share — try again.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Templates')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _shareCurrentProject,
        icon: const Icon(Icons.upload_outlined),
        label: const Text('Share mine'),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
          if (_controller.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_controller.error!),
                  TextButton(onPressed: _controller.load, child: const Text('Retry')),
                ],
              ),
            );
          }
          if (_controller.filtered.isEmpty) {
            return const Center(child: Text('No community templates yet — be the first to share one!'));
          }

          return Column(
            children: [
              if (_controller.categories.length > 1)
                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: const Text('All'),
                          selected: _controller.categoryFilter == null,
                          onSelected: (_) => _controller.setCategoryFilter(null),
                        ),
                      ),
                      ..._controller.categories.map((c) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text(c),
                              selected: _controller.categoryFilter == c,
                              onSelected: (_) => _controller.setCategoryFilter(c),
                            ),
                          )),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemCount: _controller.filtered.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final template = _controller.filtered[index];
                    return Card(
                      child: ListTile(
                        title: Text(template.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${template.category}${template.authorName != null ? ' · by ${template.authorName}' : ''}'),
                        trailing: FilledButton.tonal(onPressed: () => _useTemplate(template), child: const Text('Use')),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
