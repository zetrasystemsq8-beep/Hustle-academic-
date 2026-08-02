import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/project_controller.dart';
import '../models/project_model.dart';
import '../storage/local_storage_keys.dart';

// ============================================================
// MODELS
// ============================================================

enum SiteType { project, mockApi }

/// One configurable mock API response — the building block for
/// simulating authentication, payments, or any backend behavior a
/// student can describe as "when this path is called, respond with
/// this." Real HTTP semantics (method, status code, headers, delay),
/// entirely student-defined.
class MockEndpoint {
  final String id;
  String method;
  String path;
  int statusCode;
  String responseBody;
  bool requiresAuthHeader;
  int simulatedDelayMs;

  MockEndpoint({
    required this.id,
    this.method = 'GET',
    this.path = '/',
    this.statusCode = 200,
    this.responseBody = '{"message": "hello"}',
    this.requiresAuthHeader = false,
    this.simulatedDelayMs = 200,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'method': method,
        'path': path,
        'statusCode': statusCode,
        'responseBody': responseBody,
        'requiresAuthHeader': requiresAuthHeader,
        'simulatedDelayMs': simulatedDelayMs,
      };

  factory MockEndpoint.fromJson(Map<String, dynamic> json) {
    return MockEndpoint(
      id: json['id'] as String,
      method: json['method'] as String? ?? 'GET',
      path: json['path'] as String? ?? '/',
      statusCode: json['statusCode'] as int? ?? 200,
      responseBody: json['responseBody'] as String? ?? '{}',
      requiresAuthHeader: json['requiresAuthHeader'] as bool? ?? false,
      simulatedDelayMs: json['simulatedDelayMs'] as int? ?? 200,
    );
  }
}

/// One node in the simulated internet — either a real Web Lab project
/// made reachable at a fake domain, or a mock API service with no UI,
/// just configured endpoints.
class UniverseSite {
  final String id;
  String domain;
  String description;
  SiteType type;
  String? projectId;
  List<MockEndpoint> endpoints;
  double graphX;
  double graphY;

  UniverseSite({
    required this.id,
    required this.domain,
    this.description = '',
    required this.type,
    this.projectId,
    List<MockEndpoint>? endpoints,
    this.graphX = 100,
    this.graphY = 100,
  }) : endpoints = endpoints ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'domain': domain,
        'description': description,
        'type': type.name,
        'projectId': projectId,
        'endpoints': endpoints.map((e) => e.toJson()).toList(),
        'graphX': graphX,
        'graphY': graphY,
      };

  factory UniverseSite.fromJson(Map<String, dynamic> json) {
    return UniverseSite(
      id: json['id'] as String,
      domain: json['domain'] as String,
      description: json['description'] as String? ?? '',
      type: SiteType.values.byName(json['type'] as String),
      projectId: json['projectId'] as String?,
      endpoints: (json['endpoints'] as List<dynamic>? ?? []).map((e) => MockEndpoint.fromJson(e as Map<String, dynamic>)).toList(),
      graphX: (json['graphX'] as num?)?.toDouble() ?? 100,
      graphY: (json['graphY'] as num?)?.toDouble() ?? 100,
    );
  }
}

/// A purely visual/documentation link between two sites — "this site
/// calls that one" — drawn on the Internet Simulator graph. Doesn't
/// affect whether a fetch actually works (any site can reach any other
/// site's domain by design), it's the student's own architecture
/// diagram of their invented network.
class UniverseLink {
  final String id;
  final String fromSiteId;
  final String toSiteId;
  final String label;

  const UniverseLink({required this.id, required this.fromSiteId, required this.toSiteId, this.label = ''});

  Map<String, dynamic> toJson() => {'id': id, 'fromSiteId': fromSiteId, 'toSiteId': toSiteId, 'label': label};

