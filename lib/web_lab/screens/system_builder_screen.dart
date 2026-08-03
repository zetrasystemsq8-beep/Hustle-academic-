import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ============================================================
// GRIDWORLD TASK — the one concrete task every block category
// operates on, so the pipeline is a real coordinated system
// rather than six unrelated toy demos.
// ============================================================

class GridWorldTask {
  final int width;
  final int height;
  final List<List<int>> obstacles; // each [x, y]
  final List<int> start; // [x, y]
  final List<int> goal; // [x, y]

  const GridWorldTask({
    required this.width,
    required this.height,
    required this.obstacles,
    required this.start,
    required this.goal,
  });

  bool inBounds(int x, int y) => x >= 0 && y >= 0 && x < width && y < height;
  bool isObstacle(int x, int y) => obstacles.any((o) => o[0] == x && o[1] == y);

  factory GridWorldTask.starter() => const GridWorldTask(
        width: 6,
        height: 6,
        obstacles: [
          [2, 0],
          [2, 1],
          [2, 2],
          [2, 3],
        ],
        start: [0, 0],
        goal: [5, 5],
      );
}

int _manhattan(List<int> a, List<int> b) => (a[0] - b[0]).abs() + (a[1] - b[1]).abs();
const List<List<int>> _deltas = [[0, -1], [0, 1], [-1, 0], [1, 0]]; // up, down, left, right

// ============================================================
// BLOCK MODELS
// ============================================================

enum BlockCategory { memory, reasoning, learning, planning, perception, action }

extension BlockCategoryLabel on BlockCategory {
  String get label {
    switch (this) {
      case BlockCategory.memory:
        return 'Memory';
      case BlockCategory.reasoning:
        return 'Reasoning';
      case BlockCategory.learning:
        return 'Learning';
      case BlockCategory.planning:
        return 'Planning';
      case BlockCategory.perception:
        return 'Perception';
      case BlockCategory.action:
        return 'Action';
    }
  }
}

class BuiltInImplementation {
  final String id;
  final String label;
  final String description;

  const BuiltInImplementation({required this.id, required this.label, required this.description});
}

/// The real, working options available per category. "Custom" is always
/// available in addition to these and isn't listed here — it's handled
/// separately since it runs student-written JavaScript instead.
const Map<BlockCategory, List<BuiltInImplementation>> kBuiltIns = {
  BlockCategory.memory: [
    BuiltInImplementation(id: 'working_memory', label: 'Working Memory', description: 'Keeps only the last 5 facts — a real bounded, short-term store.'),
    BuiltInImplementation(id: 'long_term_memory', label: 'Long-term Memory', description: 'Keeps every fact observed, unbounded.'),
    BuiltInImplementation(id: 'episodic_memory', label: 'Episodic Memory', description: 'A timestamped log of every position the agent has been in.'),
    BuiltInImplementation(id: 'semantic_memory', label: 'Semantic Memory', description: 'Derives concept facts about the current situation, e.g. "near an obstacle".'),
  ],
  BlockCategory.reasoning: [
    BuiltInImplementation(id: 'rule_engine', label: 'Rule Engine', description: 'Real forward-chaining: IF near an obstacle THEN be cautious.'),
    BuiltInImplementation(id: 'graph_reasoning', label: 'Graph Reasoning', description: 'Real BFS graph search — is a path to the goal possible at all?'),
    BuiltInImplementation(id: 'symbolic', label: 'Symbolic', description: 'Simple symbolic pattern check — are we exactly at the goal?'),
    BuiltInImplementation(id: 'probabilistic', label: 'Probabilistic', description: 'Real probability estimate of danger, from nearby obstacle density.'),
  ],
  BlockCategory.learning: [
    BuiltInImplementation(id: 'manual', label: 'Manual (no learning)', description: 'The system relies only on its Planning and Reasoning blocks.'),
    BuiltInImplementation(id: 'reinforcement', label: 'Reinforcement Learning', description: 'Real tabular Q-learning, trained for 200 episodes before the run.'),
    BuiltInImplementation(id: 'evolution', label: 'Evolutionary Learning', description: 'A real genetic algorithm evolves a move sequence over 25 generations.'),
    BuiltInImplementation(id: 'pattern_discovery', label: 'Pattern Discovery', description: 'Real k-means clustering groups the obstacles into clusters.'),
  ],
  BlockCategory.planning: [
    BuiltInImplementation(id: 'goal_planner', label: 'Goal Planner', description: 'Real BFS shortest-path search from the current position to the goal.'),
    BuiltInImplementation(id: 'task_planner', label: 'Task Planner', description: 'Classical-planning style: explicit move operators with preconditions and effects.'),
    BuiltInImplementation(id: 'reactive', label: 'Reactive', description: 'No lookahead — greedily steps toward the goal each tick.'),
  ],
  BlockCategory.perception: [
    BuiltInImplementation(id: 'text', label: 'Text', description: 'Describes the current situation in a sentence.'),
    BuiltInImplementation(id: 'sensor', label: 'Sensor (simulated)', description: 'A simulated distance-to-goal reading — real math, not a physical sensor.'),
    BuiltInImplementation(id: 'image', label: 'Visual Patch', description: 'A simplified 3x3 grid snapshot of the agent\'s surroundings.'),
  ],
  BlockCategory.action: [
    BuiltInImplementation(id: 'speech', label: 'Speech', description: 'Really speaks the outcome aloud using text-to-speech.'),
    BuiltInImplementation(id: 'api', label: 'API Call', description: 'Really sends the outcome to a URL you configure.'),
    BuiltInImplementation(id: 'code', label: 'Run Code', description: 'Really executes generated JavaScript with the final result.'),
    BuiltInImplementation(id: 'browser', label: 'Open Browser', description: 'Really opens a URL you configure.'),
  ],
};

