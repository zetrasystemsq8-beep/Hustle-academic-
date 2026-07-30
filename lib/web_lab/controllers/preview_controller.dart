import 'package:flutter/foundation.dart';
import '../models/project_model.dart';

/// Drives the live Preview panel: assembling the student's HTML, CSS and
/// JS into a single renderable document, tracking orientation, and
/// triggering refresh/reload cycles.
class PreviewController extends ChangeNotifier {
  PreviewOrientation _orientation = PreviewOrientation.portrait;

  /// Incremented on every refresh to force the underlying WebView widget
  /// to rebuild/reload even when the source document string is unchanged
  /// (e.g. the student wants to re-run a script with side effects).
  int _reloadToken = 0;

  PreviewOrientation get orientation => _orientation;
  int get reloadToken => _reloadToken;

  /// Switches the preview between portrait and landscape. No desktop
  /// mode exists per the mobile-first requirement.
  void setOrientation(PreviewOrientation orientation) {
    if (_orientation == orientation) return;
    _orientation = orientation;
    notifyListeners();
  }

  /// Forces the preview to reload from the current project content.
  void refresh() {
    _reloadToken++;
    notifyListeners();
  }

  /// Builds a single self-contained HTML document combining the
  /// project's index.html, style.css, and script.js, suitable for
  /// loading directly into a WebView via `loadHtmlString`.
  ///
  /// A lightweight console bridge is injected so `console.log`,
  /// `console.warn`, and `console.error` calls, plus uncaught errors, can
  /// be forwarded out to the app's Console panel via a JS channel named
  /// `WebLabConsole` (wired up in [WebviewPreview]).
  String buildDocument(ProjectModel project) {
    final html = project.indexHtml?.content ?? '';
    final css = project.styleCss?.content ?? '';
    final js = project.scriptJs?.content ?? '';

    return '''
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
$css
</style>
</head>
<body>
$html
<script>
(function () {
  function forward(level, args) {
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

  console.log = function () { forward('log', arguments); originalLog.apply(console, arguments); };
  console.warn = function () { forward('warning', arguments); originalWarn.apply(console, arguments); };
  console.error = function () { forward('error', arguments); originalError.apply(console, arguments); };

  window.onerror = function (message, source, lineno) {
    forward('error', ['Error at line ' + lineno + ': ' + message]);
    return false;
  };
})();
</script>
<script>
$js
</script>
</body>
</html>
''';
  }
}