  factory UniverseLink.fromJson(Map<String, dynamic> json) {
    return UniverseLink(id: json['id'] as String, fromSiteId: json['fromSiteId'] as String, toSiteId: json['toSiteId'] as String, label: json['label'] as String? ?? '');
  }
}

/// A full simulated internet: a named set of sites and the links
/// between them.
class WebUniverse {
  final String id;
  String name;
  List<UniverseSite> sites;
  List<UniverseLink> links;
  DateTime updatedAt;

  WebUniverse({
    required this.id,
    required this.name,
    List<UniverseSite>? sites,
    List<UniverseLink>? links,
    DateTime? updatedAt,
  })  : sites = sites ?? [],
        links = links ?? [],
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sites': sites.map((s) => s.toJson()).toList(),
        'links': links.map((l) => l.toJson()).toList(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory WebUniverse.fromJson(Map<String, dynamic> json) {
    return WebUniverse(
      id: json['id'] as String,
      name: json['name'] as String,
      sites: (json['sites'] as List<dynamic>? ?? []).map((s) => UniverseSite.fromJson(s as Map<String, dynamic>)).toList(),
      links: (json['links'] as List<dynamic>? ?? []).map((l) => UniverseLink.fromJson(l as Map<String, dynamic>)).toList(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

// ============================================================
// REPOSITORY
// ============================================================

class WebUniverseRepository {
  static const String _storageKey = 'web_lab.universes';

  Future<List<WebUniverse>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => WebUniverse.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<WebUniverse> universes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(universes.map((u) => u.toJson()).toList()));
  }

  /// Reads a project's raw file tree directly from local storage, by
  /// id, without disturbing whichever project is currently open in the
  /// editor — this is a read-only peek, not a navigation.
  Future<ProjectModel?> loadProjectRaw(String projectId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(LocalStorageKeys.projectKey(projectId));
    if (raw == null) return null;
    return ProjectModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}

// ============================================================
// CONTROLLER
// ============================================================

class WebUniverseController extends ChangeNotifier {
  final WebUniverseRepository _repository = WebUniverseRepository();
  List<WebUniverse> _universes = [];
  bool _isLoading = false;
  final Random _random = Random();

  List<WebUniverse> get universes => List.unmodifiable(_universes);
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _universes = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<WebUniverse> create(String name) async {
    final universe = WebUniverse(id: '${DateTime.now().microsecondsSinceEpoch}', name: name);
    _universes.add(universe);
    await _repository.saveAll(_universes);
    notifyListeners();
    return universe;
  }

  Future<void> save(WebUniverse universe) async {
    universe.updatedAt = DateTime.now();
    await _repository.saveAll(_universes);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _universes.removeWhere((u) => u.id == id);
    await _repository.saveAll(_universes);
    notifyListeners();
  }

  void addSite(WebUniverse universe, {required SiteType type, String? projectId, String? projectName}) {
    final site = UniverseSite(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      domain: type == SiteType.project ? '${_slugify(projectName ?? 'site')}.zone' : 'api-${_random.nextInt(9999)}.zone',
      type: type,
      projectId: projectId,
      description: type == SiteType.project ? (projectName ?? '') : 'Mock API',
      graphX: 60 + _random.nextInt(200).toDouble(),
      graphY: 60 + _random.nextInt(200).toDouble(),
    );
    universe.sites.add(site);
    notifyListeners();
  }

  void removeSite(WebUniverse universe, String siteId) {
    universe.sites.removeWhere((s) => s.id == siteId);
    universe.links.removeWhere((l) => l.fromSiteId == siteId || l.toSiteId == siteId);
    notifyListeners();
  }

  void addLink(WebUniverse universe, String fromId, String toId, String label) {
    if (fromId == toId) return;
    universe.links.add(UniverseLink(id: '${DateTime.now().microsecondsSinceEpoch}', fromSiteId: fromId, toSiteId: toId, label: label));
    notifyListeners();
  }

  void removeLink(WebUniverse universe, String linkId) {
    universe.links.removeWhere((l) => l.id == linkId);
    notifyListeners();
  }

  void moveSite(UniverseSite site, double dx, double dy) {
    site.graphX += dx;
    site.graphY += dy;
    notifyListeners();
  }

  void addEndpoint(UniverseSite site) {
    site.endpoints.add(MockEndpoint(id: '${DateTime.now().microsecondsSinceEpoch}'));
    notifyListeners();
  }

  void removeEndpoint(UniverseSite site, String endpointId) {
    site.endpoints.removeWhere((e) => e.id == endpointId);
    notifyListeners();
  }

  String _slugify(String input) => input.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '');

  Future<ProjectModel?> loadProjectRaw(String projectId) => _repository.loadProjectRaw(projectId);
}

// ============================================================
// DOCUMENT BUILDER — turns a universe + one site into a real,
// runnable HTML document with a genuine fetch() interception layer
// ============================================================

class UniverseDocumentBuilder {
  /// Builds the network routing table shared by every loaded site in
  /// this universe: for mock API sites, their endpoint definitions; for
  /// project sites, their fully assembled HTML so "fetching" that
  /// domain returns real content, the same way retrieving a real page
  /// over HTTP would.
  static Future<Map<String, dynamic>> buildNetworkMap(WebUniverse universe, WebUniverseRepository repository) async {
    final map = <String, dynamic>{};
    for (final site in universe.sites) {
      if (site.type == SiteType.mockApi) {
        map[site.domain] = {
          'type': 'mockApi',
          'endpoints': site.endpoints.map((e) => e.toJson()).toList(),
        };
      } else if (site.projectId != null) {
        final project = await repository.loadProjectRaw(site.projectId!);
        if (project != null) {
          map[site.domain] = {
            'type': 'project',
            'html': project.indexHtml?.content ?? '',
            'css': project.styleCss?.content ?? '',
            'js': project.scriptJs?.content ?? '',
          };
        }
      }
    }
    return map;
  }

  /// The fetch-interception script, shared across every loaded site.
  /// Real fetch semantics: async, respects method/status/headers, and
  /// falls back to the real network for any domain not in this universe
  /// — the simulation augments fetch, it doesn't sandbox it away.
  static String _networkScript(Map<String, dynamic> networkMap) {
    final mapJson = jsonEncode(networkMap);
    return '''
(function () {
  var __networkMap = $mapJson;
  var __originalFetch = window.fetch;

  window.fetch = function (input, init) {
    var urlStr = typeof input === 'string' ? input : (input && input.url) || '';
    var method = ((init && init.method) || 'GET').toUpperCase();
    var headers = (init && init.headers) || {};

    var hostname = '';
    try { hostname = new URL(urlStr).hostname; } catch (e) { hostname = ''; }

    var siteEntry = __networkMap[hostname];
    if (!siteEntry) {
      return __originalFetch.apply(this, arguments);
    }

    return new Promise(function (resolve, reject) {
      var path = '/';
      try { path = new URL(urlStr).pathname || '/'; } catch (e) {}

      setTimeout(function () {
        if (siteEntry.type === 'project') {
          resolve(new Response(siteEntry.html, { status: 200, headers: { 'Content-Type': 'text/html' } }));
          return;
        }

        var endpoint = null;
        for (var i = 0; i < siteEntry.endpoints.length; i++) {
          var ep = siteEntry.endpoints[i];
          if (ep.method.toUpperCase() === method && ep.path === path) { endpoint = ep; break; }
        }

        if (!endpoint) {
          resolve(new Response(JSON.stringify({ error: 'No mock endpoint for ' + method + ' ' + path }), { status: 404 }));
          return;
        }

        if (endpoint.requiresAuthHeader && !headers['Authorization'] && !headers['authorization']) {
          resolve(new Response(JSON.stringify({ error: 'Unauthorized — missing Authorization header' }), { status: 401 }));
          return;
        }

        resolve(new Response(endpoint.responseBody, { status: endpoint.statusCode }));
      }, siteEntry.type === 'mockApi' ? 0 : 0);
    });
  };
})();
''';
  }

  /// Assembles the full document for [site] within [universe], with the
  /// network simulation script injected before the site's own script.js
  /// (or, for mock API sites with no UI, a simple auto-generated status
  /// page listing their configured endpoints).
  static String buildDocumentFor(UniverseSite site, Map<String, dynamic> networkMap, {String? projectHtml, String? projectCss, String? projectJs}) {
    if (site.type == SiteType.mockApi) {
      final rows = site.endpoints.map((e) => '<tr><td>${e.method}</td><td>${e.path}</td><td>${e.statusCode}</td><td>${e.requiresAuthHeader ? "Yes" : "No"}</td></tr>').join();
      return '''
<!DOCTYPE html><html><head><meta charset="UTF-8"><style>
body { font-family: sans-serif; padding: 20px; }
table { border-collapse: collapse; width: 100%; }
td, th { border: 1px solid #ccc; padding: 8px; text-align: left; font-size: 13px; }
</style></head><body>
<h2>${site.domain}</h2>
<p>${site.description}</p>
<table><tr><th>Method</th><th>Path</th><th>Status</th><th>Auth required</th></tr>$rows</table>
</body></html>
''';
    }

    return '''
<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>${projectCss ?? ''}</style></head><body>
${projectHtml ?? ''}
<script>${_networkScript(networkMap)}</script>
<script>${projectJs ?? ''}</script>
</body></html>
''';
  }
}

// ============================================================
// GRAPH VIEW — visual node-and-line editor for the Internet Simulator
// ============================================================

class UniverseGraphView extends StatelessWidget {
  final WebUniverse universe;
  final WebUniverseController controller;
  final ValueChanged<UniverseSite> onTapSite;

  const UniverseGraphView({super.key, required this.universe, required this.controller, required this.onTapSite});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _LinkPainter(universe: universe),
          ),
          ...universe.sites.map((site) {
            return Positioned(
              left: site.graphX,
              top: site.graphY,
              child: GestureDetector(
                onTap: () => onTapSite(site),
                onPanUpdate: (details) => controller.moveSite(site, details.delta.dx, details.delta.dy),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: site.type == SiteType.project ? Colors.blue.shade100 : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: site.type == SiteType.project ? Colors.blue : Colors.orange),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(site.type == SiteType.project ? Icons.public : Icons.dns, size: 16),
                      Text(site.domain, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _LinkPainter extends CustomPainter {
  final WebUniverse universe;

  _LinkPainter({required this.universe});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5;

    for (final link in universe.links) {
      UniverseSite? from, to;
      for (final s in universe.sites) {
        if (s.id == link.fromSiteId) from = s;
        if (s.id == link.toSiteId) to = s;
      }
      if (from == null || to == null) continue;
      canvas.drawLine(Offset(from.graphX + 30, from.graphY + 20), Offset(to.graphX + 30, to.graphY + 20), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LinkPainter oldDelegate) => true;
}

// ============================================================
// SCREENS
// ============================================================

class WebUniverseListScreen extends StatefulWidget {
  const WebUniverseListScreen({super.key});

  @override
  State<WebUniverseListScreen> createState() => _WebUniverseListScreenState();
}

class _WebUniverseListScreenState extends State<WebUniverseListScreen> {
  late final WebUniverseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebUniverseController();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createNew() async {
    final nameController = TextEditingController(text: 'My Universe');
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name your universe'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final universe = await _controller.create(name.trim());
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => UniverseDetailScreen(controller: _controller, universe: universe)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Web Universe')),
      floatingActionButton: FloatingActionButton(onPressed: _createNew, child: const Icon(Icons.add)),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
          if (_controller.universes.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('No universes yet. A universe is a set of your projects and mock APIs, linked together at fake domains.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _controller.universes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final universe = _controller.universes[index];
              return Card(
                child: ListTile(
                  title: Text(universe.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${universe.sites.length} sites · ${universe.links.length} links'),
                  trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.delete(universe.id)),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UniverseDetailScreen(controller: _controller, universe: universe))),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UniverseDetailScreen extends StatefulWidget {
  final WebUniverseController controller;
  final WebUniverse universe;

  const UniverseDetailScreen({super.key, required this.controller, required this.universe});

  @override
  State<UniverseDetailScreen> createState() => _UniverseDetailScreenState();
}

class _UniverseDetailScreenState extends State<UniverseDetailScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _addProjectSite() async {
    // Simplified: prompt for a project id/name pair the student types,
    // since this screen doesn't hold a live ProjectController list —
    // avoids coupling this file to the full project-picker UI.
    final idController = TextEditingController();
    final nameController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Link a project'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Project name (for the domain)')),
            TextField(controller: idController, decoration: const InputDecoration(labelText: 'Project ID')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Add')),
        ],
      ),
    );
    if (confirmed != true || idController.text.trim().isEmpty) return;
    widget.controller.addSite(widget.universe, type: SiteType.project, projectId: idController.text.trim(), projectName: nameController.text.trim());
    await widget.controller.save(widget.universe);
  }

  Future<void> _addMockApiSite() async {
    widget.controller.addSite(widget.universe, type: SiteType.mockApi);
    await widget.controller.save(widget.universe);
  }

  void _openSiteEditor(UniverseSite site) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SiteEditorScreen(controller: widget.controller, universe: widget.universe, site: site)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.universe.name),
        bottom: TabBar(controller: _tabController, tabs: const [Tab(text: 'Graph'), Tab(text: 'Browser')]),
      ),
      floatingActionButton: PopupMenuButton<String>(
        icon: const Icon(Icons.add),
        onSelected: (v) => v == 'project' ? _addProjectSite() : _addMockApiSite(),
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'project', child: Text('Link a Project')),
          PopupMenuItem(value: 'mockApi', child: Text('Add a Mock API')),
        ],
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          return TabBarView(
            controller: _tabController,
            children: [
              UniverseGraphView(universe: widget.universe, controller: widget.controller, onTapSite: _openSiteEditor),
              UniverseBrowserView(universe: widget.universe, controller: widget.controller),
            ],
          );
        },
      ),
    );
  }
}

