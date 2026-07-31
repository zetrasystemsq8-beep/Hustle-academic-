import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/console_controller.dart';
import '../controllers/js_playground_controller.dart';
import '../widgets/console_panel.dart';

/// JS Playground: a standalone JavaScript scratchpad — write, run,
/// inspect what variables your top-level code created, and see how long
/// it took to run. No project required; this is pure experimentation
/// space, separate from any single website project.
class JsPlaygroundScreen extends StatefulWidget {
  const JsPlaygroundScreen({super.key});

  @override
  State<JsPlaygroundScreen> createState() => _JsPlaygroundScreenState();
}

class _JsPlaygroundScreenState extends State<JsPlaygroundScreen> {
  late final JsPlaygroundController _playgroundController;
  late final ConsoleController _consoleController;
  late final WebViewController _webViewController;
  late final TextEditingController _codeController;

  int _lastRunToken = -1;

  @override
  void initState() {
    super.initState();
    _playgroundController = JsPlaygroundController();
    _consoleController = ConsoleController();
    _codeController = TextEditingController(text: _playgroundController.code);

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('WebLabConsole', onMessageReceived: _handleConsoleMessage)
      ..addJavaScriptChannel('WebLabPlayground', onMessageReceived: _handlePlaygroundMessage);

    _playgroundController.addListener(_handleRunTriggered);
  }

  @override
  void dispose() {
    _playgroundController.removeListener(_handleRunTriggered);
    _playgroundController.dispose();
    _consoleController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _handleRunTriggered() {
    if (_playgroundController.runToken != _lastRunToken) {
      _lastRunToken = _playgroundController.runToken;
      _consoleController.clear();
      _webViewController.loadHtmlString(_playgroundController.buildPlaygroundDocument());
    }
  }

  void _handleConsoleMessage(JavaScriptMessage message) {
    try {
      final payload = jsonDecode(message.message) as Map<String, dynamic>;
      _consoleController.handleBridgeMessage(payload);
    } catch (_) {}
  }

  void _handlePlaygroundMessage(JavaScriptMessage message) {
    try {
      final payload = jsonDecode(message.message) as Map<String, dynamic>;
      final type = payload['type'] as String?;
      if (type == 'variables') {
        _playgroundController.handleVariablesMessage(payload['vars'] as Map<String, dynamic>);
      } else if (type == 'benchmark') {
        _playgroundController.handleBenchmarkMessage((payload['ms'] as num).toDouble());
      }
    } catch (_) {}
  }

  void _run() {
    _playgroundController.updateCode(_codeController.text);
    _playgroundController.run();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JS Playground'),
        actions: [
          IconButton(tooltip: 'Run', icon: const Icon(Icons.play_arrow), onPressed: _run),
        ],
      ),
      body: Column(
        children: [
          // The hidden WebView actually executing the code — kept at a
          // minimal but nonzero size, since a fully zero-size WebView is
          // unreliable across platforms.
          SizedBox(
            width: 1,
            height: 1,
            child: WebViewWidget(controller: _webViewController),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: const Color(0xFF1E1E1E),
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _codeController,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 13, color: Color(0xFFD4D4D4)),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          const Divider(height: 1),
          AnimatedBuilder(
            animation: _playgroundController,
            builder: (context, _) {
              final ms = _playgroundController.lastExecutionMs;
              final vars = _playgroundController.lastVariables;
              if (ms == null && vars.isEmpty) return const SizedBox.shrink();

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (ms != null)
                      Text('Execution time: ${ms.toStringAsFixed(2)}ms', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    if (vars.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      const Text('Global variables:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ...vars.entries.map((e) => Text('  ${e.key} = ${e.value}', style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
                    ],
                  ],
                ),
              );
            },
          ),
          Expanded(
            flex: 2,
            child: ConsolePanel(consoleController: _consoleController),
          ),
        ],
      ),
    );
  }
}
