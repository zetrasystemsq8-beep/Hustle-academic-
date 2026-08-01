/// Severity of a single validation finding.
enum ValidationSeverity { error, warning, info }

/// One issue found while validating a student's HTML, CSS, or JS —
/// plain-language, pointing at what's wrong and why, never fixing it
/// for them.
class ValidationIssue {
  final ValidationSeverity severity;
  final String message;
  final int? line;

  const ValidationIssue({
    required this.severity,
    required this.message,
    this.line,
  });
}
