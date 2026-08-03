import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'system_builder_screen.dart';

// ============================================================
// GROQ AGENT — a real competitor: an actual LLM reasoning about
// the same GridWorld task via a real API call, not a stand-in.
// ============================================================

/// Change this if Groq retires the model — everything else in this
/// file is independent of which model string is used here.
const String _kGroqModel = 'llama-3.3-70b-versatile';

class GroqAgentRunner {
  Future<CognitiveRunResult> run(GridWorldTask task) async {
    final apiKey = dotenv.env['GROQ_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      return const CognitiveRunResult(success: false, ticksUsed: 0, elapsedMs: 0, trainingSummary: 'No GROQ_API_KEY configured.', trace: [], actionCommands: []);
    }

    final stopwatch = Stopwatch()..start();
    final obstaclesText = task.obstacles.map((o) => '(${o[0]},${o[1]})').join(', ');

    final prompt = '''
You are navigating a grid of width ${task.width} and height ${task.height}. Coordinates are (x, y), with (0,0) at the top-left. x increases rightward, y increases downward.
Obstacles you cannot move onto: $obstaclesText.
You start at (${task.start[0]}, ${task.start[1]}) and must reach (${task.goal[0]}, ${task.goal[1]}).
Respond with ONLY a JSON array of moves, each one of "up", "down", "left", "right", representing your full planned path from start to goal, avoiding obstacles and grid edges. No explanation, no markdown, just the JSON array. Example: ["right","right","down"]
''';

    String? rawContent;
    String? error;

    try {
      final response = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $apiKey'},
        body: jsonEncode({
          'model': _kGroqModel,
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.2,
        }),
      );

      if (response.statusCode != 200) {
        error = 'Groq API returned status ${response.statusCode}.';
      } else {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        rawContent = decoded['choices']?[0]?['message']?['content'] as String?;
      }
    } catch (e) {
      error = 'Network error calling Groq: ${e.toString()}';
    }

    if (error != null) {
      stopwatch.stop();
      return CognitiveRunResult(success: false, ticksUsed: 0, elapsedMs: stopwatch.elapsedMilliseconds, trainingSummary: error, trace: [], actionCommands: []);
    }

    List<String>? moves;
    try {
      final cleaned = _extractJsonArray(rawContent ?? '');
      moves = (jsonDecode(cleaned) as List<dynamic>).map((m) => m.toString().toLowerCase()).toList();
    } catch (e) {
      stopwatch.stop();
      return CognitiveRunResult(
        success: false,
        ticksUsed: 0,
        elapsedMs: stopwatch.elapsedMilliseconds,
        trainingSummary: 'Groq responded, but not with valid move JSON: "${rawContent ?? ''}"',
        trace: [],
        actionCommands: [],
      );
    }

    final trace = <TickSnapshot>[];
    var pos = [task.start[0], task.start[1]];
    var success = false;
    var tick = 0;

    for (final move in moves) {
      final delta = _deltaFor(move);
      if (delta == null) {
        tick++;
        continue;
      }
      final nx = pos[0] + delta[0];
      final ny = pos[1] + delta[1];
      if (task.inBounds(nx, ny) && !task.isObstacle(nx, ny)) {
        pos = [nx, ny];
      }
      trace.add(TickSnapshot(tick: tick, position: List<int>.from(pos), blackboard: {'move': move}));
      tick++;
      if (pos[0] == task.goal[0] && pos[1] == task.goal[1]) {
        success = true;
        break;
      }
      if (tick > 60) break;
    }

    stopwatch.stop();

    return CognitiveRunResult(
      success: success,
      ticksUsed: tick,
      elapsedMs: stopwatch.elapsedMilliseconds,
      trainingSummary: 'Groq ($_kGroqModel) planned ${moves.length} move(s) in one API call — no training phase, pure reasoning.',
      trace: trace,
      actionCommands: [],
    );
  }

  List<int>? _deltaFor(String move) {
    switch (move) {
      case 'up':
        return [0, -1];
      case 'down':
        return [0, 1];
      case 'left':
        return [-1, 0];
      case 'right':
        return [1, 0];
      default:
        return null;
    }
  }

  String _extractJsonArray(String text) {
    final start = text.indexOf('[');
    final end = text.lastIndexOf(']');
    if (start == -1 || end == -1 || end < start) throw const FormatException('No JSON array found');
    return text.substring(start, end + 1);
  }
}

// ============================================================
// COMPARISON MODELS
// ============================================================

enum CompetitorKind { savedSystem, groqLlm }

class Competitor {
  final CompetitorKind kind;
  final CognitiveSystem? system; // set when kind == savedSystem

  const Competitor({required this.kind, this.system});

  String get label => kind == CompetitorKind.groqLlm ? 'Groq LLM Agent' : (system?.name ?? 'Unknown');
}

class ComparisonOutcome {
  final Competitor competitor;
  final CognitiveRunResult result;

  const ComparisonOutcome({required this.competitor, required this.result});
}

// ============================================================
// CONTROLLER
// ============================================================

class ComparatorController extends ChangeNotifier {
  final CognitiveLabController systemsController;
  final CognitiveRunEngine _engine = CognitiveRunEngine();
  final GroqAgentRunner _groqRunner = GroqAgentRunner();

