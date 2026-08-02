import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/project_controller.dart';

// ============================================================
// FUTURE WEB SANDBOX — curated real-API experiments, not fantasy tech
// ============================================================

class FrontierExperiment {
  final String title;
  final String description;
  final String html;
  final String css;
  final String js;

  const FrontierExperiment({required this.title, required this.description, required this.html, this.css = '', this.js = ''});
}

class FrontierExperimentLibrary {
  FrontierExperimentLibrary._();

  static const List<FrontierExperiment> all = [
    FrontierExperiment(
      title: '3D Rotating Shape',
      description: 'A real WebGL scene using Three.js — rotate, scale, and reshape it in script.js.',
      html: '<div id="scene"></div>\n<script src="https://cdn.jsdelivr.net/npm/three@0.169.0/build/three.min.js"></script>',
      css: 'body { margin: 0; overflow: hidden; }\n#scene { width: 100vw; height: 100vh; }',
      js: '''
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.getElementById('scene').appendChild(renderer.domElement);

const geometry = new THREE.BoxGeometry();
const material = new THREE.MeshBasicMaterial({ color: 0x3b82f6, wireframe: true });
const cube = new THREE.Mesh(geometry, material);
scene.add(cube);
camera.position.z = 5;

function animate() {
  requestAnimationFrame(animate);
  cube.rotation.x += 0.01;
  cube.rotation.y += 0.01;
  renderer.render(scene, camera);
}
animate();
''',
    ),
    FrontierExperiment(
      title: 'Gesture-First Interface',
      description: 'A real touch-event canvas — draw with your finger, no mouse or keyboard involved.',
      html: '<canvas id="canvas"></canvas>\n<p style="position:fixed;top:8px;left:8px;font-family:sans-serif;color:#666">Draw with your finger</p>',
      css: 'body { margin: 0; } canvas { display: block; background: #f5f5f5; touch-action: none; }',
      js: '''
const canvas = document.getElementById('canvas');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;
const ctx = canvas.getContext('2d');
let drawing = false;

canvas.addEventListener('touchstart', (e) => {
  drawing = true;
  const t = e.touches[0];
  ctx.beginPath();
  ctx.moveTo(t.clientX, t.clientY);
});

canvas.addEventListener('touchmove', (e) => {
  if (!drawing) return;
  const t = e.touches[0];
  ctx.lineTo(t.clientX, t.clientY);
  ctx.stroke();
});

canvas.addEventListener('touchend', () => { drawing = false; });
''',
    ),
    FrontierExperiment(
      title: 'Voice Output Interface',
      description: 'A real text-to-speech interface using the Web Speech API — type something and hear it spoken.',
      html: '''
<div style="font-family:sans-serif;padding:20px;">
  <textarea id="text" rows="4" style="width:100%;font-size:16px;" placeholder="Type something to hear it..."></textarea>
  <button id="speak" style="margin-top:12px;padding:10px 20px;">Speak</button>
</div>
''',
      js: '''
document.getElementById('speak').addEventListener('click', () => {
  const text = document.getElementById('text').value;
  if (!text) return;
  const utterance = new SpeechSynthesisUtterance(text);
  window.speechSynthesis.speak(utterance);
});
''',
    ),
  ];
}

class FutureWebSandboxScreen extends StatelessWidget {
  final ProjectController projectController;

  const FutureWebSandboxScreen({super.key, required this.projectController});