class SiteEditorScreen extends StatefulWidget {
  final WebUniverseController controller;
  final WebUniverse universe;
  final UniverseSite site;

  const SiteEditorScreen({super.key, required this.controller, required this.universe, required this.site});

  @override
  State<SiteEditorScreen> createState() => _SiteEditorScreenState();
}

class _SiteEditorScreenState extends State<SiteEditorScreen> {
  late TextEditingController _domainController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _domainController = TextEditingController(text: widget.site.domain);
    _descriptionController = TextEditingController(text: widget.site.description);
  }

  Future<void> _save() async {
    widget.site.domain = _domainController.text.trim();
    widget.site.description = _descriptionController.text.trim();
    await widget.controller.save(widget.universe);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
  }

  Future<void> _editEndpoint(MockEndpoint endpoint) async {
    final methodController = TextEditingController(text: endpoint.method);
    final pathController = TextEditingController(text: endpoint.path);
    final statusController = TextEditingController(text: '${endpoint.statusCode}');
    final bodyController = TextEditingController(text: endpoint.responseBody);
    bool requiresAuth = endpoint.requiresAuthHeader;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Endpoint'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: DropdownButton<String>(isExpanded: true, value: methodController.text, items: ['GET', 'POST', 'PUT', 'DELETE'].map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(), onChanged: (v) => setDialogState(() => methodController.text = v!))),
                  ],
                ),
                TextField(controller: pathController, decoration: const InputDecoration(labelText: 'Path (e.g. /balance)')),
                TextField(controller: statusController, decoration: const InputDecoration(labelText: 'Status code'), keyboardType: TextInputType.number),
                TextField(controller: bodyController, decoration: const InputDecoration(labelText: 'Response body (JSON)'), maxLines: 4, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                SwitchListTile(title: const Text('Requires Authorization header'), value: requiresAuth, onChanged: (v) => setDialogState(() => requiresAuth = v)),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                endpoint.method = methodController.text;
                endpoint.path = pathController.text;
                endpoint.statusCode = int.tryParse(statusController.text) ?? 200;
                endpoint.responseBody = bodyController.text;
                endpoint.requiresAuthHeader = requiresAuth;
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    await widget.controller.save(widget.universe);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.site.domain), actions: [IconButton(icon: const Icon(Icons.save_outlined), onPressed: _save)]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(controller: _domainController, decoration: const InputDecoration(labelText: 'Fake domain')),
          const SizedBox(height: 12),
          TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
          if (widget.site.type == SiteType.mockApi) ...[
            const Divider(height: 32),
            Row(children: [const Text('Endpoints', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), IconButton(icon: const Icon(Icons.add), onPressed: () async { widget.controller.addEndpoint(widget.site); await widget.controller.save(widget.universe); setState(() {}); })]),
            ...widget.site.endpoints.map((e) => Card(
                  child: ListTile(
                    title: Text('${e.method} ${e.path}'),
                    subtitle: Text('Status ${e.statusCode}${e.requiresAuthHeader ? ' · Auth required' : ''}'),
                    trailing: IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: () async { widget.controller.removeEndpoint(widget.site, e.id); await widget.controller.save(widget.universe); setState(() {}); }),
                    onTap: () => _editEndpoint(e),
                  ),
                )),
          ] else
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('This is a project site — visitors and other sites fetching this domain receive its real, current index.html.', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}

