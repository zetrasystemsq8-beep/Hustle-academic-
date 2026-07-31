import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/project_controller.dart';
import '../controllers/svg_studio_controller.dart';
import '../services/file_system_service.dart';
import '../widgets/shape_properties_panel.dart';
import '../widgets/shape_toolbar.dart';
import '../widgets/svg_canvas_widget.dart';

/// SVG Studio: a visual canvas for building icons, logos, and simple
/// illustrations with real SVG shapes — rectangles, circles, lines,
/// text, and hand-typed paths — always backed by real, exportable SVG
/// markup rather than a proprietary format.
class SvgStudioScreen extends StatefulWidget {
  /// Optional — when provided, lets the student save the generated SVG
  /// directly into their currently open project as a new file. Without
  /// a project open, Copy is still fully available.
  final ProjectController? projectController;

  const SvgStudioScreen({super.key, this.projectController});

  @override
  State<SvgStudioScreen> createState() => _SvgStudioScreenState();
}

class _SvgStudioScreenState extends State<SvgStudioScreen> {
  late final SvgStudioController _controller;
  final FileSystemService _fileSystemService = FileSystemService();
  bool _showCode = false;

  @override
  void initState() {
    super.initState();
    _controller = SvgStudioController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _controller.generateSvgMarkup()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SVG copied to clipboard')));
  }

  Future<void> _saveToProject() async {
    final projectController = widget.projectController;
    final project = projectController?.currentProject;
    if (projectController == null || project == null) return;

    final nameController = TextEditingController(text: 'graphic.svg');
    final fileName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save as file'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Save')),
        ],
      ),
    );
    if (fileName == null || fileName.trim().isEmpty) return;

    try {
      final file = _fileSystemService.createFile(project.root, fileName.trim());
      file.content = _controller.generateSvgMarkup();
      projectController.notifyProjectChanged();
      await projectController.saveCurrentProject();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved as $fileName in ${project.name}')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasProject = widget.projectController?.currentProject != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SVG Studio'),
        actions: [
          IconButton(
            tooltip: _showCode ? 'Show canvas' : 'Show code',
            icon: Icon(_showCode ? Icons.brush_outlined : Icons.code),
            onPressed: () => setState(() => _showCode = !_showCode),
          ),
        ],
      ),
      body: Column(
        children: [
          ShapeToolbar(onAddShape: _controller.addShape),
          const Divider(height: 1),
          Expanded(
            child: _showCode ? _buildCodeView(hasProject) : _buildCanvasView(),
          ),
        ],
      ),
    );
  }

  Widget _buildCanvasView() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
              child: SvgCanvasWidget(controller: _controller),
            ),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 2,
          child: ShapePropertiesPanel(controller: _controller),
        ),
      ],
    );
  }

  Widget _buildCodeView(bool hasProject) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFF1E1E1E),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    _controller.generateSvgMarkup(),
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFD4D4D4)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy'),
                      onPressed: _copyCode,
                    ),
                  ),
                  if (hasProject) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.save_outlined),
                        label: const Text('Save to project'),
                        onPressed: _saveToProject,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