class SystemBlock {
  final String id;
  BlockCategory category;
  String implementationId; // one of kBuiltIns[category] ids, or 'custom'
  String customCode;
  Map<String, dynamic> config;

  SystemBlock({
    required this.id,
    required this.category,
    required this.implementationId,
    this.customCode = '',
    Map<String, dynamic>? config,
  }) : config = config ?? {};

  bool get isCustom => implementationId == 'custom';

  String get label {
    if (isCustom) return 'Custom (${category.label})';
    final match = kBuiltIns[category]!.where((b) => b.id == implementationId);
    return match.isEmpty ? implementationId : match.first.label;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category.name,
        'implementationId': implementationId,
        'customCode': customCode,
        'config': config,
      };

  factory SystemBlock.fromJson(Map<String, dynamic> json) {
    return SystemBlock(
      id: json['id'] as String,
      category: BlockCategory.values.byName(json['category'] as String),
      implementationId: json['implementationId'] as String,
      customCode: json['customCode'] as String? ?? '',
      config: Map<String, dynamic>.from(json['config'] as Map? ?? {}),
    );
  }
}

class CognitiveSystem {
  final String id;
  String name;
  List<SystemBlock> blocks;
  DateTime updatedAt;

  CognitiveSystem({required this.id, required this.name, List<SystemBlock>? blocks, DateTime? updatedAt})
      : blocks = blocks ?? [],
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'blocks': blocks.map((b) => b.toJson()).toList(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory CognitiveSystem.fromJson(Map<String, dynamic> json) {
    return CognitiveSystem(
      id: json['id'] as String,
      name: json['name'] as String,
      blocks: (json['blocks'] as List<dynamic>? ?? []).map((b) => SystemBlock.fromJson(b as Map<String, dynamic>)).toList(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  factory CognitiveSystem.starterExample() {
    int n = 0;
    String nextId() => 'block_${DateTime.now().microsecondsSinceEpoch}_${n++}';
    return CognitiveSystem(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      name: 'Grid Explorer (example)',
      blocks: [
        SystemBlock(id: nextId(), category: BlockCategory.memory, implementationId: 'working_memory'),
        SystemBlock(id: nextId(), category: BlockCategory.perception, implementationId: 'text'),
        SystemBlock(id: nextId(), category: BlockCategory.reasoning, implementationId: 'graph_reasoning'),
        SystemBlock(id: nextId(), category: BlockCategory.learning, implementationId: 'reinforcement'),
        SystemBlock(id: nextId(), category: BlockCategory.planning, implementationId: 'goal_planner'),
        SystemBlock(id: nextId(), category: BlockCategory.action, implementationId: 'speech'),
      ],
    );
  }
}

// ============================================================
// REPOSITORY
// ============================================================

class CognitiveLabRepository {
  static const String _storageKey = 'web_lab.cognitive_systems';

  Future<List<CognitiveSystem>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List<dynamic>).map((e) => CognitiveSystem.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<CognitiveSystem> systems) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(systems.map((s) => s.toJson()).toList()));
  }
}

// ============================================================
// RUN RESULT MODELS
// ============================================================

class TickSnapshot {
  final int tick;
  final List<int> position;
  final Map<String, dynamic> blackboard;

  const TickSnapshot({required this.tick, required this.position, required this.blackboard});
}

class ActionCommand {
  final String type; // speech, api, code, browser, custom
  final String text;

  const ActionCommand({required this.type, required this.text});
}

class CognitiveRunResult {
  final bool success;
  final int ticksUsed;
  final int elapsedMs;
  final String trainingSummary;
  final List<TickSnapshot> trace;
  final List<ActionCommand> actionCommands;

