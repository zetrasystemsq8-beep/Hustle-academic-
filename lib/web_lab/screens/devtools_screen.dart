import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/console_controller.dart';
import '../controllers/devtools_controller.dart';
import '../controllers/preview_controller.dart';
import '../models/project_model.dart';
import '../preview/webview_preview.dart';
import '../widgets/computed_styles_panel.dart';
import '../widgets/console_panel.dart';
import '../widgets/dom_tree_view.dart';
import '../widgets/network_monitor_panel.dart';
import '../widgets/storage_inspector_panel.dart';

/// The full DevTools Suite: a live preview instrumented with DOM,
/// Storage, and Network observation, paired with a tabbed inspector
/// panel — Elements, Styles, Console, Storage, Network — mirroring a
/// real browser's developer tools, built specifically for the student's
/// own running project.
class DevToolsScreen extends StatefulWidget {
  final ProjectModel project;

  const DevToolsScreen({super.key, required this.project});

  @override
  State<DevToolsScreen> createState() => _DevToolsScreenState();
}

class _DevToolsScreenState extends State<DevToolsScreen> with SingleTickerProviderStateMixin {
  late final PreviewController _previewController;
  late final ConsoleController _consoleController;
  late final DevToolsController _devToolsController;
  late final TabController _tabController;

  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _previewController = PreviewController();
    _consoleController = ConsoleController();
    _devToolsController = DevToolsController();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _previewController.dispose();
    _consoleController.dispose();
    _devToolsController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _handleNodeSelected(node) {
    final controller = _webViewController;
    if (controller == null) return;
    _devToolsController.selectNode(node.weblabId, controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DevTools — ${widget.project.name}'),
        actions: [
          IconButton(
            tooltip: 'Refresh preview',
            icon: const Icon(Icons.refresh),
            onPressed: _previewController.refresh,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade300,
              child: WebviewPreview(
                project: widget.project,
                previewController: _previewController,
                consoleController: _consoleController,
                showDeviceFrame: false,
                enableDevTools: true,
                onDevToolsMessage: _devToolsController.handleBridgeMessage,
                onControllerReady: (controller) => setState(() => _webViewController = controller),
              ),
            ),
          ),
          Container(height: 3, color: Colors.black),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Theme.of(context).colorScheme.primary,
                  tabs: const [
                    Tab(icon: Icon(Icons.account_tree_outlined, size: 18), text: 'Elements'),
                    Tab(icon: Icon(Icons.palette_outlined, size: 18), text: 'Styles'),
                    Tab(icon: Icon(Icons.terminal, size: 18), text: 'Console'),
                    Tab(icon: Icon(Icons.storage_outlined, size: 18), text: 'Storage'),
                    Tab(icon: Icon(Icons.swap_vert, size: 18), text: 'Network'),
                  ],
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _devToolsController,
                    builder: (context, _) {
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          DomTreeView(
                            root: _devToolsController.domTree,
                            selectedNodeId: _devToolsController.selectedNodeId,
                            onNodeSelected: _handleNodeSelected,
                          ),
                          ComputedStylesPanel(
                            selectedNode: _findSelectedNode(),
                            computedStyles: _devToolsController.computedStyles,
                          ),
                          ConsolePanel(consoleController: _consoleController),
                          StorageInspectorPanel(
                            snapshot: _devToolsController.storageSnapshot,
                            onRefresh: () {
                              final controller = _webViewController;
                              if (controller != null) _devToolsController.refreshStorage(controller);
                            },
                          ),
                          NetworkMonitorPanel(
                            requests: _devToolsController.networkRequests,
                            onClear: _devToolsController.clearNetworkLog,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Finds the currently selected node within the latest DOM snapshot,
  /// by id, so the Styles tab can show its tag/id/class header even
  /// though only the computed style values are cached separately.
  _findSelectedNode() {
    final root = _devToolsController.domTree;
    final id = _devToolsController.selectedNodeId;
    if (root == null || id == null) return null;

    dynamic search(node) {
      if (node.weblabId == id) return node;
      for (final child in node.children) {
        final found = search(child);
        if (found != null) return found;
      }
      return null;
    }

    return search(root);
  }
}