  Future<void> _useExperiment(BuildContext context, FrontierExperiment experiment) async {
    final nameController = TextEditingController(text: experiment.title);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name your new project'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;

    await projectController.createFromTemplate(
      name: name.trim(),
      templateId: 'frontier_${experiment.title}',
      starterFiles: {'index.html': experiment.html, 'style.css': experiment.css, 'script.js': experiment.js},
    );

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Created "$name" — find it from Home.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Future Web Sandbox')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: FrontierExperimentLibrary.all.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final experiment = FrontierExperimentLibrary.all[index];
          return Card(
            child: ListTile(
              title: Text(experiment.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(experiment.description),
              trailing: FilledButton.tonal(onPressed: () => _useExperiment(context, experiment), child: const Text('Try it')),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// LAYOUT SANDBOX — write your own positioning algorithm, see it
// actually run against real boxes
// ============================================================

class LayoutSandboxController extends ChangeNotifier {
  String algorithmCode = '''
// You receive: boxes (array of {id, label}) and container ({width, height}).
// Return an array of {id, x, y, width, height} — one per box.
// This is literally how flexbox, grid, and every layout system works
// under the hood: a function that turns constraints into positions.

function layout(boxes, container) {
  const boxWidth = container.width / boxes.length;
  return boxes.map((box, index) => ({
    id: box.id,
    x: index * boxWidth,
    y: 0,
    width: boxWidth - 10,
    height: 100
  }));
}
''';

  List<Map<String, String>> boxes = [
    {'id': 'a', 'label': 'Box A'},
    {'id': 'b', 'label': 'Box B'},
    {'id': 'c', 'label': 'Box C'},
  ];

  void updateCode(String value) {
    algorithmCode = value;
    notifyListeners();
  }

  void addBox() {
    final letter = String.fromCharCode(97 + boxes.length);
    boxes.add({'id': letter, 'label': 'Box ${letter.toUpperCase()}'});
    notifyListeners();
  }

  void removeBox() {
    if (boxes.length <= 1) return;
    boxes.removeLast();
    notifyListeners();
  }

  String buildDocument(double containerWidth, double containerHeight) {
    final boxesJson = jsonEncode(boxes);
    final colors = ['#3B82F6', '#8B5CF6', '#EC4899', '#F59E0B', '#10B981', '#EF4444'];

    return '''
<!DOCTYPE html><html><head><meta charset="UTF-8"><style>
body { margin: 0; }
.box { position: absolute; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white; font-family: sans-serif; font-size: 13px; box-sizing: border-box; }
</style></head><body>
<div id="container" style="position:relative; width:${containerWidth}px; height:${containerHeight}px; background:#f0f0f0;"></div>
<script>
$algorithmCode

const boxes = $boxesJson;
const container = { width: $containerWidth, height: $containerHeight };
const colors = ${jsonEncode(colors)};

try {
  const positions = layout(boxes, container);
  const containerEl = document.getElementById('container');
  positions.forEach((pos, i) => {
    const el = document.createElement('div');
    el.className = 'box';
    el.style.left = pos.x + 'px';
    el.style.top = pos.y + 'px';
    el.style.width = pos.width + 'px';
    el.style.height = pos.height + 'px';
    el.style.background = colors[i % colors.length];
    el.innerText = boxes[i].label;
    containerEl.appendChild(el);
  });
} catch (e) {
  document.body.innerHTML = '<p style="color:red;font-family:sans-serif;padding:20px;">Error: ' + e.message + '</p>';
}
</script>
</body></html>
''';
  }
}

class LayoutSandboxScreen extends StatefulWidget {
  const LayoutSandboxScreen({super.key});

  @override
  State<LayoutSandboxScreen> createState() => _LayoutSandboxScreenState();
}

class _LayoutSandboxScreenState extends State<LayoutSandboxScreen> {
  late final LayoutSandboxController _controller;
  late final WebViewController _webViewController;
  late final TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _controller = LayoutSandboxController();
    _codeController = TextEditingController(text: _controller.algorithmCode);
    _webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  void dispose() {
    _controller.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    _controller.updateCode(_codeController.text);
    await _webViewController.loadHtmlString(_controller.buildDocument(340, 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout Sandbox')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Column(
            children: [
              Container(
                height: 220,
                color: Colors.grey.shade200,
                child: WebViewWidget(controller: _webViewController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Text('${_controller.boxes.length} boxes'),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: _controller.removeBox),
                    IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: _controller.addBox),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFF1E1E1E),
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _codeController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFD4D4D4)),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.play_arrow), label: const Text('Run Layout'), onPressed: _run)),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ============================================================
// BROWSER CONSTRUCTOR — invent custom tags and CSS properties,
// backed by a real preprocessor that expands them before rendering
// ============================================================

class TagRule {
  final String id;
  String tagName;
  String expandsToHtml;

  TagRule({required this.id, required this.tagName, required this.expandsToHtml});

  Map<String, dynamic> toJson() => {'id': id, 'tagName': tagName, 'expandsToHtml': expandsToHtml};

  factory TagRule.fromJson(Map<String, dynamic> json) {
    return TagRule(id: json['id'] as String, tagName: json['tagName'] as String, expandsToHtml: json['expandsToHtml'] as String);
  }
}

class PropertyRule {
  final String id;
  String propertyName;
  String expandsToCss;

  PropertyRule({required this.id, required this.propertyName, required this.expandsToCss});

  Map<String, dynamic> toJson() => {'id': id, 'propertyName': propertyName, 'expandsToCss': expandsToCss};

  factory PropertyRule.fromJson(Map<String, dynamic> json) {
    return PropertyRule(id: json['id'] as String, propertyName: json['propertyName'] as String, expandsToCss: json['expandsToCss'] as String);
  }
}

class BrowserConcept {
  final String id;
  String name;
  List<TagRule> tagRules;
  List<PropertyRule> propertyRules;
  String sampleHtml;
  String sampleCss;

  BrowserConcept({
    required this.id,
    required this.name,
    List<TagRule>? tagRules,
    List<PropertyRule>? propertyRules,
    this.sampleHtml = '',
    this.sampleCss = '',
  })  : tagRules = tagRules ?? [],
        propertyRules = propertyRules ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tagRules': tagRules.map((r) => r.toJson()).toList(),
        'propertyRules': propertyRules.map((r) => r.toJson()).toList(),
        'sampleHtml': sampleHtml,
        'sampleCss': sampleCss,
      };

  factory BrowserConcept.fromJson(Map<String, dynamic> json) {
    return BrowserConcept(
      id: json['id'] as String,
      name: json['name'] as String,
      tagRules: (json['tagRules'] as List<dynamic>? ?? []).map((r) => TagRule.fromJson(r as Map<String, dynamic>)).toList(),
      propertyRules: (json['propertyRules'] as List<dynamic>? ?? []).map((r) => PropertyRule.fromJson(r as Map<String, dynamic>)).toList(),
      sampleHtml: json['sampleHtml'] as String? ?? '',
      sampleCss: json['sampleCss'] as String? ?? '',
    );
  }

  factory BrowserConcept.starterExample() {
    return BrowserConcept(
      id: 'starter_${DateTime.now().microsecondsSinceEpoch}',
      name: 'BadgeBrowser (example)',
      tagRules: [
        TagRule(id: 't1', tagName: 'badge', expandsToHtml: '<span class="__badge">CONTENT</span>'),
      ],
      propertyRules: [
        PropertyRule(id: 'p1', propertyName: 'glow', expandsToCss: 'box-shadow: 0 0 12px VALUE; border-radius: 8px;'),
      ],
      sampleHtml: '<badge>New</badge>\n<div class="glowbox">Hover-worthy box</div>',
      sampleCss: '.__badge { background: #f59e0b; color: white; padding: 4px 10px; border-radius: 999px; font-family: sans-serif; font-size: 12px; }\n.glowbox { glow: #3b82f6; padding: 20px; font-family: sans-serif; }',
    );
  }
}

/// The actual preprocessor: expands custom tags into their real HTML,
/// and custom "properties" (written as a fake CSS declaration) into
/// their real CSS — genuinely how a browser's own HTML/CSS parsing
/// works in spirit: markup and style get interpreted into a rendering
/// instruction, just with student-defined rules instead of a spec.
class BrowserConceptCompiler {
  String compileHtml(BrowserConcept concept, String html) {
    var result = html;
    for (final rule in concept.tagRules) {
      final openTag = RegExp('<${rule.tagName}>([\\s\\S]*?)</${rule.tagName}>');
      result = result.replaceAllMapped(openTag, (match) {
        return rule.expandsToHtml.replaceAll('CONTENT', match.group(1) ?? '');
      });
    }
    return result;
  }

  String compileCss(BrowserConcept concept, String css) {
    var result = css;
    for (final rule in concept.propertyRules) {
      final declaration = RegExp('${rule.propertyName}\\s*:\\s*([^;]+);');
      result = result.replaceAllMapped(declaration, (match) {
        return rule.expandsToCss.replaceAll('VALUE', match.group(1)?.trim() ?? '');
      });
    }
    return result;
  }
}

class BrowserConstructorRepository {
  static const String _storageKey = 'web_lab.browser_concepts';

  Future<List<BrowserConcept>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => BrowserConcept.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<BrowserConcept> concepts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(concepts.map((c) => c.toJson()).toList()));
  }
}

class BrowserConstructorController extends ChangeNotifier {
  final BrowserConstructorRepository _repository = BrowserConstructorRepository();
  final BrowserConceptCompiler _compiler = BrowserConceptCompiler();
  List<BrowserConcept> _concepts = [];
  bool _isLoading = false;