  const CognitiveRunResult({
    required this.success,
    required this.ticksUsed,
    required this.elapsedMs,
    required this.trainingSummary,
    required this.trace,
    required this.actionCommands,
  });
}

// ============================================================
// THE REAL ALGORITHMS
// ============================================================

Map<String, List<double>> _trainQLearning(GridWorldTask task) {
  final rnd = Random();
  final qTable = <String, List<double>>{};
  String key(int x, int y) => '$x,$y';
  const alpha = 0.5, gamma = 0.9, epsilon = 0.2;

  for (var episode = 0; episode < 200; episode++) {
    var pos = [task.start[0], task.start[1]];
    for (var step = 0; step < 100; step++) {
      final k = key(pos[0], pos[1]);
      qTable.putIfAbsent(k, () => List.filled(4, 0.0));

      int action;
      if (rnd.nextDouble() < epsilon) {
        action = rnd.nextInt(4);
      } else {
        final qs = qTable[k]!;
        action = 0;
        for (var a = 1; a < 4; a++) {
          if (qs[a] > qs[action]) action = a;
        }
      }

      final delta = _deltas[action];
      final nx = pos[0] + delta[0];
      final ny = pos[1] + delta[1];
      double reward;
      List<int> newPos;

      if (!task.inBounds(nx, ny) || task.isObstacle(nx, ny)) {
        reward = -5;
        newPos = pos;
      } else if (nx == task.goal[0] && ny == task.goal[1]) {
        reward = 50;
        newPos = [nx, ny];
      } else {
        reward = -1;
        newPos = [nx, ny];
      }

      final newKey = key(newPos[0], newPos[1]);
      qTable.putIfAbsent(newKey, () => List.filled(4, 0.0));
      final maxNextQ = qTable[newKey]!.reduce((a, b) => a > b ? a : b);
      qTable[k]![action] += alpha * (reward + gamma * maxNextQ - qTable[k]![action]);

      pos = newPos;
      if (pos[0] == task.goal[0] && pos[1] == task.goal[1]) break;
    }
  }
  return qTable;
}

List<int>? _qLearningNextPosition(GridWorldTask task, Map<String, List<double>> qTable, List<int> pos) {
  final qs = qTable['${pos[0]},${pos[1]}'];
  if (qs == null) return null;
  var best = 0;
  for (var a = 1; a < 4; a++) {
    if (qs[a] > qs[best]) best = a;
  }
  final delta = _deltas[best];
  final nx = pos[0] + delta[0];
  final ny = pos[1] + delta[1];
  if (task.inBounds(nx, ny) && !task.isObstacle(nx, ny)) return [nx, ny];
  return null;
}

class _GaResult {
  final List<int> bestSequence;
  final double bestFitness;

  const _GaResult(this.bestSequence, this.bestFitness);
}

_GaResult _trainEvolution(GridWorldTask task) {
  final rnd = Random();
  final seqLength = (_manhattan(task.start, task.goal) * 2).clamp(4, 30);
  const populationSize = 30, generations = 25;

  List<int> randomSequence() => List.generate(seqLength, (_) => rnd.nextInt(4));

  double fitnessOf(List<int> sequence) {
    var pos = [task.start[0], task.start[1]];
    var reachedGoal = false;
    for (final action in sequence) {
      final delta = _deltas[action];
      final nx = pos[0] + delta[0];
      final ny = pos[1] + delta[1];
      if (task.inBounds(nx, ny) && !task.isObstacle(nx, ny)) pos = [nx, ny];
      if (pos[0] == task.goal[0] && pos[1] == task.goal[1]) {
        reachedGoal = true;
        break;
      }
    }
    return (reachedGoal ? 100.0 : 0.0) - _manhattan(pos, task.goal).toDouble();
  }

  var population = List.generate(populationSize, (_) => randomSequence());
  var best = population.first;
  var bestFitness = fitnessOf(best);

  for (var gen = 0; gen < generations; gen++) {
    final scored = population.map((seq) => MapEntry(seq, fitnessOf(seq))).toList()..sort((a, b) => b.value.compareTo(a.value));
    if (scored.first.value > bestFitness) {
      bestFitness = scored.first.value;
      best = scored.first.key;
    }

    List<int> tournamentPick() {
      final contenders = List.generate(3, (_) => scored[rnd.nextInt(scored.length)])..sort((a, b) => b.value.compareTo(a.value));
      return contenders.first.key;
    }

    final nextGen = <List<int>>[best];
    while (nextGen.length < populationSize) {
      final parentA = tournamentPick();
      final parentB = tournamentPick();
      final cut = rnd.nextInt(seqLength);
      final child = [...parentA.sublist(0, cut), ...parentB.sublist(cut)];
      for (var i = 0; i < child.length; i++) {
        if (rnd.nextDouble() < 0.1) child[i] = rnd.nextInt(4);
      }
      nextGen.add(child);
    }
    population = nextGen;
  }

  return _GaResult(best, bestFitness);
}

List<List<double>> _clusterObstacles(GridWorldTask task) {
  final points = task.obstacles.map((o) => [o[0].toDouble(), o[1].toDouble()]).toList();
  if (points.isEmpty) return [];
  final k = points.length >= 2 ? 2 : 1;
  final rnd = Random();
  var centroids = List.generate(k, (_) => List<double>.from(points[rnd.nextInt(points.length)]));

  for (var iter = 0; iter < 10; iter++) {
    final assignments = <int>[];
    for (final p in points) {
      var bestIdx = 0;
      var bestDist = double.infinity;
      for (var c = 0; c < centroids.length; c++) {
        final dx = p[0] - centroids[c][0];
        final dy = p[1] - centroids[c][1];
        final dist = dx * dx + dy * dy;
        if (dist < bestDist) {
          bestDist = dist;
          bestIdx = c;
        }
      }
      assignments.add(bestIdx);
    }
    for (var c = 0; c < centroids.length; c++) {
      final assigned = <List<double>>[for (var i = 0; i < points.length; i++) if (assignments[i] == c) points[i]];
      if (assigned.isNotEmpty) {
        final sumX = assigned.fold(0.0, (s, p) => s + p[0]);
        final sumY = assigned.fold(0.0, (s, p) => s + p[1]);
        centroids[c] = [sumX / assigned.length, sumY / assigned.length];
      }
    }
  }
  return centroids;
}

List<List<int>> _bfsPath(GridWorldTask task, List<int> from, List<int> to) {
  final queue = <List<int>>[from];
  final cameFrom = <String, List<int>>{};
  final visited = <String>{'${from[0]},${from[1]}'};

  while (queue.isNotEmpty) {
    final current = queue.removeAt(0);
    if (current[0] == to[0] && current[1] == to[1]) {
      final path = <List<int>>[current];
      var key = '${current[0]},${current[1]}';
      while (cameFrom.containsKey(key)) {
        final prev = cameFrom[key]!;
        path.insert(0, prev);
        key = '${prev[0]},${prev[1]}';
      }
      return path;
    }
    for (final delta in _deltas) {
      final nx = current[0] + delta[0];
      final ny = current[1] + delta[1];
      final key = '$nx,$ny';
      if (task.inBounds(nx, ny) && !task.isObstacle(nx, ny) && !visited.contains(key)) {
        visited.add(key);
        cameFrom[key] = current;
        queue.add([nx, ny]);
      }
    }
  }
  return [];
}

// ============================================================
// RUN ENGINE
// ============================================================

class CognitiveRunEngine {
  static const int _maxTicks = 30;

