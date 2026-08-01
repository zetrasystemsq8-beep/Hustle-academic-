import 'validation_models.dart';

/// Checks a student's JavaScript for common mistakes, and their combined
/// HTML/CSS for basic accessibility issues. Same philosophy as the
/// HTML/CSS validator: plain string and regex checks, plain-language
/// messages, no external linting library required.
class JsAccessibilityValidator {
  List<ValidationIssue> validateJs(String js) {
    final issues = <ValidationIssue>[];
    if (js.trim().isEmpty) {
      issues.add(const ValidationIssue(severity: ValidationSeverity.info, message: 'This file is empty.'));
      return issues;
    }

    _checkUnbalancedBrackets(js, issues);
    _checkConsoleLogLeftIn(js, issues);
    _checkVarUsage(js, issues);
    _checkMissingSemicolons(js, issues);

    return issues;
  }

  List<ValidationIssue> checkAccessibility(String html) {
    final issues = <ValidationIssue>[];
    if (html.trim().isEmpty) return issues;

    _checkHeadingOrder(html, issues);
    _checkFormLabels(html, issues);
    _checkLinkText(html, issues);
    _checkLangAttribute(html, issues);

    return issues;
  }

  void _checkUnbalancedBrackets(String js, List<ValidationIssue> issues) {
    const pairs = {'(': ')', '[': ']', '{': '}'};
    final stack = <String>[];
    var inString = false;
    String? stringChar;

    for (var i = 0; i < js.length; i++) {
      final char = js[i];

      if (inString) {
        if (char == stringChar && (i == 0 || js[i - 1] != '\\')) inString = false;
        continue;
      }

      if (char == '"' || char == "'" || char == '`') {
        inString = true;
        stringChar = char;
        continue;
      }

      if (pairs.containsKey(char)) {
        stack.add(pairs[char]!);
      } else if (pairs.containsValue(char)) {
        if (stack.isEmpty || stack.removeLast() != char) {
          issues.add(ValidationIssue(
            severity: ValidationSeverity.error,
            message: 'Found an unexpected "$char" with no matching opening bracket.',
          ));
        }
      }
    }

    if (stack.isNotEmpty) {
      issues.add(ValidationIssue(
        severity: ValidationSeverity.error,
        message: 'Missing ${stack.length} closing bracket${stack.length == 1 ? '' : 's'} (expected: ${stack.join(' ')}).',
      ));
    }
  }

  void _checkConsoleLogLeftIn(String js, List<ValidationIssue> issues) {
    final count = RegExp(r'console\.log\s*\(').allMatches(js).length;
    if (count > 3) {
      issues.add(ValidationIssue(
        severity: ValidationSeverity.info,
        message: 'You have $count console.log() calls — useful for debugging, but consider removing extra ones once your code works.',
      ));
    }
  }

  void _checkVarUsage(String js, List<ValidationIssue> issues) {
    final count = RegExp(r'\bvar\s+').allMatches(js).length;
    if (count > 0) {
      issues.add(ValidationIssue(
        severity: ValidationSeverity.info,
        message: 'Found $count use${count == 1 ? '' : 's'} of "var" — modern JavaScript prefers "let" or "const", which avoid some tricky bugs "var" allows.',
      ));
    }
  }

  void _checkMissingSemicolons(String js, List<ValidationIssue> issues) {
    final lines = js.split('\n');
    var missingCount = 0;
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      if (trimmed.endsWith('{') || trimmed.endsWith('}') || trimmed.endsWith(',')) continue;
      if (trimmed.startsWith('//') || trimmed.startsWith('*') || trimmed.startsWith('/*')) continue;
      if (trimmed.startsWith('if') || trimmed.startsWith('else') || trimmed.startsWith('for') || trimmed.startsWith('while') || trimmed.startsWith('function')) continue;
      if (!trimmed.endsWith(';') && !trimmed.endsWith(')')) {
        missingCount++;
      }
    }
    if (missingCount > 2) {
      issues.add(ValidationIssue(
        severity: ValidationSeverity.info,
        message: 'Several lines may be missing a semicolon at the end — JavaScript often works without them, but adding them makes your intent clearer.',
      ));
    }
  }

  void _checkHeadingOrder(String html, List<ValidationIssue> issues) {
    final headingPattern = RegExp(r'<h([1-6])\b', caseSensitive: false);
    final levels = headingPattern.allMatches(html).map((m) => int.parse(m.group(1)!)).toList();
    if (levels.isEmpty) return;

    if (!levels.contains(1)) {
      issues.add(const ValidationIssue(
        severity: ValidationSeverity.warning,
        message: 'No <h1> found — every page should have exactly one main heading.',
      ));
    }

    for (var i = 1; i < levels.length; i++) {
      if (levels[i] - levels[i - 1] > 1) {
        issues.add(ValidationIssue(
          severity: ValidationSeverity.warning,
          message: 'Heading level jumps from h${levels[i - 1]} to h${levels[i]} — screen reader users rely on headings going in order.',
        ));
      }
    }
  }

  void _checkFormLabels(String html, List<ValidationIssue> issues) {
    final inputPattern = RegExp(r'<input\b([^>]*)>', caseSensitive: false);
    for (final match in inputPattern.allMatches(html)) {
      final attrs = match.group(1) ?? '';
      final typeMatch = RegExp(r'type\s*=\s*"([^"]*)"').firstMatch(attrs);
      final type = typeMatch?.group(1)?.toLowerCase() ?? 'text';
      if (type == 'hidden' || type == 'submit' || type == 'button') continue;

      final idMatch = RegExp(r'id\s*=\s*"([^"]*)"').firstMatch(attrs);
      final id = idMatch?.group(1);

      if (id == null || !RegExp('for\\s*=\\s*"$id"').hasMatch(html)) {
        issues.add(const ValidationIssue(
          severity: ValidationSeverity.warning,
          message: 'An <input> has no matching <label for="..."> — screen reader users won\'t know what it\'s for.',
        ));
      }
    }
  }

  void _checkLinkText(String html, List<ValidationIssue> issues) {
    final linkPattern = RegExp(r'<a\b[^>]*>(.*?)</a>', caseSensitive: false, dotAll: true);
    const vagueTexts = {'click here', 'here', 'read more', 'link', 'more'};
    for (final match in linkPattern.allMatches(html)) {
      final text = match.group(1)!.replaceAll(RegExp(r'<[^>]*>'), '').trim().toLowerCase();
      if (vagueTexts.contains(text)) {
        issues.add(ValidationIssue(
          severity: ValidationSeverity.info,
          message: 'A link just says "$text" — more descriptive link text helps screen reader users understand where it goes.',
        ));
      }
    }
  }

  void _checkLangAttribute(String html, List<ValidationIssue> issues) {
    if (RegExp(r'<html\b', caseSensitive: false).hasMatch(html) &&
        !RegExp(r'<html\b[^>]*\blang\s*=', caseSensitive: false).hasMatch(html)) {
      issues.add(const ValidationIssue(
        severity: ValidationSeverity.warning,
        message: 'The <html> tag is missing a lang attribute (e.g. lang="en") — this helps screen readers pronounce your content correctly.',
      ));
    }
  }
}