  bool _isRunning = false;
  ComparisonOutcome? _left;
  ComparisonOutcome? _right;

  ComparatorController(this.systemsController);

  bool get isRunning => _isRunning;
  ComparisonOutcome? get left => _left;
  ComparisonOutcome? get right => _right;

  Future<void> runComparison(Competitor a, Competitor b, GridWorldTask task, WebViewController jsController) async {
    _isRunning = true;
    _left = null;
    _right = null;
    notifyListeners();

    final resultA = await _runCompetitor(a, task, jsController);
    final resultB = await _runCompetitor(b, task, jsController);

    _left = ComparisonOutcome(competitor: a, result: resultA);
    _right = ComparisonOutcome(competitor: b, result: resultB);
    _isRunning = false;
    notifyListeners();
  }

  Future<CognitiveRunResult> _runCompetitor(Competitor c, GridWorldTask task, WebViewController jsController) {
    if (c.kind == CompetitorKind.groqLlm) return _groqRunner.run(task);
    return _engine.run(c.system!, task, jsController);
  }
}

// ============================================================
// SCREEN
// ============================================================

class ComparatorScreen extends StatefulWidget {
  const ComparatorScreen({super.key});

  @override
  State<ComparatorScreen> createState() => _ComparatorScreenState();
}

class _ComparatorScreenState extends State<ComparatorScreen> {
  late final CognitiveLabController _systemsController;
  late final ComparatorController _comparatorController;
  late final WebViewController _jsController;
  final GridWorldTask _task = GridWorldTask.starter();

  Competitor? _competitorA;
  Competitor? _competitorB;

  @override
  void initState() {
    super.initState();
    _systemsController = CognitiveLabController();
    _comparatorController = ComparatorController(_systemsController);
    _jsController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString('<html><body></body></html>');
    _systemsController.load();
  }

  @override
  void dispose() {
    _systemsController.dispose();
    _comparatorController.dispose();
    super.dispose();
  }

  List<Competitor> _availableCompetitors() {
    return [
      const Competitor(kind: CompetitorKind.groqLlm),
      ..._systemsController.systems.map((s) => Competitor(kind: CompetitorKind.savedSystem, system: s)),
    ];
  }

  Future<void> _run() async {
    if (_competitorA == null || _competitorB == null) return;
    await _comparatorController.runComparison(_competitorA!, _competitorB!, _task, _jsController);
  }

  Widget _competitorPicker(String label, Competitor? selected, ValueChanged<Competitor?> onChanged) {
    final options = _availableCompetitors();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        DropdownButton<int>(
          isExpanded: true,
          hint: const Text('Choose a competitor'),
          value: selected == null ? null : options.indexWhere((c) => c.label == selected.label && c.kind == selected.kind),
          items: List.generate(options.length, (i) => DropdownMenuItem(value: i, child: Text(options[i].label))),
          onChanged: (index) {
            if (index != null) onChanged(options[index]);
          },
        ),
      ],
    );
  }

  Widget _outcomeGrid(ComparisonOutcome? outcome) {
    if (outcome == null) {
      return Container(height: 140, alignment: Alignment.center, color: Colors.grey.shade100, child: const Text('No result yet'));
    }
    final finalPosition = outcome.result.trace.isNotEmpty ? outcome.result.trace.last.position : _task.start;
    return AspectRatio(
      aspectRatio: _task.width / _task.height,
      child: Column(
        children: List.generate(_task.height, (y) {
          return Expanded(
            child: Row(
              children: List.generate(_task.width, (x) {
                Color color = Colors.white;
                if (_task.isObstacle(x, y)) color = Colors.grey.shade700;
                if (x == _task.goal[0] && y == _task.goal[1]) color = Colors.green.shade300;
                if (x == finalPosition[0] && y == finalPosition[1]) color = Colors.blue;
                return Expanded(child: Container(margin: const EdgeInsets.all(1), color: color));
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget _outcomeStats(ComparisonOutcome? outcome) {
    if (outcome == null) return const SizedBox.shrink();
    final result = outcome.result;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(outcome.competitor.label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(result.success ? 'Reached goal in ${result.ticksUsed} ticks' : 'Did not reach goal (${result.ticksUsed} ticks)', style: TextStyle(color: result.success ? Colors.green.shade700 : Colors.orange.shade700, fontSize: 12)),
          Text('Time: ${result.elapsedMs}ms', style: const TextStyle(fontSize: 12)),
          if (result.trainingSummary.isNotEmpty) Text(result.trainingSummary, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comparator')),
      body: AnimatedBuilder(
        animation: Listenable.merge([_systemsController, _comparatorController]),
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Both competitors run on the exact same GridWorld task, measured the same way.', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _competitorPicker('Competitor A', _competitorA, (c) => setState(() => _competitorA = c))),
                  const SizedBox(width: 12),
                  Expanded(child: _competitorPicker('Competitor B', _competitorB, (c) => setState(() => _competitorB = c))),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: Text(_comparatorController.isRunning ? 'Running...' : 'Run Comparison'),
                  onPressed: (_competitorA == null || _competitorB == null || _comparatorController.isRunning) ? null : _run,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _outcomeGrid(_comparatorController.left),
                        _outcomeStats(_comparatorController.left),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        _outcomeGrid(_comparatorController.right),
                        _outcomeStats(_comparatorController.right),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
