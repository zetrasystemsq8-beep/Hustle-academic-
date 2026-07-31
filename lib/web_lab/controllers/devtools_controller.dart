import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../devtools/dom_models.dart';
import '../devtools/network_models.dart';
import '../devtools/storage_models.dart';

/// Owns all state for the DevTools Suite: the live DOM tree, the
/// currently selected element's computed styles, captured network
/// requests, and storage contents — all sourced from the instrumentation
/// script running inside the live preview's WebView.
class DevToolsController extends ChangeNotifier {
  DomNode? _domTree;
  String? _selectedNodeId;
  Map<String, String> _computedStyles = {};
  StorageSnapshot _storageSnapshot = const StorageSnapshot([]);
  final List<NetworkRequestEntry> _networkRequests = [];

  static const int _maxNetworkEntries = 200;

  DomNode? get domTree => _domTree;
  String? get selectedNodeId => _selectedNodeId;
  Map<String, String> get computedStyles => Map.unmodifiable(_computedStyles);
  StorageSnapshot get storageSnapshot => _storageSnapshot;
  List<NetworkRequestEntry> get networkRequests => List.unmodifiable(_networkRequests);

  /// Routes an incoming message from the `WebLabDevTools` JS channel to
  /// the right piece of state, based on its `type` field.
  void handleBridgeMessage(Map<String, dynamic> payload) {
    final type = payload['type'] as String?;
    switch (type) {
      case 'dom_snapshot':
        final treeJson = payload['tree'] as Map<String, dynamic>?;
        _domTree = treeJson != null ? DomNode.fromJson(treeJson) : null;
        notifyListeners();
        break;

      case 'storage_snapshot':
        _storageSnapshot = StorageSnapshot.fromJson(payload);
        notifyListeners();
        break;

      case 'network_request':
        _networkRequests.insert(0, NetworkRequestEntry.fromJson(payload));
        if (_networkRequests.length > _maxNetworkEntries) {
          _networkRequests.removeRange(_maxNetworkEntries, _networkRequests.length);
        }
        notifyListeners();
        break;
    }
  }

  /// Selects a DOM node by its instrumentation-assigned id and fetches
  /// its computed styles by executing JS directly against the live page.
  Future<void> selectNode(String weblabId, WebViewController webViewController) async {
    _selectedNodeId = weblabId;
    notifyListeners();

    try {
      final result = await webViewController.runJavaScriptReturningResult(
        '__weblabGetComputedStyle("$weblabId")',
      );
      final decoded = _decodeJsResult(result);
      _computedStyles = (jsonDecode(decoded) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toString()));
    } catch (_) {
      _computedStyles = {};
    }
    notifyListeners();
  }

  /// Requests a fresh storage snapshot from the live page on demand
  /// (e.g. a manual refresh button), rather than waiting for the next
  /// automatic push.
  Future<void> refreshStorage(WebViewController webViewController) async {
    try {
      await webViewController.runJavaScript('window.__weblabRefreshStorage && window.__weblabRefreshStorage()');
    } catch (_) {
      // Ignored — the page may not have finished loading instrumentation yet.
    }
  }

  void clearNetworkLog() {
    _networkRequests.clear();
    notifyListeners();
  }

  void deselectNode() {
    _selectedNodeId = null;
    _computedStyles = {};
    notifyListeners();
  }

  /// `runJavaScriptReturningResult` returns a JSON-encoded string on some
  /// platforms and a plain (already-quoted) string on others; this
  /// normalizes both so `jsonDecode` always receives valid JSON.
  String _decodeJsResult(Object result) {
    final raw = result.toString();
    if (raw.startsWith('"') && raw.endsWith('"')) {
      return jsonDecode(raw) as String;
    }
    return raw;
  }
}