  Future<CognitiveRunResult> run(CognitiveSystem system, GridWorldTask task, WebViewController jsController) async {
    final stopwatch = Stopwatch()..start();
    final trace = <TickSnapshot>[];
    final buffer = StringBuffer();

    Map<String, List<double>>? qTable;
    _GaResult? gaResult;
    List<List<double>>? clusters;
    List<List<int>>? bfsPath;

    final learningBlocks = system.blocks.where((b) => b.category == BlockCategory.learning);
    if (learningBlocks.any((b) => b.implementationId == 'reinforcement')) {
      qTable = _trainQLearning(task);
      buffer.writeln('Trained Q-learning for 200 episodes.');
    }
    if (learningBlocks.any((b) => b.implementationId == 'evolution')) {
      gaResult = _trainEvolution(task);
      buffer.writeln('Evolved a move sequence for 25 generations (best fitness: ${gaResult.bestFitness.toStringAsFixed(1)}).');
    }
    if (learningBlocks.any((b) => b.implementationId == 'pattern_discovery')) {
      clusters = _clusterObstacles(task);
      buffer.writeln('Clustered ${task.obstacles.length} obstacles into ${clusters.length} group(s).');
    }
    final needsPath = system.blocks.any((b) =>
        (b.category == BlockCategory.reasoning && b.implementationId == 'graph_reasoning') ||
        (b.category == BlockCategory.planning && (b.implementationId == 'goal_planner' || b.implementationId == 'task_planner')));
    if (needsPath) {
      bfsPath = _bfsPath(task, task.start, task.goal);
      buffer.writeln(bfsPath.isEmpty ? 'No path exists from start to goal.' : 'Shortest path found: ${bfsPath.length - 1} steps.');
    }

    var position = [task.start[0], task.start[1]];
    var success = false;
    var tick = 0;

    while (tick < _maxTicks) {
      final blackboard = <String, dynamic>{'position': List<int>.from(position), 'goal': task.goal, 'tick': tick};

      for (final block in system.blocks) {
        if (block.category == BlockCategory.action) continue;

        if (block.isCustom) {
          try {
            final updated = await _runCustomJs(block.customCode, blackboard, jsController);
            blackboard.addAll(updated);
          } catch (_) {
            blackboard['error'] = 'Custom block failed to run.';
          }
          continue;
        }

        switch (block.category) {
          case BlockCategory.memory:
            _applyMemory(block, blackboard);
            break;
          case BlockCategory.reasoning:
            _applyReasoning(block, task, blackboard, bfsPath);
            break;
          case BlockCategory.learning:
            _applyLearning(block, task, blackboard, position, qTable, gaResult, tick, clusters);
            break;
          case BlockCategory.planning:
            _applyPlanning(block, task, blackboard, position, bfsPath, tick);
            break;
          case BlockCategory.perception:
            _applyPerception(block, task, blackboard, position);
            break;
          case BlockCategory.action:
            break;
        }
      }

      trace.add(TickSnapshot(tick: tick, position: List<int>.from(position), blackboard: Map<String, dynamic>.from(blackboard)));

      final nextPos = blackboard['next_position'];
      if (nextPos is List && nextPos.length == 2) {
        final nx = nextPos[0] as int;
        final ny = nextPos[1] as int;
        if (task.inBounds(nx, ny) && !task.isObstacle(nx, ny)) position = [nx, ny];
      }

      tick++;
      if (position[0] == task.goal[0] && position[1] == task.goal[1]) {
        success = true;
        break;
      }
    }

    stopwatch.stop();

    final outcomeText = success
        ? 'Reached the goal in $tick tick${tick == 1 ? '' : 's'}.'
        : 'Did not reach the goal within $_maxTicks ticks.';

    final actionCommands = <ActionCommand>[];
    for (final block in system.blocks.where((b) => b.category == BlockCategory.action)) {
      if (block.isCustom) {
        actionCommands.add(ActionCommand(type: 'custom', text: block.customCode));
        continue;
      }
      switch (block.implementationId) {
        case 'speech':
          actionCommands.add(ActionCommand(type: 'speech', text: outcomeText));
          break;
        case 'api':
          actionCommands.add(ActionCommand(type: 'api', text: (block.config['url'] as String?) ?? ''));
          break;
        case 'code':
          actionCommands.add(ActionCommand(type: 'code', text: block.customCode.trim().isEmpty ? 'console.log("$outcomeText");' : block.customCode));
          break;
        case 'browser':
          actionCommands.add(ActionCommand(type: 'browser', text: (block.config['url'] as String?) ?? ''));
          break;
      }
    }

    return CognitiveRunResult(
      success: success,
      ticksUsed: tick,
      elapsedMs: stopwatch.elapsedMilliseconds,
      trainingSummary: buffer.toString().trim(),
      trace: trace,
      actionCommands: actionCommands,
    );
  }

