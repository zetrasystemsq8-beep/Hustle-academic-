import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ============================================================
// MODELS
// ============================================================

enum ChartKind { bar, line, scatter, pie }

extension ChartKindLabel on ChartKind {
  String get label {
    switch (this) {
      case ChartKind.bar:
        return 'Bar Chart';
      case ChartKind.line:
        return 'Line Chart';
      case ChartKind.scatter:
        return 'Scatter Plot';
      case ChartKind.pie:
        return 'Pie Chart';
    }
  }
}

/// One labeled numeric value — the atomic unit every chart type in this
/// center draws from, regardless of how the student got the data in
/// (typed CSV, JSON, or pulled from elsewhere).
class DataPoint {
  final String label;
  final double value;
  final double? secondaryValue; // used only by scatter (y vs. value as x)

  const DataPoint({required this.label, required this.value, this.secondaryValue});

  Map<String, dynamic> toJson() => {'label': label, 'value': value, 'secondaryValue': secondaryValue};

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(
      label: json['label'] as String,
      value: (json['value'] as num).toDouble(),
      secondaryValue: json['secondaryValue'] != null ? (json['secondaryValue'] as num).toDouble() : null,
    );
  }
}

class VisualizationProject {
  final String id;
  String name;
  ChartKind kind;
  List<DataPoint> data;
  String rawInput;
  DateTime updatedAt;

  VisualizationProject({
    required this.id,
    required this.name,
    this.kind = ChartKind.bar,
    List<DataPoint>? data,
    this.rawInput = '',
    DateTime? updatedAt,
  })  : data = data ?? [],
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'kind': kind.name,
        'data': data.map((d) => d.toJson()).toList(),
        'rawInput': rawInput,
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory VisualizationProject.fromJson(Map<String, dynamic> json) {
    return VisualizationProject(
      id: json['id'] as String,
      name: json['name'] as String,
      kind: ChartKind.values.byName(json['kind'] as String? ?? 'bar'),
      data: (json['data'] as List<dynamic>? ?? []).map((d) => DataPoint.fromJson(d as Map<String, dynamic>)).toList(),
      rawInput: json['rawInput'] as String? ?? '',
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  factory VisualizationProject.starterExample() {
    return VisualizationProject(
      id: 'starter_${DateTime.now().microsecondsSinceEpoch}',
      name: 'Monthly Signups (example)',
      kind: ChartKind.bar,
      rawInput: 'Jan,42\nFeb,58\nMar,73\nApr,61\nMay,90',
      data: [
        const DataPoint(label: 'Jan', value: 42),
        const DataPoint(label: 'Feb', value: 58),
        const DataPoint(label: 'Mar', value: 73),
        const DataPoint(label: 'Apr', value: 61),
        const DataPoint(label: 'May', value: 90),
      ],
    );
  }
}

// ============================================================
// PARSER — real CSV parsing, "label,value" per line, honest errors
// ============================================================

class DataParseResult {
  final List<DataPoint> points;
  final List<String> errors;

  const DataParseResult({required this.points, required this.errors});
}

class DataParser {
  /// Parses `label,value` (or `label,value,secondaryValue` for scatter)
  /// per line. Malformed lines are reported, not silently dropped —
  /// an honest parser tells you what it couldn't read.
  DataParseResult parseCsv(String input) {
    final points = <DataPoint>[];
    final errors = <String>[];
    final lines = input.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();

    for (var i = 0; i < lines.length; i++) {
      final parts = lines[i].split(',').map((p) => p.trim()).toList();
      if (parts.length < 2) {
        errors.add('Line ${i + 1}: expected "label,value" — got "${lines[i]}"');
        continue;
      }
      final value = double.tryParse(parts[1]);
      if (value == null) {
        errors.add('Line ${i + 1}: "${parts[1]}" is not a number');
        continue;
      }
      final secondary = parts.length >= 3 ? double.tryParse(parts[2]) : null;
      points.add(DataPoint(label: parts[0], value: value, secondaryValue: secondary));
    }

    return DataParseResult(points: points, errors: errors);
  }
}

// ============================================================
// REPOSITORY
// ============================================================

class VisualizationRepository {
  static const String _storageKey = 'web_lab.visualizations';

  Future<List<VisualizationProject>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List<dynamic>).map((e) => VisualizationProject.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<VisualizationProject> projects) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(projects.map((p) => p.toJson()).toList()));
  }
}

// ============================================================
// CONTROLLER
// ============================================================

class VisualizationController extends ChangeNotifier {
  final VisualizationRepository _repository = VisualizationRepository();
  final DataParser _parser = DataParser();

  List<VisualizationProject> _projects = [];
  bool _isLoading = false;

  List<VisualizationProject> get projects => List.unmodifiable(_projects);
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _projects = await _repository.loadAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<VisualizationProject> create(String name) async {
    final project = VisualizationProject(id: '${DateTime.now().microsecondsSinceEpoch}', name: name);
    _projects.add(project);
    await _repository.saveAll(_projects);
    notifyListeners();
    return project;
  }

