import 'package:flutter/material.dart';
import '../controllers/console_controller.dart';
import '../controllers/preview_controller.dart';
import '../models/project_model.dart';
import '../preview/preview_toolbar.dart';
import '../preview/webview_preview.dart';
import '../widgets/console_panel.dart';

/// Combines the live [WebviewPreview], its [PreviewToolbar], and the
/// [ConsolePanel] into a single split-view screen so students can run
/// their code and see console output side by side.
class PreviewScreen extends StatelessWidget {
  final ProjectModel project;
  final PreviewController previewController;
  final ConsoleController consoleController;

  const PreviewScreen({
    super.key,
    required this.project,
    required this.previewController,
    required this.consoleController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preview — ${project.name}')),
      body: Column(
        children: [
          PreviewToolbar(previewController: previewController),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey.shade200,
              child: WebviewPreview(
                project: project,
                previewController: previewController,
                consoleController: consoleController,
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            flex: 2,
            child: ConsolePanel(consoleController: consoleController),
          ),
        ],
      ),
    );
  }
}