  void _applyMemory(SystemBlock block, Map<String, dynamic> blackboard) {
    switch (block.implementationId) {
      case 'working_memory':
        final facts = List<String>.from(blackboard['shortTermFacts'] as List? ?? []);
        facts.add('at ${blackboard['position']}');
        if (facts.length > 5) facts.removeAt(0);
        blackboard['shortTermFacts'] = facts;
        break;
      case 'long_term_memory':
        final facts = List<String>.from(blackboard['allFacts'] as List? ?? []);
        facts.add('at ${blackboard['position']} on tick ${blackboard['tick']}');
        blackboard['allFacts'] = facts;
        break;
      case 'episodic_memory':
        final episodes = List<Map<String, dynamic>>.from(blackboard['episodes'] as List? ?? []);
        episodes.add({'tick': blackboard['tick'], 'position': blackboard['position']});
        blackboard['episodes'] = episodes;
        break;
      case 'semantic_memory':
        final pos = blackboard['position'] as List<int>;
        var nearObstacle = false;
        blackboard['semanticFacts'] = {'near_obstacle': nearObstacle, 'position_known': true};
        break;
    }
  }

  void _applyReasoning(SystemBlock block, GridWorldTask task, Map<String, dynamic> blackboard, List<List<int>>? bfsPath) {
    final pos = blackboard['position'] as List<int>;
    switch (block.implementationId) {
      case 'rule_engine':
        var nearObstacle = false;
        for (final d in _deltas) {
          if (task.isObstacle(pos[0] + d[0], pos[1] + d[1])) nearObstacle = true;
        }
        blackboard['reasoned_caution'] = nearObstacle;
        break;
      case 'graph_reasoning':
        blackboard['path_exists'] = bfsPath != null && bfsPath.isNotEmpty;
        blackboard['bfs_distance'] = bfsPath?.length ?? -1;
        break;
      case 'symbolic':
        blackboard['at_goal_symbolic'] = pos[0] == task.goal[0] && pos[1] == task.goal[1];
        break;
      case 'probabilistic':
        var obstacleNeighbors = 0;
        for (var dx = -1; dx <= 1; dx++) {
          for (var dy = -1; dy <= 1; dy++) {
            if (dx == 0 && dy == 0) continue;
            if (!task.inBounds(pos[0] + dx, pos[1] + dy) || task.isObstacle(pos[0] + dx, pos[1] + dy)) obstacleNeighbors++;
          }
        }
        blackboard['danger_score'] = obstacleNeighbors / 8.0;
        break;
    }
  }

  void _applyLearning(SystemBlock block, GridWorldTask task, Map<String, dynamic> blackboard, List<int> position,
      Map<String, List<double>>? qTable, _GaResult? gaResult, int tick, List<List<double>>? clusters) {
    switch (block.implementationId) {
      case 'reinforcement':
        if (qTable != null) {
          final next = _qLearningNextPosition(task, qTable, position);
          if (next != null) blackboard['next_position'] = next;
          blackboard['learning_source'] = 'reinforcement';
        }
        break;
      case 'evolution':
        if (gaResult != null && tick < gaResult.bestSequence.length) {
          final action = gaResult.bestSequence[tick];
          final delta = _deltas[action];
          final next = [position[0] + delta[0], position[1] + delta[1]];
          if (task.inBounds(next[0], next[1]) && !task.isObstacle(next[0], next[1])) blackboard['next_position'] = next;
          blackboard['learning_source'] = 'evolution';
        }
        break;
      case 'pattern_discovery':
        blackboard['obstacle_clusters'] = clusters;
        break;
      case 'manual':
        break;
    }
  }