  Future<VisualizationProject> createFromExample() async {
    final project = VisualizationProject.starterExample();
    _projects.add(project);
    await _repository.saveAll(_projects);
    notifyListeners();
    return project;
  }

  Future<void> save(VisualizationProject project) async {
    project.updatedAt = DateTime.now();
    await _repository.saveAll(_projects);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _projects.removeWhere((p) => p.id == id);
    await _repository.saveAll(_projects);
    notifyListeners();
  }

  DataParseResult parseInput(String input) => _parser.parseCsv(input);
}

// ============================================================
// CHART PAINTERS — real computed scales/axes, not decoration
// ============================================================

class BarChartPainter extends CustomPainter {
  final List<DataPoint> data;

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    const padding = 40.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;
    final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
    final barWidth = chartWidth / data.length * 0.7;
    final gap = chartWidth / data.length * 0.3;

    final axisPaint = Paint()..color = Colors.grey.shade400..strokeWidth = 1;
    canvas.drawLine(Offset(padding, padding), Offset(padding, size.height - padding), axisPaint);
    canvas.drawLine(Offset(padding, size.height - padding), Offset(size.width - padding, size.height - padding), axisPaint);

    for (var i = 0; i < data.length; i++) {
      final point = data[i];
      final barHeight = maxValue == 0 ? 0.0 : (point.value / maxValue) * chartHeight;
      final x = padding + i * (barWidth + gap) + gap / 2;
      final barPaint = Paint()..color = Colors.blue.shade400;
      canvas.drawRect(Rect.fromLTWH(x, size.height - padding - barHeight, barWidth, barHeight), barPaint);

      final labelPainter = TextPainter(text: TextSpan(text: point.label, style: const TextStyle(fontSize: 10, color: Colors.black87)), textDirection: TextDirection.ltr);
      labelPainter.layout(maxWidth: barWidth + gap);
      labelPainter.paint(canvas, Offset(x, size.height - padding + 4));

      final valuePainter = TextPainter(text: TextSpan(text: point.value.toStringAsFixed(0), style: const TextStyle(fontSize: 10, color: Colors.black54)), textDirection: TextDirection.ltr);
      valuePainter.layout();
      valuePainter.paint(canvas, Offset(x + barWidth / 2 - valuePainter.width / 2, size.height - padding - barHeight - 14));
    }
  }

  @override
  bool shouldRepaint(covariant BarChartPainter oldDelegate) => oldDelegate.data != data;
}

class LineChartPainter extends CustomPainter {
  final List<DataPoint> data;

  LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    const padding = 40.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;
    final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
    final minValue = data.map((d) => d.value).reduce((a, b) => a < b ? a : b);
    final range = (maxValue - minValue).abs() < 0.0001 ? 1.0 : maxValue - minValue;

    final axisPaint = Paint()..color = Colors.grey.shade400..strokeWidth = 1;
    canvas.drawLine(Offset(padding, padding), Offset(padding, size.height - padding), axisPaint);
    canvas.drawLine(Offset(padding, size.height - padding), Offset(size.width - padding, size.height - padding), axisPaint);

    final linePaint = Paint()..color = Colors.blue.shade400..style = PaintingStyle.stroke..strokeWidth = 2;
    final path = Path();

    for (var i = 0; i < data.length; i++) {
      final x = padding + (data.length == 1 ? chartWidth / 2 : (i / (data.length - 1)) * chartWidth);
      final normalized = (data[i].value - minValue) / range;
      final y = size.height - padding - normalized * chartHeight;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      canvas.drawCircle(Offset(x, y), 3, Paint()..color = Colors.blue.shade700);

      final labelPainter = TextPainter(text: TextSpan(text: data[i].label, style: const TextStyle(fontSize: 10, color: Colors.black87)), textDirection: TextDirection.ltr);
      labelPainter.layout();
      labelPainter.paint(canvas, Offset(x - labelPainter.width / 2, size.height - padding + 4));
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) => oldDelegate.data != data;
}

class ScatterPlotPainter extends CustomPainter {
  final List<DataPoint> data;

  ScatterPlotPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final points = data.where((d) => d.secondaryValue != null).toList();
    if (points.isEmpty) return;
    const padding = 40.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;

    final xValues = points.map((d) => d.value).toList();
    final yValues = points.map((d) => d.secondaryValue!).toList();
    final maxX = xValues.reduce((a, b) => a > b ? a : b);
    final minX = xValues.reduce((a, b) => a < b ? a : b);
    final maxY = yValues.reduce((a, b) => a > b ? a : b);
    final minY = yValues.reduce((a, b) => a < b ? a : b);
    final rangeX = (maxX - minX).abs() < 0.0001 ? 1.0 : maxX - minX;
    final rangeY = (maxY - minY).abs() < 0.0001 ? 1.0 : maxY - minY;

