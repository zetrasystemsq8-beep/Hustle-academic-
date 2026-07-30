import 'package:flutter/foundation.dart';
import '../models/console_log_model.dart';

/// Holds the running list of Console entries produced while a project's
/// preview executes, and exposes filtering by level for the Console UI.
class ConsoleController extends ChangeNotifier {
  final List<ConsoleLogEntry> _entries = [];

  static const int _maxEntries = 500;

  List<ConsoleLogEntry> get entries => List.unmodifiable(_entries);

  List<ConsoleLogEntry> get errors =>
      _entries.where((e) => e.level == ConsoleLogLevel.error).toList();

  List<ConsoleLogEntry> get warnings =>
      _entries.where((e) => e.level == ConsoleLogLevel.warning).toList();

  int get errorCount => errors.length;
  int get warningCount => warnings.length;

  /// Appends a new entry, trimming the oldest entries once [_maxEntries]
  /// is exceeded so long-running sessions don't leak memory.
  void addEntry(ConsoleLogEntry entry) {
    _entries.add(entry);
    if (_entries.length > _maxEntries) {
      _entries.removeRange(0, _entries.length - _maxEntries);
    }
    notifyListeners();
  }

  /// Parses a raw JSON message forwarded from the preview's JS bridge
  /// (see [PreviewController.buildDocument]) and appends it as an entry.
  void handleBridgeMessage(Map<String, dynamic> payload) {
    final levelStr = payload['level'] as String? ?? 'log';
    final message = payload['message'] as String? ?? '';

    final level = switch (levelStr) {
      'error' => ConsoleLogLevel.error,
      'warning' => ConsoleLogLevel.warning,
      _ => ConsoleLogLevel.log,
    };

    addEntry(ConsoleLogEntry(
      level: level,
      source: ConsoleSource.javascript,
      message: message,
    ));
  }

  /// Records an HTML parsing/structure error surfaced independently of
  /// the JS bridge (e.g. from a lightweight static check before render).
  void reportHtmlError(String message, {int? line}) {
    addEntry(ConsoleLogEntry.error(message, source: ConsoleSource.html, line: line));
  }

  /// Records a CSS parsing error surfaced independently of the JS bridge.
  void reportCssError(String message, {int? line}) {
    addEntry(ConsoleLogEntry.error(message, source: ConsoleSource.css, line: line));
  }

  /// Clears all console output, e.g. when the student hits Refresh.
  void clear() {
    _entries.clear();
    notifyListeners();
  }
}