  List<BrowserConcept> get concepts => List.unmodifiable(_concepts);
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _concepts = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<BrowserConcept> createBlank(String name) async {
    final concept = BrowserConcept(id: '${DateTime.now().microsecondsSinceEpoch}', name: name);
    _concepts.add(concept);
    await _repository.saveAll(_concepts);
    notifyListeners();
    return concept;
  }

  Future<BrowserConcept> createFromExample() async {
    final concept = BrowserConcept.starterExample();
    _concepts.add(concept);
    await _repository.saveAll(_concepts);
    notifyListeners();
    return concept;
  }

  Future<void> save(BrowserConcept concept) async {
    await _repository.saveAll(_concepts);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _concepts.removeWhere((c) => c.id == id);
    await _repository.saveAll(_concepts);
    notifyListeners();
  }

  void addTagRule(BrowserConcept concept) {
    concept.tagRules.add(TagRule(id: '${DateTime.now().microsecondsSinceEpoch}', tagName: 'mytag', expandsToHtml: '<div>CONTENT</div>'));
    notifyListeners();
  }

  void addPropertyRule(BrowserConcept concept) {
    concept.propertyRules.add(PropertyRule(id: '${DateTime.now().microsecondsSinceEpoch}', propertyName: 'myprop', expandsToCss: 'color: VALUE;'));
    notifyListeners();
  }