    final axisPaint = Paint()..color = Colors.grey.shade400..strokeWidth = 1;
    canvas.drawLine(Offset(padding, padding), Offset(padding, size.height - padding), axisPaint);
    canvas.drawLine(Offset(padding, size.height - padding), Offset(size.width - padding, size.height - padding), axisPaint);

    for (final point in points) {
      final normX = (point.value - minX) / rangeX;
      final normY = (point.secondaryValue! - minY) / rangeY;
      final x = padding + normX * chartWidth;
      final y = size.height - padding - normY * chartHeight;
      canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.purple.shade400);
    }
  }

  @override
  bool shouldRepaint(covariant ScatterPlotPainter oldDelegate) => oldDelegate.data != data;
}

class PieChartPainter extends CustomPainter {
  final List<DataPoint> data;
  static const List<Color> _palette = [Color(0xFF3B82F6), Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFF59E0B), Color(0xFF10B981), Color(0xFFEF4444)];

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final total = data.map((d) => d.value).fold(0.0, (a, b) => a + b);
    if (total <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width < size.height ? size.width : size.height) / 2 - 20;
    var startAngle = -1.5707963267948966; // -90 degrees, in radians

    for (var i = 0; i < data.length; i++) {
      final sweep = (data[i].value / total) * 6.283185307179586;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweep, true, Paint()..color = _palette[i % _palette.length]);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) => oldDelegate.data != data;
}

// ============================================================
// SCREENS
// ============================================================

class VisualizationCenterScreen extends StatefulWidget {
  const VisualizationCenterScreen({super.key});

  @override
  State<VisualizationCenterScreen> createState() => _VisualizationCenterScreenState();
}

class _VisualizationCenterScreenState extends State<VisualizationCenterScreen> {
  late final VisualizationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VisualizationController();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createNew() async {
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name your chart'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final project = await _controller.create(name.trim());
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChartEditorScreen(controller: _controller, project: project)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visualization Center')),
      floatingActionButton: FloatingActionButton(onPressed: _createNew, child: const Icon(Icons.add)),
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
                  subtitle: const Text('Monthly signups as a bar chart, built from typed data.'),
                  trailing: FilledButton(
                    onPressed: () async {
                      final project = await _controller.createFromExample();
                      if (!mounted) return;
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ChartEditorScreen(controller: _controller, project: project)));
                    },
                    child: const Text('Try it'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_controller.projects.isEmpty)
                Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Center(child: Text('No charts yet.', style: TextStyle(color: Colors.grey.shade600))))
              else
                ..._controller.projects.map((project) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(project.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${project.kind.label} · ${project.data.length} points'),
                        trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _controller.delete(project.id)),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChartEditorScreen(controller: _controller, project: project))),
                      ),
                    )),
            ],
          );
        },
      ),
    );
  }
}

class ChartEditorScreen extends StatefulWidget {
  final VisualizationController controller;
  final VisualizationProject project;

  const ChartEditorScreen({super.key, required this.controller, required this.project});

  @override
  State<ChartEditorScreen> createState() => _ChartEditorScreenState();
}

class _ChartEditorScreenState extends State<ChartEditorScreen> {
  late TextEditingController _inputController;
  List<String> _parseErrors = [];

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: widget.project.rawInput);
  }

  Future<void> _parseAndRender() async {
    final result = widget.controller.parseInput(_inputController.text);
    setState(() {
      widget.project.data = result.points;
      widget.project.rawInput = _inputController.text;
      _parseErrors = result.errors;
    });
    await widget.controller.save(widget.project);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
        actions: [
          PopupMenuButton<ChartKind>(
            icon: const Icon(Icons.bar_chart),
            onSelected: (kind) async {
              setState(() => widget.project.kind = kind);
              await widget.controller.save(widget.project);
            },
            itemBuilder: (context) => ChartKind.values.map((k) => PopupMenuItem(value: k, child: Text(k.label))).toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 260,
            padding: const EdgeInsets.all(12),
            child: widget.project.data.isEmpty
                ? Center(child: Text('No data yet — enter some below and tap Render.', style: TextStyle(color: Colors.grey.shade600)))
                : CustomPaint(
                    size: Size.infinite,
                    painter: switch (widget.project.kind) {
                      ChartKind.bar => BarChartPainter(widget.project.data),
                      ChartKind.line => LineChartPainter(widget.project.data),
                      ChartKind.scatter => ScatterPlotPainter(widget.project.data),
                      ChartKind.pie => PieChartPainter(widget.project.data),
                    },
                  ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.kind == ChartKind.scatter ? 'Data (label,x,y per line)' : 'Data (label,value per line)',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      maxLines: null,
                      expands: true,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  if (_parseErrors.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ..._parseErrors.map((e) => Text(e, style: const TextStyle(color: Colors.red, fontSize: 11))),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.auto_graph), label: const Text('Render Chart'), onPressed: _parseAndRender)),
          ),
        ],
      ),
    );
  }
}
