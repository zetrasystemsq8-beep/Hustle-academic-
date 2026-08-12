import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_dataset_lab.dart' show AiProject;
import 'ai_training_pipeline.dart' show AiTrainingJob, AiTrainingStatus, AiTrainingService;

class AiEvaluateScreen extends StatefulWidget {
  final AiProject project;
  const AiEvaluateScreen({super.key, required this.project});

  @override
  State<AiEvaluateScreen> createState() => _AiEvaluateScreenState();
}

class _AiEvaluateScreenState extends State<AiEvaluateScreen> {
  late final AiTrainingService _service;
  List<AiTrainingJob> _completedJobs = [];
  AiTrainingJob? _selected;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _service = AiTrainingService(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    final jobs = await _service.listJobs(widget.project.id);
    final completed = jobs.where((j) => j.status == AiTrainingStatus.complete && j.metrics != null).toList();
    if (!mounted) return;
    setState(() {
      _completedJobs = completed;
      _selected = completed.isNotEmpty ? completed.first : null;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Evaluate — ${widget.project.name}')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _completedJobs.isEmpty
              ? const Center(child: Text('No completed training runs with metrics yet.'))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    DropdownButtonFormField<AiTrainingJob>(
                      value: _selected,
                      decoration: const InputDecoration(labelText: 'Model version'),
                      items: _completedJobs
                          .map((j) => DropdownMenuItem(
                                value: j,
                                child: Text(j.createdAt.toLocal().toString().split('.').first),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _selected = v),
                    ),
                    const SizedBox(height: 24),
                    if (_selected != null) ..._buildMetricsSection(_selected!),
                  ],
                ),
    );
  }

  List<Widget> _buildMetricsSection(AiTrainingJob job) {
    final metrics = job.metrics!;
    final accuracy = _asDouble(metrics['accuracy']);
    final precision = _asDouble(metrics['precision']);
    final recall = _asDouble(metrics['recall']);
    final f1 = _asDouble(metrics['f1']);
    final classes = (metrics['classes'] as List?)?.map((e) => e.toString()).toList();
    final confusionMatrix = metrics['confusion_matrix'] as List?;

    return [
      Text('Metrics', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 12),
      if (accuracy != null) _MetricCard(
        label: 'Accuracy',
        value: accuracy,
        explainer: 'The share of predictions the model got exactly right.',
      ),
      if (precision != null) _MetricCard(
        label: 'Precision',
        value: precision,
        explainer: 'Of everything the model predicted as a class, how much actually was that class. High precision = few false alarms.',
      ),
      if (recall != null) _MetricCard(
        label: 'Recall',
        value: recall,
        explainer: 'Of everything that actually was a class, how much the model caught. High recall = few missed cases.',
      ),
      if (f1 != null) _MetricCard(
        label: 'F1 Score',
        value: f1,
        explainer: 'The balance between precision and recall — useful when you care about both, not just one.',
      ),
      if (classes != null && confusionMatrix != null && classes.isNotEmpty) ...[
        const SizedBox(height: 24),
        Text('Confusion Matrix', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(
          'Rows = actual class, columns = predicted class. The diagonal is what the model got right.',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        const SizedBox(height: 12),
        _ConfusionMatrixTable(classes: classes, matrix: confusionMatrix),
      ],
    ];
  }

  double? _asDouble(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final double value;
  final String explainer;

  const _MetricCard({required this.label, required this.value, required this.explainer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  (value * 100).toStringAsFixed(1) + '%',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value.clamp(0.0, 1.0),
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 6),
            Text(explainer, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _ConfusionMatrixTable extends StatelessWidget {
  final List<String> classes;
  final List matrix;

  const _ConfusionMatrixTable({required this.classes, required this.matrix});

  @override
  Widget build(BuildContext context) {
    int maxValue = 0;
    for (final row in matrix) {
      for (final v in (row as List)) {
        final iv = (v as num).toInt();
        if (iv > maxValue) maxValue = iv;
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300),
        defaultColumnWidth: const FixedColumnWidth(64),
        children: [
          TableRow(
            children: [
              const SizedBox(width: 90, height: 40),
              ...classes.map((c) => _headerCell(c)),
            ],
          ),
          for (var i = 0; i < classes.length; i++)
            TableRow(
              children: [
                _headerCell(classes[i]),
                for (var j = 0; j < classes.length; j++)
                  _valueCell(
                    (matrix[i] as List)[j] as num,
                    isDiagonal: i == j,
                    maxValue: maxValue,
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _headerCell(String text) => Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        color: Colors.grey.shade100,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis),
      );

  Widget _valueCell(num value, {required bool isDiagonal, required int maxValue}) {
    final intensity = maxValue == 0 ? 0.0 : value / maxValue;
    final color = isDiagonal
        ? Colors.green.withOpacity(0.15 + intensity * 0.5)
        : Colors.red.withOpacity(intensity * 0.35);
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      color: color,
      child: Text('$value', style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
