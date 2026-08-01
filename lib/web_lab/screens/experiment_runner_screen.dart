import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ============================================================
// MODELS
// ============================================================

/// One version of an idea being tested — e.g. "loop with forEach" vs
/// "loop with for...of" — each a real JS snippet the student writes
/// themselves. Comparing variants like this is the actual mechanism of
/// empirical testing: not "does my code work" but "which approach is
/// actually better, and by how much."
class ExperimentVariant {
  final String id;
  String name;
  String code;

  ExperimentVariant({required this.id, required this.name, required this.code});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'code': code};

  factory ExperimentVariant.fromJson(Map<String, dynamic> json) {
    return ExperimentVariant(id: json['id'] as String, name: json['name'] as String, code: json['code'] as String);
  }
}

/// The measured outcome of running one variant [iterations] times.
class ExperimentRunResult {
  final double totalMs;
  final double avgMs;
  final List<String> lastRunLogs;
  final String? error;

  const ExperimentRunResult({required this.totalMs, required this.avgMs, required this.lastRunLogs, this.error});

  Map<String, dynamic> toJson() => {'totalMs': totalMs, 'avgMs': avgMs, 'lastRunLogs': lastRunLogs, 'error': error};

  factory ExperimentRunResult.fromJson(Map<String, dynamic> json) {
    return ExperimentRunResult(
      totalMs: (json['totalMs'] as num).toDouble(),
      avgMs: (json['avgMs'] as num).toDouble(),
      lastRunLogs: (json['lastRunLogs'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      error: json['error'] as String?,
    );
  }
}

/// A full comparative experiment: a question, several variants meant to
/// answer it, an iteration count, and the most recent measured results
/// per variant — formalizing "I think X is faster" into something with
/// an actual number attached.
class Experiment {
  final String id;
  final String projectId;
  String title;
  int iterations;
  List<ExperimentVariant> variants;
  Map<String, ExperimentRunResult> results;
  final DateTime createdAt;
  DateTime updatedAt;

  Experiment({
    required this.id,
    required this.projectId,
    required this.title,
    this.iterations = 1000,
    List<ExperimentVariant>? variants,
    Map<String, ExperimentRunResult>? results,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : variants = variants ?? [],
        results = results ?? {},
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'projectId': projectId,
        'title': title,
        'iterations': iterations,
        'variants': variants.map((v) => v.toJson()).toList(),
        'results': results.map((key, value) => MapEntry(key, value.toJson())),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Experiment.fromJson(Map<String, dynamic> json) {
    return Experiment(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      iterations: json['iterations'] as int? ?? 1000,
      variants: (json['variants'] as List<dynamic>? ?? []).map((v) => ExperimentVariant.fromJson(v as Map<String, dynamic>)).toList(),
      results: (json['results'] as Map<String, dynamic>? ?? {}).map((key, value) => MapEntry(key, ExperimentRunResult.fromJson(value as Map<String, dynamic>))),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

// ============================================================
// REPOSITORY
// ============================================================

class ExperimentRepository {
  static const String _storageKey = 'web_lab.experiments';

  Future<List<Experiment>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => Experiment.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<Experiment> experiments) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(experiments.map((e) => e.toJson()).toList()));
  }
}

// ============================================================
// CONTROLLER
// ============================================================

/// Owns the list of experiments and drives actually running one: builds
/// a document per variant that executes the student's code N times in a
/// row inside a real JS engine (via WebView), timing the whole batch and
/// capturing console output from the final run — genuine measurement,
/// not a simulated number.
class ExperimentController extends ChangeNotifier {
  final ExperimentRepository _repository = ExperimentRepository();
  List<Experiment> _experiments = [];
  bool _isLoading = false;
  bool _isRunning = false;
  String? _runningVariantName;

  List<Experiment> get experiments => List.unmodifiable(_experiments);
  bool get isLoading => _isLoading;
  bool get isRunning => _isRunning;
  String? get runningVariantName => _runningVariantName;

  List<Experiment> forProject(String projectId) => _experiments.where((e) => e.projectId == projectId).toList();

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _experiments = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<Experiment> create(String title, String projectId) async {
    final experiment = Experiment(id: '${DateTime.now().microsecondsSinceEpoch}', projectId: projectId, title: title);
    experiment.variants.add(ExperimentVariant(id: 'a', name: 'Variant A', code: '// Write your first approach here\n'));
    experiment.variants.add(ExperimentVariant(id: 'b', name: 'Variant B', code: '// Write your second approach here\n'));
    _experiments.add(experiment);
    await _repository.saveAll(_experiments);
    notifyListeners();
    return experiment;
  }

  Future<void> save(Experiment experiment) async {
    experiment.updatedAt = DateTime.now();
    await _repository.saveAll(_experiments);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _experiments.removeWhere((e) => e.id == id);
    await _repository.saveAll(_experiments);
    notifyListeners();
  }

  void addVariant(Experiment experiment) {
    final letter = String.fromCharCode(65 + experiment.variants.length);
    experiment.variants.add(ExperimentVariant(id: '${DateTime.now().microsecondsSinceEpoch}', name: 'Variant $letter', code: '// Write this approach here\n'));
    notifyListeners();
  }

  void removeVariant(Experiment experiment, String variantId) {
    if (experiment.variants.length <= 2) return;
    experiment.variants.removeWhere((v) => v.id == variantId);
    experiment.results.remove(variantId);
    notifyListeners();
  }

  void setIterations(Experiment experiment, int value) {
    experiment.iterations = value.clamp(1, 100000);
    notifyListeners();
  }

  /// Runs every variant in [experiment] sequentially inside [webView],
  /// awaiting each variant's result message before moving to the next —
  /// running two heavy benchmarks concurrently in one WebView would
  /// contaminate each other's timing.
  Future<void> runAll(Experiment experiment, WebViewController webView) async {
    _isRunning = true;
    notifyListeners();

    for (final variant in experiment.variants) {
      _runningVariantName = variant.name;
      notifyListeners();

      final result = await _runOne(variant, experiment.iterations, webView);
      experiment.results[variant.id] = result;
      notifyListeners();
    }

    _runningVariantName = null;
    _isRunning = false;
    await save(experiment);
  }

  Future<ExperimentRunResult> _runOne(ExperimentVariant variant, int iterations, WebViewController webView) async {
    final completer = Completer<ExperimentRunResult>();

    late final void Function(JavaScriptMessage) handler;
    handler = (message) {
      try {
        final payload = jsonDecode(message.message) as Map<String, dynamic>;
        if (!completer.isCompleted) {
          completer.complete(ExperimentRunResult(
            totalMs: (payload['totalMs'] as num).toDouble(),
            avgMs: (payload['avgMs'] as num).toDouble(),
            lastRunLogs: (payload['logs'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
            error: payload['error'] as String?,
          ));
        }
      } catch (_) {
        if (!completer.isCompleted) {
          completer.complete(const ExperimentRunResult(totalMs: 0, avgMs: 0, lastRunLogs: [], error: 'Malformed result'));
        }
      }
    };

    await webView.removeJavaScriptChannel('WebLabExperiment').catchError((_) {});
    await webView.addJavaScriptChannel('WebLabExperiment', onMessageReceived: handler);
    await webView.loadHtmlString(_buildDocument(variant.code, iterations));

    return completer.future.timeout(const Duration(seconds: 30), onTimeout: () {
      return const ExperimentRunResult(totalMs: 0, avgMs: 0, lastRunLogs: [], error: 'Timed out — check for an infinite loop.');
    });
  }

  String _buildDocument(String code, int iterations) {
    return '''
<!DOCTYPE html>
<html><head><meta charset="UTF-8"></head><body>
<script>
(function () {
  var logs = [];
  var originalLog = console.log;
  console.log = function () {
    logs.push(Array.prototype.slice.call(arguments).map(function (a) {
      try { return typeof a === 'object' ? JSON.stringify(a) : String(a); } catch (e) { return String(a); }
    }).join(' '));
    originalLog.apply(console, arguments);
  };

  var error = null;
  var totalMs = 0;
  var avgMs = 0;

  try {
    var fn = new Function($code);
    var start = performance.now();
    for (var i = 0; i < $iterations; i++) {
      if (i === $iterations - 1) logs = [];
      fn();
    }
    totalMs = performance.now() - start;
    avgMs = totalMs / $iterations;
  } catch (e) {
    error = e.message;
  }

  if (window.WebLabExperiment) {
    window.WebLabExperiment.postMessage(JSON.stringify({ totalMs: totalMs, avgMs: avgMs, logs: logs, error: error }));
  }
})();
</script>
</body></html>
''';
  }
}

// ============================================================
// SCREENS
// ============================================================

/// Lists every experiment for a project — the institute's lab-bench
/// registry of "questions we tested."
class ExperimentListScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  const ExperimentListScreen({super.key, required this.projectId, required this.projectName});

  @override
  State<ExperimentListScreen> createState() => _ExperimentListScreenState();
}

class _ExperimentListScreenState extends State<ExperimentListScreen> {
  late final ExperimentController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExperimentController();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createNew() async {
    final titleController = TextEditingController();
    final title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Experiment'),
        content: TextField(controller: titleController, autofocus: true, decoration: const InputDecoration(hintText: 'e.g. "Is a for loop faster than forEach?"')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, titleController.text), child: const Text('Create')),
        ],
      ),
    );
    if (title == null || title.trim().isEmpty) return;

    final experiment = await _controller.create(title.trim(), widget.projectId);
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => ExperimentDetailScreen(controller: _controller, experiment: experiment)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Experiments — ${widget.projectName}')),
      floatingActionButton: FloatingActionButton(onPressed: _createNew, child: const Icon(Icons.add)),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
          final list = _controller.forProject(widget.projectId);

          if (list.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('No experiments yet. Ask a question you can actually test — e.g. "which loop is faster?"', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final experiment = list[index];
              return Card(
                child: ListTile(
                  title: Text(experiment.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${experiment.variants.length} variants · ${experiment.results.length} results'),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExperimentDetailScreen(controller: _controller, experiment: experiment))),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Edit variants, set iteration count, run the comparison, and see the
/// measured results side by side.
class ExperimentDetailScreen extends StatefulWidget {
  final ExperimentController controller;
  final Experiment experiment;

  const ExperimentDetailScreen({super.key, required this.controller, required this.experiment});

  @override
  State<ExperimentDetailScreen> createState() => _ExperimentDetailScreenState();
}

class _ExperimentDetailScreenState extends State<ExperimentDetailScreen> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  Future<void> _run() async {
    await widget.controller.runAll(widget.experiment, _webViewController);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Experiment complete')));
  }

  Future<void> _editVariantCode(ExperimentVariant variant) async {
    final codeController = TextEditingController(text: variant.code);
    final code = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(variant.name),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(controller: codeController, maxLines: 10, style: const TextStyle(fontFamily: 'monospace', fontSize: 12), decoration: const InputDecoration(border: OutlineInputBorder())),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, codeController.text), child: const Text('Save')),
        ],
      ),
    );
    if (code == null) return;
    variant.code = code;
    await widget.controller.save(widget.experiment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.experiment.title)),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          return Column(
            children: [
              SizedBox(width: 1, height: 1, child: WebViewWidget(controller: _webViewController)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text('Iterations'),
                    Expanded(
                      child: Slider(
                        value: widget.experiment.iterations.toDouble().clamp(1, 100000),
                        min: 1,
                        max: 100000,
                        onChanged: (v) => widget.controller.setIterations(widget.experiment, v.round()),
                      ),
                    ),
                    Text('${widget.experiment.iterations}'),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    ...widget.experiment.variants.map((variant) {
                      final result = widget.experiment.results[variant.id];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(variant.name, style: const TextStyle(fontWeight: FontWeight.bold))),
                                  IconButton(icon: const Icon(Icons.edit_outlined, size: 18), onPressed: () => _editVariantCode(variant)),
                                  if (widget.experiment.variants.length > 2)
                                    IconButton(icon: const Icon(Icons.close, size: 18), onPressed: () => widget.controller.removeVariant(widget.experiment, variant.id)),
                                ],
                              ),
                              if (result != null) ...[
                                const Divider(),
                                if (result.error != null)
                                  Text('Error: ${result.error}', style: const TextStyle(color: Colors.red, fontSize: 12))
                                else ...[
                                  Text('Average: ${result.avgMs.toStringAsFixed(4)}ms per run', style: const TextStyle(fontWeight: FontWeight.w600)),
                                  Text('Total: ${result.totalMs.toStringAsFixed(2)}ms for ${widget.experiment.iterations} runs', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  if (result.lastRunLogs.isNotEmpty) ...[
                                    const SizedBox(height: 6),
                                    Text('Last run output:', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                                    ...result.lastRunLogs.map((log) => Text(log, style: const TextStyle(fontFamily: 'monospace', fontSize: 11))),
                                  ],
                                ],
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                    TextButton.icon(icon: const Icon(Icons.add), label: const Text('Add variant'), onPressed: () => widget.controller.addVariant(widget.experiment)),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: widget.controller.isRunning ? null : _run,
        icon: widget.controller.isRunning ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.play_arrow),
        label: Text(widget.controller.isRunning ? 'Running ${widget.controller.runningVariantName}...' : 'Run All'),
      ),
    );
  }
}
