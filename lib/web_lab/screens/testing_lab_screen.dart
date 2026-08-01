import 'package:flutter/material.dart';
import '../controllers/testing_lab_controller.dart';
import '../models/project_model.dart';
import '../testing_lab/validation_models.dart';

/// Testing Lab: runs HTML, CSS, JS, and accessibility checks against the
/// currently open project and shows plain-language findings — never
/// fixes anything automatically, only points at what to look at.
class TestingLabScreen extends StatefulWidget {
  final ProjectModel project;

  const TestingLabScreen({super.key, required this.project});

  @override
  State<TestingLabScreen> createState() => _TestingLabScreenState();
}

class _TestingLabScreenState extends State<TestingLabScreen> {
  late final TestingLabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TestingLabController();
    _controller.runAllChecks(widget.project);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _colorFor(ValidationSeverity severity) {
    switch (severity) {
      case ValidationSeverity.error:
        return Colors.red;
      case ValidationSeverity.warning:
        return Colors.orange;
      case ValidationSeverity.info:
        return Colors.blue;
    }
  }

  IconData _iconFor(ValidationSeverity severity) {
    switch (severity) {
      case ValidationSeverity.error:
        return Icons.error_outline;
      case ValidationSeverity.warning:
        return Icons.warning_amber_outlined;
      case ValidationSeverity.info:
        return Icons.info_outline;
    }
  }

  Widget _section(String title, List<ValidationIssue> issues) {
    if (issues.isEmpty) {
      return ListTile(
        leading: const Icon(Icons.check_circle_outline, color: Colors.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('No issues found'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        ...issues.map((issue) => ListTile(
              dense: true,
              leading: Icon(_iconFor(issue.severity), color: _colorFor(issue.severity), size: 20),
              title: Text(issue.message, style: const TextStyle(fontSize: 13)),
              subtitle: issue.line != null ? Text('Line ${issue.line}') : null,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Lab'),
        actions: [
          IconButton(
            tooltip: 'Re-run checks',
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.runAllChecks(widget.project),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isRunning) return const Center(child: CircularProgressIndicator());

          final report = _controller.lastReport;
          if (report == null) return const SizedBox.shrink();

          return ListView(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: report.isClean ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                child: Row(
                  children: [
                    Icon(report.isClean ? Icons.check_circle : Icons.warning_amber, color: report.isClean ? Colors.green : Colors.orange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        report.isClean
                            ? 'No errors or warnings found.'
                            : '${report.errorCount} error${report.errorCount == 1 ? '' : 's'}, ${report.warningCount} warning${report.warningCount == 1 ? '' : 's'}, ${report.infoCount} suggestion${report.infoCount == 1 ? '' : 's'}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              _section('HTML', report.htmlIssues),
              const Divider(),
              _section('CSS', report.cssIssues),
              const Divider(),
              _section('JavaScript', report.jsIssues),
              const Divider(),
              _section('Accessibility', report.accessibilityIssues),
            ],
          );
        },
      ),
    );
  }
}