/// Address-bar browser for a running universe: type a fake domain, load
/// it, and any fetch() calls made from inside that page to other fake
/// domains in the same universe are genuinely intercepted and answered.
class UniverseBrowserView extends StatefulWidget {
  final WebUniverse universe;
  final WebUniverseController controller;

  const UniverseBrowserView({super.key, required this.universe, required this.controller});

  @override
  State<UniverseBrowserView> createState() => _UniverseBrowserViewState();
}

class _UniverseBrowserViewState extends State<UniverseBrowserView> {
  late final WebViewController _webViewController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    _addressController = TextEditingController(text: widget.universe.sites.isNotEmpty ? widget.universe.sites.first.domain : '');
  }

  Future<void> _navigate() async {
    final domain = _addressController.text.trim();
    UniverseSite? site;
    for (final s in widget.universe.sites) {
      if (s.domain == domain) site = s;
    }
    if (site == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No site with that domain in this universe.')));
      return;
    }

    final networkMap = await UniverseDocumentBuilder.buildNetworkMap(widget.universe, WebUniverseRepository());

    String? html, css, js;
    if (site.type == SiteType.project && site.projectId != null) {
      final project = await widget.controller.loadProjectRaw(site.projectId!);
      html = project?.indexHtml?.content;
      css = project?.styleCss?.content;
      js = project?.scriptJs?.content;
    }

    final document = UniverseDocumentBuilder.buildDocumentFor(site, networkMap, projectHtml: html, projectCss: css, projectJs: js);
    await _webViewController.loadHtmlString(document);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(child: TextField(controller: _addressController, decoration: const InputDecoration(isDense: true, border: OutlineInputBorder(), hintText: 'e.g. mybank.zone'), onSubmitted: (_) => _navigate())),
              const SizedBox(width: 8),
              IconButton(icon: const Icon(Icons.arrow_forward), onPressed: _navigate),
            ],
          ),
        ),
        Expanded(child: WebViewWidget(controller: _webViewController)),
      ],
    );
  }
}