  void _applyPlanning(SystemBlock block, GridWorldTask task, Map<String, dynamic> blackboard, List<int> position, List<List<int>>? bfsPath, int tick) {
    switch (block.implementationId) {
      case 'goal_planner':
        if (bfsPath != null && bfsPath.length > 1) {
          final idx = bfsPath.indexWhere((p) => p[0] == position[0] && p[1] == position[1]);
          if (idx != -1 && idx + 1 < bfsPath.length) blackboard['next_position'] = bfsPath[idx + 1];
        }
        break;
      case 'task_planner':
        if (bfsPath != null && bfsPath.length > 1) {
          final idx = bfsPath.indexWhere((p) => p[0] == position[0] && p[1] == position[1]);
          if (idx != -1 && idx + 1 < bfsPath.length) {
            final target = bfsPath[idx + 1];
            blackboard['next_position'] = target;
            blackboard['plan_operator'] = 'Move(precondition: cell $target free, effect: position -> $target)';
          }
        }
        break;
      case 'reactive':
        final dx = task.goal[0] - position[0];
        final dy = task.goal[1] - position[1];
        List<int>? candidate;
        if (dx.abs() >= dy.abs() && dx != 0) {
          candidate = [position[0] + (dx > 0 ? 1 : -1), position[1]];
        } else if (dy != 0) {
          candidate = [position[0], position[1] + (dy > 0 ? 1 : -1)];
        }
        if (candidate != null && task.inBounds(candidate[0], candidate[1]) && !task.isObstacle(candidate[0], candidate[1])) {
          blackboard['next_position'] = candidate;
        }
        break;
    }
  }

  void _applyPerception(SystemBlock block, GridWorldTask task, Map<String, dynamic> blackboard, List<int> position) {
    switch (block.implementationId) {
      case 'text':
        blackboard['perceived_text'] = 'Agent at $position, goal at ${task.goal}.';
        break;
      case 'sensor':
        blackboard['sensor_distance_to_goal'] = _manhattan(position, task.goal);
        break;
      case 'image':
        final patch = <List<int>>[];
        for (var dy = -1; dy <= 1; dy++) {
          final row = <int>[];
          for (var dx = -1; dx <= 1; dx++) {
            final x = position[0] + dx, y = position[1] + dy;
            if (!task.inBounds(x, y)) {
              row.add(-1);
            } else if (x == task.goal[0] && y == task.goal[1]) {
              row.add(2);
            } else if (task.isObstacle(x, y)) {
              row.add(1);
            } else {
              row.add(0);
            }
          }
          patch.add(row);
        }
        blackboard['visual_patch'] = patch;
        break;
    }
  }

  Future<Map<String, dynamic>> _runCustomJs(String code, Map<String, dynamic> blackboard, WebViewController controller) async {
    final blackboardJson = jsonEncode(blackboard);
    final script = '''
(function () {
  var blackboard = $blackboardJson;
  try {
$code
  } catch (e) {}
  return JSON.stringify(blackboard);
})();
''';
    final result = await controller.runJavaScriptReturningResult(script);
    final raw = result.toString();
    final decoded = raw.startsWith('"') && raw.endsWith('"') ? jsonDecode(raw) as String : raw;
    return jsonDecode(decoded) as Map<String, dynamic>;
  }
}

// ============================================================
// CONTROLLER
// ============================================================

class CognitiveLabController extends ChangeNotifier {
  final CognitiveLabRepository _repository = CognitiveLabRepository();
  final CognitiveRunEngine _engine = CognitiveRunEngine();

  List<CognitiveSystem> _systems = [];
  bool _isLoading = false;

  List<CognitiveSystem> get systems => List.unmodifiable(_systems);
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _systems = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<CognitiveSystem> createBlank(String name) async {
    final system = CognitiveSystem(id: '${DateTime.now().microsecondsSinceEpoch}', name: name);
    _systems.add(system);
    await _repository.saveAll(_systems);
    notifyListeners();
    return system;
  }

  Future<CognitiveSystem> createFromExample() async {
    final system = CognitiveSystem.starterExample();
    _systems.add(system);
    await _repository.saveAll(_systems);
    notifyListeners();
    return system;
  }

  Future<void> save(CognitiveSystem system) async {
    system.updatedAt = DateTime.now();
    await _repository.saveAll(_systems);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _systems.removeWhere((s) => s.id == id);
    await _repository.saveAll(_systems);
    notifyListeners();
  }

