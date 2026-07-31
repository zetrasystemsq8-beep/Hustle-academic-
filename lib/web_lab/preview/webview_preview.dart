import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/console_controller.dart';
import '../controllers/preview_controller.dart';
import '../models/project_model.dart';

/// Renders a project's live HTML/CSS/JS output inside an in-app WebView.
///
/// Wires up a JavaScript channel named `WebLabConsole` so `console.log`,
/// `console.warn`, `console.error`, and uncaught runtime errors from the
/// student's script are forwarded to [ConsoleController] in real time.
///
/// Requires the `webview_flutter` package in pubspec.yaml:
/// `webview_flutter: ^4.7.0`
class WebviewPreview extends StatefulWidget {
  final ProjectModel project;
  final PreviewController previewController;
  final ConsoleController consoleController;

  /// When true, renders the classic device-frame styling (rounded
  /// border, drop shadow, fixed portrait/landscape sizing) used by the
  /// full-screen Preview screen. When false, fills all available space
  /// with no frame — used for the compact split-view inside the Code
  /// Editor and the DevTools Suite, where screen space is already tight.
  final bool showDeviceFrame;

  /// When true, the DOM/network/storage instrumentation script is
  /// injected into the loaded document, and any message it posts is
  /// forwarded to [onDevToolsMessage]. Only [DevToolsScreen] sets this.
  final bool enableDevTools;

  /// Called with each decoded message from the `WebLabDevTools` JS
  /// channel, when [enableDevTools] is true.
  final ValueChanged<Map<String, dynamic>>? onDevToolsMessage;

  /// Called once the underlying [WebViewController] is created, so a
  /// parent (like [DevToolsScreen]) can execute JS against the live page
  /// directly — e.g. to fetch computed styles for a selected element.
  final ValueChanged<WebViewController>? onControllerReady;

  const WebviewPreview({
    super.key,
    required this.project,
    required this.previewController,
    required this.consoleController,
    this.showDeviceFrame = true,
    this.enableDevTools = false,
    this.onDevToolsMessage,
    this.onControllerReady,
  });

  @override
  State<WebviewPreview> createState() => _WebviewPreviewState();
}

class _WebviewPreviewState extends State<WebviewPreview> {
  late final WebViewController _webViewController;
  int _lastReloadToken = -1;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..addJavaScriptChannel(
        'WebLabConsole',
        onMessageReceived: _handleConsoleMessage,
      );

    if (widget.enableDevTools) {
      _webViewController.addJavaScriptChannel(
        'WebLabDevTools',
        onMessageReceived: _handleDevToolsMessage,
      );
    }

    widget.previewController.addListener(_handlePreviewControllerChanged);
    widget.onControllerReady?.call(_webViewController);
    _loadDocument();
  }

  @override
  void dispose() {
    widget.previewController.removeListener(_handlePreviewControllerChanged);
    super.dispose();
  }

  void _handlePreviewControllerChanged() {
    if (widget.previewController.reloadToken != _lastReloadToken) {
      _loadDocument();
    }
  }

  void _handleConsoleMessage(JavaScriptMessage message) {
    try {
      final payload = jsonDecode(message.message) as Map<String, dynamic>;
      widget.consoleController.handleBridgeMessage(payload);
    } catch (_) {
      // Malformed bridge payloads are silently ignored rather than
      // crashing the preview session.
    }
  }

  void _handleDevToolsMessage(JavaScriptMessage message) {
    try {
      final payload = jsonDecode(message.message) as Map<String, dynamic>;
      widget.onDevToolsMessage?.call(payload);
    } catch (_) {
      // Malformed bridge payloads are silently ignored.
    }
  }

  void _loadDocument() {
    _lastReloadToken = widget.previewController.reloadToken;
    final document = widget.previewController.buildDocument(
      widget.project,
      includeDevToolsInstrumentation: widget.enableDevTools,
    );
    _webViewController.loadHtmlString(document);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showDeviceFrame) {
      return WebViewWidget(controller: _webViewController);
    }

    final orientation = widget.previewController.orientation;
    final isLandscape = orientation == PreviewOrientation.landscape;

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: isLandscape ? 640 : 360,
        height: isLandscape ? 360 : 640,
        constraints: const BoxConstraints(maxWidth: double.infinity, maxHeight: double.infinity),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black87, width: 8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }
}