  void removeTagRule(BrowserConcept concept, String id) {
    concept.tagRules.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  void removePropertyRule(BrowserConcept concept, String id) {
    concept.propertyRules.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  String compileHtml(BrowserConcept concept, String html) => _compiler.compileHtml(concept, html);
  String compileCss(BrowserConcept concept, String css) => _compiler.compileCss(concept, css);
}

class BrowserConstructorListScreen extends StatefulWidget {
  const BrowserConstructorListScreen({super.key});

  @override
  State<BrowserConstructorListScreen> createState() => _BrowserConstructorListScreenState();
}

class _BrowserConstructorListScreenState extends State<BrowserConstructorListScreen> {
  late final BrowserConstructorController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BrowserConstructorController();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createBlank() async {
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name your browser concept'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final concept = await _controller.createBlank(name.trim());
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => BrowserConceptEditorScreen(controller: _controller, concept: concept)));
  }

  Future<void> _createFromExample() async {
    final concept = await _controller.createFromExample();
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => BrowserConceptEditorScreen(controller: _controller, concept: concept)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browser Constructor')),
      floatingActionButton: FloatingActionButton(onPressed: _createBlank, child: const Icon(Icons.add)),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: Colors.indigo.withOpacity(0.08),
                child: ListTile(
                  leading: const Icon(Icons.lightbulb_outline, color: Colors.indigo),
                  title: const Text('See a working example first'),
                  subtitle: const Text('A <badge> tag and a "glow" CSS property, both expanding to real HTML/CSS.'),
                  trailing: FilledButton(onPressed: _createFromExample, child: const Text('Try it')),
                ),
              ),
              const SizedBox(height: 16),
              if (_controller.concepts.isEmpty)
                Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Center(child: Text('No concepts yet.', style: TextStyle(color: Colors.grey.shade600))))
              else
                ..._controller.concepts.map((concept) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(concept.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${concept.tagRules.length} tags · ${concept.propertyRules.length} properties'),
                        trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.delete(concept.id)),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BrowserConceptEditorScreen(controller: _controller, concept: concept))),
                      ),
                    )),
            ],
          );
        },
      ),
    );
  }
}

class BrowserConceptEditorScreen extends StatefulWidget {
  final BrowserConstructorController controller;
  final BrowserConcept concept;

  const BrowserConceptEditorScreen({super.key, required this.controller, required this.concept});

  @override
  State<BrowserConceptEditorScreen> createState() => _BrowserConceptEditorScreenState();
}