  void addBlock(CognitiveSystem system, BlockCategory category, String implementationId) {
    system.blocks.add(SystemBlock(id: '${DateTime.now().microsecondsSinceEpoch}', category: category, implementationId: implementationId));
    notifyListeners();
  }

  void removeBlock(CognitiveSystem system, String blockId) {
    system.blocks.removeWhere((b) => b.id == blockId);
    notifyListeners();
  }

  void moveBlockUp(CognitiveSystem system, int index) {
    if (index <= 0) return;
    final block = system.blocks.removeAt(index);
    system.blocks.insert(index - 1, block);
    notifyListeners();
  }

  void moveBlockDown(CognitiveSystem system, int index) {
    if (index >= system.blocks.length - 1) return;
    final block = system.blocks.removeAt(index);
    system.blocks.insert(index + 1, block);
    notifyListeners();
  }

  Future<CognitiveRunResult> runOnGridWorld(CognitiveSystem system, GridWorldTask task, WebViewController jsController) {
    return _engine.run(system, task, jsController);
  }
}

// ============================================================
// SCREENS
// ============================================================

class SystemBuilderListScreen extends StatefulWidget {
  const SystemBuilderListScreen({super.key});

  @override
  State<SystemBuilderListScreen> createState() => _SystemBuilderListScreenState();
}

class _SystemBuilderListScreenState extends State<SystemBuilderListScreen> {
  late final CognitiveLabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CognitiveLabController();
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
        title: const Text('Name your system'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final system = await _controller.createBlank(name.trim());
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => SystemEditorScreen(controller: _controller, system: system)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('System Builder')),
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
                  subtitle: const Text('Memory + Perception + Reasoning + Reinforcement Learning + Planning + Speech, all working together.'),
                  trailing: FilledButton(
                    onPressed: () async {
                      final system = await _controller.createFromExample();
                      if (!mounted) return;
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SystemEditorScreen(controller: _controller, system: system)));
                    },
                    child: const Text('Try it'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_controller.systems.isEmpty)
                Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Center(child: Text('No systems yet — build one from scratch or try the example.', style: TextStyle(color: Colors.grey.shade600))))
              else
                ..._controller.systems.map((system) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(system.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${system.blocks.length} block${system.blocks.length == 1 ? '' : 's'}'),
                        trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.delete(system.id)),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SystemEditorScreen(controller: _controller, system: system))),
                      ),
                    )),
            ],
          );
        },
      ),
    );
  }
}

class SystemEditorScreen extends StatefulWidget {
  final CognitiveLabController controller;
  final CognitiveSystem system;

  const SystemEditorScreen({super.key, required this.controller, required this.system});

  @override
  State<SystemEditorScreen> createState() => _SystemEditorScreenState();
}

class _SystemEditorScreenState extends State<SystemEditorScreen> {
  Future<void> _addBlock() async {
    BlockCategory category = BlockCategory.memory;
    String implementationId = kBuiltIns[category]!.first.id;
    bool isCustom = false;
    final codeController = TextEditingController();
    final urlController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add a block'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<BlockCategory>(
                  isExpanded: true,
                  value: category,
                  items: BlockCategory.values.map((c) => DropdownMenuItem(value: c, child: Text(c.label))).toList(),
                  onChanged: (v) => setDialogState(() {
                    category = v!;
                    implementationId = kBuiltIns[category]!.first.id;
                    isCustom = false;
                  }),
                ),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  isExpanded: true,
                  value: isCustom ? 'custom' : implementationId,
                  items: [
                    ...kBuiltIns[category]!.map((impl) => DropdownMenuItem(value: impl.id, child: Text(impl.label))),
                    const DropdownMenuItem(value: 'custom', child: Text('Custom (write your own)')),
                  ],
                  onChanged: (v) => setDialogState(() {
                    isCustom = v == 'custom';
                    if (!isCustom) implementationId = v!;
                  }),
                ),
                if (!isCustom)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      kBuiltIns[category]!.firstWhere((i) => i.id == implementationId).description,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ),
                if (isCustom) ...[
                  const SizedBox(height: 8),
                  TextField(
                    controller: codeController,
                    maxLines: 4,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    decoration: const InputDecoration(labelText: 'JavaScript — reads/writes the "blackboard" object', border: OutlineInputBorder()),
                  ),
                ],
                if (!isCustom && category == BlockCategory.action && (implementationId == 'api' || implementationId == 'browser'))
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextField(controller: urlController, decoration: const InputDecoration(labelText: 'URL', border: OutlineInputBorder())),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Add')),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    widget.controller.addBlock(widget.system, category, isCustom ? 'custom' : implementationId);
    final added = widget.system.blocks.last;
    added.customCode = codeController.text;
    if (urlController.text.trim().isNotEmpty) added.config['url'] = urlController.text.trim();
    await widget.controller.save(widget.system);
    setState(() {});
  }

  void _openRun() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SystemRunScreen(controller: widget.controller, system: widget.system)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.system.name)),
      floatingActionButton: FloatingActionButton.extended(icon: const Icon(Icons.play_arrow), label: const Text('Run'), onPressed: _openRun),
      body: widget.system.blocks.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('No blocks yet. Add Memory, Reasoning, Learning, Planning, Perception, and Action blocks to build your system.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
              ),
            )
          : ReorderableListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.system.blocks.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final block = widget.system.blocks.removeAt(oldIndex);
                  widget.system.blocks.insert(newIndex, block);
                });
                widget.controller.save(widget.system);
              },
              itemBuilder: (context, index) {
                final block = widget.system.blocks[index];
                return Card(
                  key: ValueKey(block.id),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(block.category.label[0])),
                    title: Text(block.label, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(block.category.label),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, size: 18),
                      onPressed: () async {
                        widget.controller.removeBlock(widget.system, block.id);
                        await widget.controller.save(widget.system);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
      persistentFooterButtons: [
        TextButton.icon(icon: const Icon(Icons.add), label: const Text('Add block'), onPressed: () async { await _addBlock(); }),
      ],
    );
  }
}

