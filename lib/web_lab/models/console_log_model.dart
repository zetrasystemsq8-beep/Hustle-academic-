/// Severity level of a single Console entry, used to color and icon the
/// row in the Console panel UI.
enum ConsoleLogLevel {
  log,
  warning,
  error,
}

/// The originating language/source of a console message, so the Console
/// panel can label entries as coming from HTML, CSS or JavaScript.
enum ConsoleSource {
  javascript,
  html,
  css,
}

/// A single entry displayed in the Console panel: either a `console.log`
/// call from the student's script, or an error/warning surfaced while
/// parsing or running their HTML, CSS, or JavaScript.
class ConsoleLogEntry {
  final ConsoleLogLevel level;
  final ConsoleSource source;
  final String message;

  /// Optional line number within the source file where the issue occurred,
  /// null for plain `console.log` output with no associated position.
  final int? line;

  final DateTime timestamp;

  ConsoleLogEntry({
    required this.level,
    required this.source,
    required this.message,
    this.line,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Builds a plain informational log entry (equivalent to `console.log`).
  factory ConsoleLogEntry.log(String message, {ConsoleSource source = ConsoleSource.javascript}) {
    return ConsoleLogEntry(level: ConsoleLogLevel.log, source: source, message: message);
  }

  /// Builds an error entry, optionally tagged with the line it occurred on.
  factory ConsoleLogEntry.error(
    String message, {
    required ConsoleSource source,
    int? line,
  }) {
    return ConsoleLogEntry(
      level: ConsoleLogLevel.error,
      source: source,
      message: message,
      line: line,
    );
  }

  /// Builds a warning entry, optionally tagged with the line it occurred on.
  factory ConsoleLogEntry.warning(
    String message, {
    required ConsoleSource source,
    int? line,
  }) {
    return ConsoleLogEntry(
      level: ConsoleLogLevel.warning,
      source: source,
      message: message,
      line: line,
    );
  }
}
