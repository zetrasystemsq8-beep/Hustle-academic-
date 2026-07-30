import '../models/challenge_model.dart';
import '../models/project_model.dart';

/// Result of validating a student's project against a [ChallengeModel]'s
/// rules: whether it passed overall, plus which specific rules failed so
/// the UI can tell the learner exactly what to fix.
class ChallengeValidationResult {
  final bool passed;
  final List<String> failedDescriptions;

  const ChallengeValidationResult({
    required this.passed,
    required this.failedDescriptions,
  });
}

/// Checks whether a student's submitted project satisfies a challenge's
/// declarative [ChallengeRule]s.
///
/// Intentionally never has access to — or generates — a "correct answer".
/// It only inspects the student's own HTML/CSS/JS text for the presence
/// of required tags, properties, selectors, or function calls.
class ChallengeValidatorService {
  ChallengeValidationResult validate(
    ProjectModel project,
    ChallengeModel challenge,
  ) {
    final html = project.indexHtml?.content ?? '';
    final css = project.styleCss?.content ?? '';
    final js = project.scriptJs?.content ?? '';

    final failed = <String>[];

    for (final rule in challenge.rules) {
      final ok = _checkRule(rule, html: html, css: css, js: js);
      if (!ok) failed.add(rule.description);
    }

    return ChallengeValidationResult(
      passed: failed.isEmpty,
      failedDescriptions: failed,
    );
  }

  bool _checkRule(
    ChallengeRule rule, {
    required String html,
    required String css,
    required String js,
  }) {
    switch (rule.ruleType) {
      case 'has_tag':
        final tag = rule.params['tag'] as String? ?? '';
        return RegExp('<$tag[\\s>]', caseSensitive: false).hasMatch(html);

      case 'has_attribute':
        final attr = rule.params['attribute'] as String? ?? '';
        return RegExp('$attr\\s*=', caseSensitive: false).hasMatch(html);

      case 'has_text_content':
        final text = rule.params['text'] as String? ?? '';
        return html.toLowerCase().contains(text.toLowerCase());

      case 'has_css_selector':
        final selector = rule.params['selector'] as String? ?? '';
        return css.contains(selector);

      case 'has_css_property':
        final property = rule.params['property'] as String? ?? '';
        final value = rule.params['value'] as String?;
        final pattern = value == null
            ? RegExp('$property\\s*:')
            : RegExp('$property\\s*:\\s*$value');
        return pattern.hasMatch(css);

      case 'has_js_function_call':
        final fn = rule.params['function'] as String? ?? '';
        return RegExp('$fn\\s*\\(').hasMatch(js);

      case 'has_js_variable':
        final name = rule.params['name'] as String? ?? '';
        return RegExp(
          '(var|let|const)\\s+$name\\b',
        ).hasMatch(js);

      case 'min_length':
        final target = rule.params['target'] as String? ?? 'html';
        final min = rule.params['min'] as int? ?? 0;
        final source = target == 'css' ? css : (target == 'js' ? js : html);
        return source.trim().length >= min;

      default:
        // Unknown rule types fail closed rather than silently passing.
        return false;
    }
  }
}