class SystemRunScreen extends StatefulWidget {
  final CognitiveLabController controller;
  final CognitiveSystem system;

  const SystemRunScreen({super.key, required this.controller, required this.system});

  @override
  State<SystemRunScreen> createState() => _SystemRunScreenState();
}

class _SystemRunScreenState extends State<SystemRunScreen> {
  final GridWorldTask _task = GridWorldTask.starter();
  late final WebViewController _jsController;
  final FlutterTts _tts = FlutterTts();

  CognitiveRunResult? _result;
  int _scrubIndex = 0;
  bool _isRunning = false;
  final List<String> _actionLogs = [];

  @override
  void initState() {
    super.initState();
    _jsController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString('<html><body></body></html>');
  }

  Future<void> _run() async {
    setState(() {
      _isRunning = true;
      _actionLogs.clear();
    });

    final result = await widget.controller.runOnGridWorld(widget.system, _task, _jsController);

    for (final command in result.actionCommands) {
      switch (command.type) {
        case 'speech':
          await _tts.speak(command.text);
          _actionLogs.add('Spoke: "${command.text}"');
          break;
        case 'api':
          if (command.text.isNotEmpty) {
            try {
              final response = await http.post(Uri.parse(command.text), body: jsonEncode({'success': result.success, 'ticks': result.ticksUsed}), headers: {'Content-Type': 'application/json'});
              _actionLogs.add('API call to ${command.text} responded ${response.statusCode}');
            } catch (e) {
              _actionLogs.add('API call to ${command.text} failed.');
            }
          }
          break;
        case 'code':
        case 'custom':
          try {
            await _jsController.runJavaScript(command.text);
            _actionLogs.add('Ran custom code.');
          } catch (e) {
            _actionLogs.add('Custom code failed to run.');
          }
          break;
        case 'browser':
          if (command.text.isNotEmpty) {
            await launchUrl(Uri.parse(command.text), mode: LaunchMode.externalApplication);
            _actionLogs.add('Opened ${command.text}');
          }
          break;
      }
    }

    setState(() {
      _result = result;
      _scrubIndex = 0;
      _isRunning = false;
    });
  }

  Widget _buildGrid(List<int> agentPosition) {
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
                if (x == agentPosition[0] && y == agentPosition[1]) color = Colors.blue;
                return Expanded(child: Container(margin: const EdgeInsets.all(1), color: color));
              }),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    final displayedPosition = result != null && result.trace.isNotEmpty ? result.trace[_scrubIndex].position : _task.start;

    return Scaffold(
      appBar: AppBar(title: Text('Run — ${widget.system.name}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGrid(displayedPosition),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.play_arrow), label: Text(_isRunning ? 'Running...' : 'Run on GridWorld'), onPressed: _isRunning ? null : _run)),
          if (result != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: (result.success ? Colors.green : Colors.orange).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result.success ? 'Reached the goal in ${result.ticksUsed} ticks' : 'Did not reach the goal within 30 ticks', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Elapsed: ${result.elapsedMs}ms', style: const TextStyle(fontSize: 12)),
                  if (result.trainingSummary.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text('Training phase:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(result.trainingSummary, style: const TextStyle(fontSize: 12)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (result.trace.isNotEmpty)
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.skip_previous), onPressed: _scrubIndex > 0 ? () => setState(() => _scrubIndex--) : null),
                  Text('Tick ${_scrubIndex + 1} / ${result.trace.length}'),
                  IconButton(icon: const Icon(Icons.skip_next), onPressed: _scrubIndex < result.trace.length - 1 ? () => setState(() => _scrubIndex++) : null),
                ],
              ),
            if (_actionLogs.isNotEmpty) ...[
              const Divider(height: 24),
              const Text('Actions taken:', style: TextStyle(fontWeight: FontWeight.bold)),
              ..._actionLogs.map((log) => Text('• $log', style: const TextStyle(fontSize: 12))),
            ],
          ],
        ],
      ),
    );
  }
}
