import 'validation_models.dart';

/// Checks a student's HTML and CSS for common, teachable mistakes —
/// unclosed tags, missing alt text, empty rules — using plain string
/// and regex checks. This is not a full spec-compliant parser; it's
/// scoped to catch the mistakes beginners actually make, explained in
/// plain language rather than parser jargon.
class HtmlCssValidator {
  List<ValidationIssue> validateHtml(String html) {
    final issues = <ValidationIssue>[];
    if (html.trim().isEmpty) {
      issues.add(const ValidationIssue(severity: ValidationSeverity.info, message: 'This file is empty.'));
      return issues;
    }

    _checkUnclosedTags(html, issues);
    _checkMissingAltText(html, issues);
    _checkMissingDoctype(html, issues);
    _checkDuplicateIds(html, issues);

    return issues;
  }

  List<ValidationIssue> validateCss(String css) {
    final issues = <ValidationIssue>[];
    if (css.trim().isEmpty) {
      issues.add(const ValidationIssue(severity: ValidationSeverity.info, message: 'This file is empty.'));
      return issues;
    }

    _checkUnbalancedBraces(css, issues);
    _checkMissingSemicolons(css, issues);
    _checkEmptyRules(css, issues);

    return issues;
  }

  static const Set<String> _selfClosingTags = {
    'img', 'br', 'hr', 'input', 'meta', 'link', 'area', 'base', 'col', 'embed', 'source', 'track', 'wbr',
  };

  void _checkUnclosedTags(String html, List<ValidationIssue> issues) {
    final tagPattern = RegExp(r'<(/?)([a-zA-Z][a-zA-Z0-9]*)[^>]*?(/?)>');
    final stack = <String>[];
    var lineNumber = 1;
    var lastIndex = 0;

    for (final match in tagPattern.allMatches(html)) {
      lineNumber += '\n'.allMatches(html.substring(lastIndex, match.start)).length;
      lastIndex = match.start;

      final isClosing = match.group(1) == '/';
      final tagName = match.group(2)!.toLowerCase();
      final isSelfClosing = match.group(3) == '/' || _selfClosingTags.contains(tagName);

      if (isSelfClosing) continue;

      if (isClosing) {
        if (stack.isEmpty || stack.last != tagName) {
          issues.add(ValidationIssue(
            severity: ValidationSeverity.error,
            message: 'Found a closing </$tagName> tag with no matching opening tag.',
            line: lineNumber,
          ));
        } else {
          stack.removeLast();
        }
      } else {
        stack.add(tagName);
      }
    }

    for (final unclosed in stack) {
      issues.add(ValidationIssue(
        severity: ValidationSeverity.error,
        message: 'The <$unclosed> tag is never closed with </$unclosed>.',
      ));
    }
  }

  void _checkMissingAltText(String html, List<ValidationIssue> issues) {
    final imgPattern = RegExp(r'<img\b([^>]*)>', caseSensitive: false);
    for (final match in imgPattern.allMatches(html)) {
      final attrs = match.group(1) ?? '';
      if (!RegExp(r'alt\s*=').hasMatch(attrs)) {
        issues.add(const ValidationIssue(
          severity: ValidationSeverity.warning,
          message: 'An <img> tag is missing an alt attribute — add one so screen readers can describe it.',
        ));
      }
    }
  }

  void _checkMissingDoctype(String html, List<ValidationIssue> issues) {
    if (!RegExp(r'^\s*<!DOCTYPE\s+html>', caseSensitive: false).hasMatch(html)) {
      issues.add(const ValidationIssue(
        severity: ValidationSeverity.warning,
        message: 'This file is missing a <!DOCTYPE html> declaration at the top.',
      ));
    }
  }

  void _checkDuplicateIds(String html, List<ValidationIssue> issues) {
    final idPattern = RegExp(r'id\s*=\s*"([^"]*)"');
    final seen = <String>{};
    for (final match in idPattern.allMatches(html)) {
      final id = match.group(1)!;
      if (id.isEmpty) continue;
      if (seen.contains(id)) {
        issues.add(ValidationIssue(
          severity: ValidationSeverity.error,
          message: 'The id "$id" is used more than once. Each id must be unique on the page.',
        ));
      }
      seen.add(id);
    }
  }

  void _checkUnbalancedBraces(String css, List<ValidationIssue> issues) {
    final openCount = '{'.allMatches(css).length;
    final closeCount = '}'.allMatches(css).length;
    if (openCount != closeCount) {
      issues.add(ValidationIssue(
        severity: ValidationSeverity.error,
        message: 'Unbalanced braces: $openCount opening { vs $closeCount closing }.',
      ));
    }
  }

  void _checkMissingSemicolons(String css, List<ValidationIssue> issues) {
    final declarationPattern = RegExp(r'([a-zA-Z-]+)\s*:\s*([^;{}]+)([;}])');
    for (final match in declarationPattern.allMatches(css)) {
      if (match.group(3) == '}') {
        issues.add(ValidationIssue(
          severity: ValidationSeverity.warning,
          message: 'Missing semicolon after "${match.group(1)}: ${match.group(2)!.trim()}".',
        ));
      }
    }
  }

  void _checkEmptyRules(String css, List<ValidationIssue> issues) {
    final emptyRulePattern = RegExp(r'([^{}]+)\{\s*\}');
    for (final match in emptyRulePattern.allMatches(css)) {
      final selector = match.group(1)!.trim();
      if (selector.isNotEmpty) {
        issues.add(ValidationIssue(
          severity: ValidationSeverity.info,
          message: 'The rule "$selector" has no properties inside it — it does nothing yet.',
        ));
      }
    }
  }
}
