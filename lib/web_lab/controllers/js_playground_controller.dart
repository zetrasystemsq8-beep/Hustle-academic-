import 'package:flutter/foundation.dart';

/// Owns the JS Playground's scratch code and the results of its most
/// recent run: forwarded console output (reused via the same bridge
/// pattern as the main Console), any globally-declared variables the
/// student's code created, and execution timing for benchmarking.
class JsPlaygroundController extends ChangeNotifier {
  String code = '// Write JavaScript here and tap Run\nlet total = 0;\nfor (let i = 1; i <= 10; i++) {\n  total += i;\n}\nconsole.log("Sum 1-10:", total);\n';

  Map<String, String> _lastVariables = {};
  double? _lastExecutionMs;
  int _runToken = 0;

  Map<String, String> get lastVariables => Map.unmodifiable(_lastVariables);
  double? get lastExecutionMs => _lastExecutionMs;
  int get runToken => _runToken;

  void updateCode(String value) {
    code = value;
    notifyListeners();
  }

  /// Triggers a run by incrementing a token the hosting WebView listens
  /// for, since reloading the same HTML string needs a forced signal to
  /// actually re-execute (mirrors how PreviewController.refresh works).
  void run() {
    _runToken++;
    notifyListeners();
  }

  void handleVariablesMessage(Map<String, dynamic> vars) {
    _lastVariables = vars.map((key, value) => MapEntry(key, value.toString()));
    notifyListeners();
  }

  void handleBenchmarkMessage(double ms) {
    _lastExecutionMs = ms;
    notifyListeners();
  }

  void clearResults() {
    _lastVariables = {};
    _lastExecutionMs = null;
    notifyListeners();
  }

  /// Builds the document loaded into the playground's hidden WebView:
  /// the same console-forwarding bridge used everywhere else, plus
  /// instrumentation specific to a scratch environment — timing the run
  /// and diffing global (`var`-declared) variables before/after so the
  /// student can see what their top-level code actually created.
  String buildPlaygroundDocument() {
    final escapedCode = code;

    return '''
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"></head>
<body>
<script>
(function () {
  function forwardConsole(level, args) {
    try {
      var message = Array.prototype.slice.call(args).map(function (a) {
        try { return typeof a === 'object' ? JSON.stringify(a) : String(a); }
        catch (e) { return String(a); }
      }).join(' ');
      if (window.WebLabConsole) {
        window.WebLabConsole.postMessage(JSON.stringify({ level: level, message: message }));
      }
    } catch (e) {}
  }

  var originalLog = console.log;
  var originalWarn = console.warn;
  var originalError = console.error;
  console.log = function () { forwardConsole('log', arguments); originalLog.apply(console, arguments); };
  console.warn = function () { forwardConsole('warning', arguments); originalWarn.apply(console, arguments); };
  console.error = function () { forwardConsole('error', arguments); originalError.apply(console, arguments); };

  var before = Object.keys(window);
  var start = performance.now();

  try {
$escapedCode
  } catch (e) {
    forwardConsole('error', [e.message]);
  }

  var elapsed = performance.now() - start;

  var after = Object.keys(window);
  var newKeys = after.filter(function (k) { return before.indexOf(k) === -1; });
  var snapshot = {};
  newKeys.forEach(function (k) {
    try {
      var val = window[k];
      if (typeof val === 'function') return;
      snapshot[k] = typeof val === 'object' ? JSON.stringify(val) : val;
    } catch (e) {}
  });

  if (window.WebLabPlayground) {
    window.WebLabPlayground.postMessage(JSON.stringify({ type: 'variables', vars: snapshot }));
    window.WebLabPlayground.postMessage(JSON.stringify({ type: 'benchmark', ms: elapsed }));
  }

  window.onerror = function (message, source, lineno) {
    forwardConsole('error', ['Error at line ' + lineno + ': ' + message]);
    return false;
  };
})();
</script>
</body>
</html>
''';
  }
}
