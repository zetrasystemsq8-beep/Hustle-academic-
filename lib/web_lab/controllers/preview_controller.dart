import 'package:flutter/foundation.dart';
import '../devtools/devtools_instrumentation.dart';
import '../models/project_model.dart';
import '../package_manager/cdn_package_registry.dart';

/// Drives the live Preview panel: assembling the student's HTML, CSS and
/// JS into a single renderable document, tracking orientation, and
/// triggering refresh/reload cycles.
class PreviewController extends ChangeNotifier {
  PreviewOrientation _orientation = PreviewOrientation.portrait;
  int _reloadToken = 0;

  PreviewOrientation get orientation => _orientation;
  int get reloadToken => _reloadToken;

  void setOrientation(PreviewOrientation orientation) {
    if (_orientation == orientation) return;
    _orientation = orientation;
    notifyListeners();
  }

  void refresh() {
    _reloadToken++;
    notifyListeners();
  }

  /// Builds a single self-contained HTML document combining the
  /// project's index.html, style.css, and script.js.
  ///
  /// Any CDN packages enabled for this project (via Package Manager) are
  /// injected into `<head>` automatically — the student's own HTML text
  /// never needs to reference them directly.
  ///
  /// When [includeDevToolsInstrumentation] is true, the heavier DOM /
  /// network / storage observation script is also injected, only ever
  /// used by the DevTools Suite screen.
  String buildDocument(ProjectModel project, {bool includeDevToolsInstrumentation = false}) {
    final html = project.indexHtml?.content ?? '';
    final css = project.styleCss?.content ?? '';
    final js = project.scriptJs?.content ?? '';
    final cdnTags = CdnPackageRegistry.tagsForEnabled(project.enabledCdnPackageIds);

    return '''
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
$cdnTags
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
${includeDevToolsInstrumentation ? '<script>${DevToolsInstrumentation.script}</script>' : ''}
<script>
$js
</script>
</body>
</html>
''';
  }
}
