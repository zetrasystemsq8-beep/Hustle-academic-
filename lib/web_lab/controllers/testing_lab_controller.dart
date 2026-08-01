import 'package:flutter/foundation.dart';
import '../models/project_model.dart';
import '../testing_lab/html_css_validator.dart';
import '../testing_lab/js_accessibility_validator.dart';
import '../testing_lab/validation_models.dart';

/// Full validation results for one project, grouped by check category so
/// the UI can show them in separate, labeled sections.
class TestingLabReport {
  final List<ValidationIssue> htmlIssues;
  final List<ValidationIssue> cssIssues;
  final List<ValidationIssue> jsIssues;
  final List<ValidationIssue> accessibilityIssues;

  const TestingLabReport({
    required this.htmlIssues,
    required this.cssIssues,
    required this.jsIssues,
    required this.accessibilityIssues,
  });

  int get errorCount => _countBySeverity(ValidationSeverity.error);
  int get warningCount => _countBySeverity(ValidationSeverity.warning);
  int get infoCount => _countBySeverity(ValidationSeverity.info);

  int _countBySeverity(ValidationSeverity severity) {
    final all = [...htmlIssues, ...cssIssues, ...jsIssues, ...accessibilityIssues];
    return all.where((i) => i.severity == severity).length;
  }

  bool get isClean => errorCount == 0 && warningCount == 0;
}

/// Runs every Testing Lab check against a project's current files.
/// Purely a coordinator — the actual rule logic lives in
/// [HtmlCssValidator] and [JsAccessibilityValidator].
class TestingLabController extends ChangeNotifier {
  final HtmlCssValidator _htmlCssValidator = HtmlCssValidator();
  final JsAccessibilityValidator _jsAccessibilityValidator = JsAccessibilityValidator();

  TestingLabReport? _lastReport;
  bool _isRunning = false;

  TestingLabReport? get lastReport => _lastReport;
  bool get isRunning => _isRunning;

  Future<TestingLabReport> runAllChecks(ProjectModel project) async {
    _isRunning = true;
    notifyListeners();

    final html = project.indexHtml?.content ?? '';
    final css = project.styleCss?.content ?? '';
    final js = project.scriptJs?.content ?? '';

    final report = TestingLabReport(
      htmlIssues: _htmlCssValidator.validateHtml(html),
      cssIssues: _htmlCssValidator.validateCss(css),
      jsIssues: _jsAccessibilityValidator.validateJs(js),
      accessibilityIssues: _jsAccessibilityValidator.checkAccessibility(html),
    );

    _lastReport = report;
    _isRunning = false;
    notifyListeners();
    return report;
  }

  void clearReport() {
    _lastReport = null;
    notifyListeners();
  }
}