class _BrowserConceptEditorScreenState extends State<BrowserConceptEditorScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TextEditingController _htmlController;
  late final TextEditingController _cssController;
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _htmlController = TextEditingController(text: widget.concept.sampleHtml);
    _cssController = TextEditingController(text: widget.concept.sampleCss);
    _webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _htmlController.dispose();
    _cssController.dispose();
    super.dispose();
  }

  Future<void> _editTagRule(TagRule rule) async {
    final tagController = TextEditingController(text: rule.tagName);
    final htmlController = TextEditingController(text: rule.expandsToHtml);
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Custom tag'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: tagController, decoration: const InputDecoration(labelText: 'Tag name (no brackets)')),
            TextField(controller: htmlController, decoration: const InputDecoration(labelText: 'Expands to (use CONTENT for inner text)'), maxLines: 3, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );
    if (saved != true) return;
    rule.tagName = tagController.text.trim();
    rule.expandsToHtml = htmlController.text;
    await widget.controller.save(widget.concept);
    setState(() {});
  }

  Future<void> _editPropertyRule(PropertyRule rule) async {
    final propController = TextEditingController(text: rule.propertyName);
    final cssController = TextEditingController(text: rule.expandsToCss);
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Custom property'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: propController, decoration: const InputDecoration(labelText: 'Property name')),
            TextField(controller: cssController, decoration: const InputDecoration(labelText: 'Expands to (use VALUE for the value given)'), maxLines: 3, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );
    if (saved != true) return;
    rule.propertyName = propController.text.trim();
    rule.expandsToCss = cssController.text;
    await widget.controller.save(widget.concept);
    setState(() {});
  }

  Future<void> _run() async {
    widget.concept.sampleHtml = _htmlController.text;
    widget.concept.sampleCss = _cssController.text;
    await widget.controller.save(widget.concept);

    final html = widget.controller.compileHtml(widget.concept, _htmlController.text);
    final css = widget.controller.compileCss(widget.concept, _cssController.text);

    final document = '<!DOCTYPE html><html><head><meta charset="UTF-8"><style>$css</style></head><body>$html</body></html>';
    await _webViewController.loadHtmlString(document);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.concept.name),
        bottom: TabBar(controller: _tabController, tabs: const [Tab(text: 'Rules'), Tab(text: 'Write & Preview')]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(children: [const Text('Custom Tags', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), IconButton(icon: const Icon(Icons.add), onPressed: () { widget.controller.addTagRule(widget.concept); setState(() {}); })]),
              ...widget.concept.tagRules.map((r) => Card(child: ListTile(title: Text('<${r.tagName}>'), subtitle: Text(r.expandsToHtml, maxLines: 1, overflow: TextOverflow.ellipsis), trailing: IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: () { widget.controller.removeTagRule(widget.concept, r.id); setState(() {}); }), onTap: () => _editTagRule(r)))),
              const Divider(height: 32),
              Row(children: [const Text('Custom CSS Properties', style: TextStyle(fontWeight: FontWeight.bold)), const Spacer(), IconButton(icon: const Icon(Icons.add), onPressed: () { widget.controller.addPropertyRule(widget.concept); setState(() {}); })]),
              ...widget.concept.propertyRules.map((r) => Card(child: ListTile(title: Text(r.propertyName), subtitle: Text(r.expandsToCss, maxLines: 1, overflow: TextOverflow.ellipsis), trailing: IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: () { widget.controller.removePropertyRule(widget.concept, r.id); setState(() {}); }), onTap: () => _editPropertyRule(r)))),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 200, child: WebViewWidget(controller: _webViewController)),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: const Color(0xFF1E1E1E),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('HTML', style: TextStyle(color: Colors.white54, fontSize: 11)),
                            Expanded(child: TextField(controller: _htmlController, maxLines: null, expands: true, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFD4D4D4)), decoration: const InputDecoration(border: InputBorder.none))),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: const Color(0xFF252526),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('CSS', style: TextStyle(color: Colors.white54, fontSize: 11)),
                            Expanded(child: TextField(controller: _cssController, maxLines: null, expands: true, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFD4D4D4)), decoration: const InputDecoration(border: InputBorder.none))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.all(12), child: SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.play_arrow), label: const Text('Compile & Preview'), onPressed: _run))),
            ],
          ),
        ],
      ),
    );
  }
}
