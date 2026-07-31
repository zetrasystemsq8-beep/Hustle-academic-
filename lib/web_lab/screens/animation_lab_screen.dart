import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/animation_lab_controller.dart';
import '../controllers/project_controller.dart';
import '../widgets/animation_controls_panel.dart';
import '../widgets/animation_preview_widget.dart';
import '../widgets/keyframe_timeline.dart';

/// Animation Lab: build CSS `@keyframes` animations visually — set
/// timing, add keyframe stops, and adjust properties per stop — with a
/// live, accurate preview and the exact generated CSS ready to copy or
/// insert into the project's style.css.
class AnimationLabScreen extends StatefulWidget {
  /// Optional — when provided, lets the student insert the generated
  /// CSS directly into their currently open project's style.css.
  final ProjectController? projectController;

  const AnimationLabScreen({super.key, this.projectController});

  @override
  State<AnimationLabScreen> createState() => _AnimationLabScreenState();
}

class _AnimationLabScreenState extends State<AnimationLabScreen> {
  late final AnimationLabController _controller;
  bool _showCode = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationLabController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _controller.generateCss()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('CSS copied to clipboard')));
  }

  Future<void> _insertIntoStyleCss() async {
    final projectController = widget.projectController;
    final project = projectController?.currentProject;
    if (projectController == null || project == null) return;

    final styleFile = project.styleCss;
    if (styleFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This project has no style.css file to insert into.')),
      );
      return;
    }

    styleFile.content = '${styleFile.content}\n\n${_controller.generateCss()}';
    projectController.notifyProjectChanged();
    await projectController.saveCurrentProject();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to style.css')));
  }

  @override
  Widget build(BuildContext context) {
    final hasProject = widget.projectController?.currentProject != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Lab'),
        actions: [
          IconButton(
            tooltip: _showCode ? 'Show editor' : 'Show code',
            icon: Icon(_showCode ? Icons.tune : Icons.code),
            onPressed: () => setState(() => _showCode = !_showCode),
          ),
        ],
      ),
      body: _showCode ? _buildCodeView(hasProject) : _buildEditorView(),
    );
  }

  Widget _buildEditorView() {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Container(
            color: Colors.grey.shade100,
            child: AnimationPreviewWidget(controller: _controller),
          ),
        ),
        const Divider(height: 1),
        AnimationControlsPanel(controller: _controller),
        const Divider(height: 1),
        Expanded(child: KeyframeTimeline(controller: _controller)),
      ],
    );
  }

  Widget _buildCodeView(bool hasProject) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => Text(
                  _controller.generateCss(),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFD4D4D4)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(icon: const Icon(Icons.copy), label: const Text('Copy'), onPressed: _copyCode),
              ),
              if (hasProject) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Insert into style.css'),
                    onPressed: _insertIntoStyleCss,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
