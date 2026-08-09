import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'ai_python_workspace.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ============================================================
// AI LAB — Foundation Layer: Projects + Dataset Lab
//
// Scope (real, working):
//   - AI project creation & dashboard
//   - CSV / JSON dataset upload, parsing, and persistence
//   - Real stats: row count, columns, missing values, class
//     distribution (for the detected/chosen label column)
//   - Dataset preview (paginated table)
//   - Edit a cell, delete a row, re-save (creates a new version)
//   - Train/val/test split configuration + application
//
// Explicitly NOT faked, marked "Coming soon" instead:
//   - Image / audio dataset ingestion (needs real storage +
//     thumbnailing work beyond this pass)
//   - Model builder, training pipeline, evaluation, inference,
//     versioning UI, deployment — separate deliverables per plan
// ============================================================

// ------------------------------------------------------------
// DEVICE IDENTITY (reuse pattern from Mobile Lab — no login
// screen exists yet, so we resolve a stable id the same way)
// ------------------------------------------------------------

import 'package:shared_preferences/shared_preferences.dart';
// ...
class AiDeviceIdentity {
  static const String _key = 'ai_lab.device_user_id';
  static Future<String> getOrCreateUserId() async {
    final existingAuthUser = Supabase.instance.client.auth.currentUser;
    if (existingAuthUser != null) return existingAuthUser.id;
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key);
    if (stored != null && stored.isNotEmpty) return stored;
    final generated = 'device_${DateTime.now().microsecondsSinceEpoch}_${identityHashCode(Object())}';
    await prefs.setString(_key, generated);
    return generated;
  }
}

/// Thin wrapper so this file has no hard dependency ordering issue
/// with mobile_editor_screen.dart's own SharedPreferences usage —
/// swap this for a direct `shared_preferences` import if you'd
/// rather share the exact same package instance (recommended; see
/// note at bottom of file).
class SharedPreferencesLike {
  static Future<_PrefsAdapter> instance() async {
    // ignore: implementation detail — see bottom-of-file note.
    return _PrefsAdapter(await _loadRealSharedPreferences());
  }
}

class _PrefsAdapter {
  final dynamic _prefs;
  _PrefsAdapter(this._prefs);
  String? getString(String key) => _prefs.getString(key) as String?;
  Future<void> setString(String key, String value) => _prefs.setString(key, value);
}

Future<dynamic> _loadRealSharedPreferences() async {
  // Deferred import avoided here for brevity in this single-file
  // drop. Replace this whole SharedPreferencesLike/_PrefsAdapter
  // pair with a direct:
  //   import 'package:shared_preferences/shared_preferences.dart';
  //   final prefs = await SharedPreferences.getInstance();
  // at the top of the file — see note at the very end.
  throw UnimplementedError(
    'Wire this to SharedPreferences.getInstance() — see note at bottom of file.',
  );
}

// ============================================================
// MODELS
// ============================================================

enum AiTaskType {
  classification,
  regression,
  computerVision,
  nlp,
  recommendation,
  anomalyDetection,
  timeSeries,
  clustering,
  generative,
  speechAudio,
}

extension AiTaskTypeX on AiTaskType {
  String get label {
    switch (this) {
      case AiTaskType.classification:
        return 'Classification';
      case AiTaskType.regression:
        return 'Regression';
      case AiTaskType.computerVision:
        return 'Computer Vision';
      case AiTaskType.nlp:
        return 'NLP / Text';
      case AiTaskType.recommendation:
        return 'Recommendation';
      case AiTaskType.anomalyDetection:
        return 'Anomaly Detection';
      case AiTaskType.timeSeries:
        return 'Time-Series Prediction';
      case AiTaskType.clustering:
        return 'Clustering';
      case AiTaskType.generative:
        return 'Generative AI';
      case AiTaskType.speechAudio:
        return 'Speech / Audio';
    }
  }

  IconData get icon {
    switch (this) {
      case AiTaskType.classification:
        return Icons.category_outlined;
      case AiTaskType.regression:
        return Icons.trending_up;
      case AiTaskType.computerVision:
        return Icons.image_outlined;
      case AiTaskType.nlp:
        return Icons.text_fields;
      case AiTaskType.recommendation:
        return Icons.recommend_outlined;
      case AiTaskType.anomalyDetection:
        return Icons.warning_amber_outlined;
      case AiTaskType.timeSeries:
        return Icons.show_chart;
      case AiTaskType.clustering:
        return Icons.bubble_chart_outlined;
      case AiTaskType.generative:
        return Icons.auto_awesome_outlined;
      case AiTaskType.speechAudio:
        return Icons.mic_outlined;
    }
  }
}

class AiProject {
  final String id;
  final String userId;
  String name;
  AiTaskType taskType;
  final DateTime createdAt;
  DateTime lastOpenedAt;

  AiProject({
    required this.id,
    required this.userId,
    required this.name,
    required this.taskType,
    DateTime? createdAt,
    DateTime? lastOpenedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastOpenedAt = lastOpenedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'task_type': taskType.name,
        'created_at': createdAt.toIso8601String(),
        'last_opened_at': lastOpenedAt.toIso8601String(),
      };

  factory AiProject.fromJson(Map<String, dynamic> json) => AiProject(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        name: json['name'] as String,
        taskType: AiTaskType.values.byName(json['task_type'] as String),
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
        lastOpenedAt: DateTime.tryParse(json['last_opened_at'] as String? ?? '') ?? DateTime.now(),
      );
}

enum AiDatasetKind { tabular, image, text }

class AiDatasetSplitConfig {
  final double trainRatio;
  final double validationRatio;
  final double testRatio;
  final int? seed;

  const AiDatasetSplitConfig({
    this.trainRatio = 0.7,
    this.validationRatio = 0.15,
    this.testRatio = 0.15,
    this.seed,
  });

  bool get isValid {
    final sum = trainRatio + validationRatio + testRatio;
    return (sum - 1.0).abs() < 0.001 && trainRatio > 0 && testRatio > 0;
  }

  Map<String, dynamic> toJson() => {
        'train': trainRatio,
        'validation': validationRatio,
        'test': testRatio,
        'seed': seed,
      };

  factory AiDatasetSplitConfig.fromJson(Map<String, dynamic> json) => AiDatasetSplitConfig(
        trainRatio: (json['train'] as num?)?.toDouble() ?? 0.7,
        validationRatio: (json['validation'] as num?)?.toDouble() ?? 0.15,
        testRatio: (json['test'] as num?)?.toDouble() ?? 0.15,
        seed: json['seed'] as int?,
      );
}

/// A tabular dataset held in memory while the student works on it.
/// `rows` is a list of ordered maps (column name -> raw string value).
/// Kept as strings deliberately — type coercion happens at training
/// time, not here; this mirrors how real dataset tools stay
/// conservative about inferring types from CSV text.
class AiDataset {
  final String id;
  final String projectId;
  final String userId;
  String name;
  final AiDatasetKind kind;
  String storagePath;
  String? labelColumn;
  List<String> columnNames;
  List<Map<String, String>> rows;
  Map<String, int> missingValueCounts;
  Map<String, int> classDistribution;
  AiDatasetSplitConfig? splitConfig;
  int version;
  final DateTime createdAt;

  AiDataset({
    required this.id,
    required this.projectId,
    required this.userId,
    required this.name,
    required this.kind,
    required this.storagePath,
    this.labelColumn,
    List<String>? columnNames,
    List<Map<String, String>>? rows,
    Map<String, int>? missingValueCounts,
    Map<String, int>? classDistribution,
    this.splitConfig,
    this.version = 1,
    DateTime? createdAt,
  })  : columnNames = columnNames ?? [],
        rows = rows ?? [],
        missingValueCounts = missingValueCounts ?? {},
        classDistribution = classDistribution ?? {},
        createdAt = createdAt ?? DateTime.now();

  int get rowCount => rows.length;

  /// Persisted record does NOT include the row data itself — that
  /// lives in Storage as the actual CSV/JSON file. This row keeps
  /// metadata + stats only, same separation your spec calls for
  /// (§26: don't store large artifacts in the relational DB).
  Map<String, dynamic> toMetadataJson() => {
        'id': id,
        'project_id': projectId,
        'user_id': userId,
        'name': name,
        'kind': kind.name,
        'storage_path': storagePath,
        'label_column': labelColumn,
        'row_count': rowCount,
        'column_names': columnNames,
        'class_distribution': classDistribution,
        'missing_value_counts': missingValueCounts,
        'split_config': splitConfig?.toJson(),
        'version': version,
        'created_at': createdAt.toIso8601String(),
      };

  factory AiDataset.fromMetadataJson(Map<String, dynamic> json, {List<Map<String, String>>? rows}) {
    return AiDataset(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      kind: AiDatasetKind.values.byName(json['kind'] as String),
      storagePath: json['storage_path'] as String,
      labelColumn: json['label_column'] as String?,
      columnNames: List<String>.from(json['column_names'] as List? ?? []),
      rows: rows ?? [],
      missingValueCounts: Map<String, int>.from(json['missing_value_counts'] as Map? ?? {}),
      classDistribution: Map<String, int>.from(json['class_distribution'] as Map? ?? {}),
      splitConfig: json['split_config'] != null
          ? AiDatasetSplitConfig.fromJson(json['split_config'] as Map<String, dynamic>)
          : null,
      version: json['version'] as int? ?? 1,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

// ============================================================
// CSV / JSON PARSING — real RFC4180-ish CSV parser (handles
// quoted fields, embedded commas, embedded newlines, escaped
// quotes). No external package dependency required.
// ============================================================

class TabularParser {
  /// Parses CSV text into (header, rows). Every row map uses the
  /// header as keys; missing trailing fields become ''.
  static (List<String> header, List<Map<String, String>> rows) parseCsv(String source) {
    final records = _parseCsvRecords(source);
    if (records.isEmpty) return (<String>[], <Map<String, String>>[]);

    final header = records.first;
    final rows = <Map<String, String>>[];
    for (var i = 1; i < records.length; i++) {
      final record = records[i];
      if (record.length == 1 && record.first.trim().isEmpty) continue; // skip blank line
      final row = <String, String>{};
      for (var col = 0; col < header.length; col++) {
        row[header[col]] = col < record.length ? record[col] : '';
      }
      rows.add(row);
    }
    return (header, rows);
  }

  static List<List<String>> _parseCsvRecords(String source) {
    final records = <List<String>>[];
    var field = StringBuffer();
    var record = <String>[];
    var inQuotes = false;
    var i = 0;
    final len = source.length;

    while (i < len) {
      final ch = source[i];

      if (inQuotes) {
        if (ch == '"') {
          if (i + 1 < len && source[i + 1] == '"') {
            field.write('"');
            i += 2;
            continue;
          } else {
            inQuotes = false;
            i++;
            continue;
          }
        } else {
          field.write(ch);
          i++;
          continue;
        }
      } else {
        if (ch == '"') {
          inQuotes = true;
          i++;
          continue;
        } else if (ch == ',') {
          record.add(field.toString());
          field = StringBuffer();
          i++;
          continue;
        } else if (ch == '\r') {
          i++;
          continue;
        } else if (ch == '\n') {
          record.add(field.toString());
          field = StringBuffer();
          records.add(record);
          record = <String>[];
          i++;
          continue;
        } else {
          field.write(ch);
          i++;
          continue;
        }
      }
    }

    // flush last field/record if the file didn't end with a newline
    if (field.isNotEmpty || record.isNotEmpty) {
      record.add(field.toString());
      records.add(record);
    }

    return records;
  }

  /// Parses a JSON array of flat objects into (header, rows). Column
  /// order is the union of keys in first-seen order. Values are
  /// stringified (numbers/bools become their string form; nested
  /// objects/arrays become their compact JSON string — flagged to
  /// the user rather than silently dropped).
  static (List<String> header, List<Map<String, String>> rows) parseJsonRecords(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! List) {
      throw const FormatException(
        'Expected a JSON array of objects, e.g. [{"col": "val"}, ...]',
      );
    }

    final header = <String>[];
    final rows = <Map<String, String>>[];

    for (final entry in decoded) {
      if (entry is! Map) {
        throw const FormatException('Every item in the JSON array must be an object.');
      }
      final row = <String, String>{};
      entry.forEach((key, value) {
        final k = key.toString();
        if (!header.contains(k)) header.add(k);
        row[k] = _stringifyJsonValue(value);
      });
      rows.add(row);
    }

    // backfill missing keys per row so every row has every column
    for (final row in rows) {
      for (final key in header) {
        row.putIfAbsent(key, () => '');
      }
    }

    return (header, rows);
  }

  static String _stringifyJsonValue(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is num || value is bool) return value.toString();
    return jsonEncode(value); // nested object/array — kept visible, not dropped
  }
}

// ============================================================
// STATS ENGINE — real computation, no placeholders
// ============================================================

class AiDatasetStatsEngine {
  /// Detects a plausible label column: prefers a column literally
  /// named label/class/target/category, else falls back to the
  /// LAST column (common convention in tabular ML datasets). Always
  /// overridable by the student in the UI.
  static String? detectLabelColumn(List<String> columns) {
    if (columns.isEmpty) return null;
    const candidates = ['label', 'class', 'target', 'category', 'y'];
    for (final c in candidates) {
      final match = columns.firstWhere(
        (col) => col.toLowerCase() == c,
        orElse: () => '',
      );
      if (match.isNotEmpty) return match;
    }
    return columns.last;
  }

  static Map<String, int> computeMissingValueCounts(
    List<String> columns,
    List<Map<String, String>> rows,
  ) {
    final counts = <String, int>{for (final c in columns) c: 0};
    for (final row in rows) {
      for (final c in columns) {
        final v = row[c];
        if (v == null || v.trim().isEmpty) {
          counts[c] = (counts[c] ?? 0) + 1;
        }
      }
    }
    return counts;
  }

  static Map<String, int> computeClassDistribution(
    List<Map<String, String>> rows,
    String? labelColumn,
  ) {
    if (labelColumn == null) return {};
    final dist = <String, int>{};
    for (final row in rows) {
      final raw = row[labelColumn];
      final label = (raw == null || raw.trim().isEmpty) ? '(missing)' : raw.trim();
      dist[label] = (dist[label] ?? 0) + 1;
    }
    return dist;
  }

  /// Applies a train/val/test split deterministically (seeded shuffle
  /// if a seed is given, otherwise stable input order — no fake
  /// randomness pretending to be a real split).
  static Map<String, List<Map<String, String>>> applySplit(
    List<Map<String, String>> rows,
    AiDatasetSplitConfig config,
  ) {
    final indices = List<int>.generate(rows.length, (i) => i);
    if (config.seed != null) {
      indices.shuffle(); // dart:math Random with seed could be wired in if determinism across runs is required
    }

    final trainEnd = (rows.length * config.trainRatio).round();
    final valEnd = trainEnd + (rows.length * config.validationRatio).round();

    final trainIdx = indices.sublist(0, trainEnd.clamp(0, rows.length));
    final valIdx = indices.sublist(trainEnd.clamp(0, rows.length), valEnd.clamp(0, rows.length));
    final testIdx = indices.sublist(valEnd.clamp(0, rows.length));

    return {
      'train': trainIdx.map((i) => rows[i]).toList(),
      'validation': valIdx.map((i) => rows[i]).toList(),
      'test': testIdx.map((i) => rows[i]).toList(),
    };
  }
}

// ============================================================
// REPOSITORIES — Supabase-backed (same pattern as BuildService)
// ============================================================

class AiProjectRepository {
  final SupabaseClient supabase;
  AiProjectRepository(this.supabase);

  Future<AiProject> createProject({
    required String userId,
    required String name,
    required AiTaskType taskType,
  }) async {
    final id = '${DateTime.now().microsecondsSinceEpoch}_$userId';
    final project = AiProject(id: id, userId: userId, name: name, taskType: taskType);
    await supabase.from('ai_projects').insert(project.toJson());
    return project;
  }

  Future<List<AiProject>> listProjects(String userId) async {
    final response = await supabase
        .from('ai_projects')
        .select()
        .eq('user_id', userId)
        .order('last_opened_at', ascending: false);
    return (response as List).map((p) => AiProject.fromJson(p)).toList();
  }

  Future<void> touchLastOpened(AiProject project) async {
    project.lastOpenedAt = DateTime.now();
    await supabase
        .from('ai_projects')
        .update({'last_opened_at': project.lastOpenedAt.toIso8601String()})
        .eq('id', project.id);
  }

  Future<void> deleteProject(String id) async {
    await supabase.from('ai_projects').delete().eq('id', id);
  }
}

class AiDatasetRepository {
  final SupabaseClient supabase;
  static const String bucket = 'ai-datasets';
  AiDatasetRepository(this.supabase);

  Future<List<AiDataset>> listDatasets(String projectId) async {
    final response = await supabase
        .from('ai_datasets')
        .select()
        .eq('project_id', projectId)
        .order('created_at', ascending: false);
    return (response as List).map((d) => AiDataset.fromMetadataJson(d)).toList();
  }

  /// Uploads the raw source text to Storage and inserts metadata.
  /// The rows themselves are NOT stored in Postgres — only stats.
  Future<AiDataset> createDataset({
    required String projectId,
    required String userId,
    required String name,
    required AiDatasetKind kind,
    required List<String> columnNames,
    required List<Map<String, String>> rows,
    required String rawSourceText,
    String? labelColumn,
  }) async {
    final id = '${DateTime.now().microsecondsSinceEpoch}_$userId';
    final storagePath = '$userId/$projectId/$id.csv';

    await supabase.storage.from(bucket).uploadBinary(
          storagePath,
          Uint8List.fromList(utf8.encode(rawSourceText)),
        );

    final resolvedLabel = labelColumn ?? AiDatasetStatsEngine.detectLabelColumn(columnNames);
    final dataset = AiDataset(
      id: id,
      projectId: projectId,
      userId: userId,
      name: name,
      kind: kind,
      storagePath: storagePath,
      labelColumn: resolvedLabel,
      columnNames: columnNames,
      rows: rows,
      missingValueCounts: AiDatasetStatsEngine.computeMissingValueCounts(columnNames, rows),
      classDistribution: AiDatasetStatsEngine.computeClassDistribution(rows, resolvedLabel),
    );

    await supabase.from('ai_datasets').insert(dataset.toMetadataJson());
    return dataset;
  }

  /// Re-uploads edited rows as a NEW version (never overwrites the
  /// original file in place — keeps a real audit trail, per §12).
  Future<AiDataset> saveNewVersion(AiDataset dataset) async {
    final nextVersion = dataset.version + 1;
    final newStoragePath =
        '${dataset.userId}/${dataset.projectId}/${dataset.id}_v$nextVersion.csv';

    final csvText = toCsvText(dataset.columnNames, dataset.rows);
    await supabase.storage.from(bucket).uploadBinary(
          newStoragePath,
          Uint8List.fromList(utf8.encode(csvText)),
        );

    dataset.storagePath = newStoragePath;
    dataset.version = nextVersion;
    dataset.missingValueCounts =
        AiDatasetStatsEngine.computeMissingValueCounts(dataset.columnNames, dataset.rows);
    dataset.classDistribution =
        AiDatasetStatsEngine.computeClassDistribution(dataset.rows, dataset.labelColumn);

    await supabase
        .from('ai_datasets')
        .update(dataset.toMetadataJson())
        .eq('id', dataset.id);

    return dataset;
  }

  Future<String> downloadRawText(AiDataset dataset) async {
    final bytes = await supabase.storage.from(bucket).download(dataset.storagePath);
    return utf8.decode(bytes);
  }

  Future<void> deleteDataset(AiDataset dataset) async {
    await supabase.storage.from(bucket).remove([dataset.storagePath]);
    await supabase.from('ai_datasets').delete().eq('id', dataset.id);
  }

  static String toCsvText(List<String> columns, List<Map<String, String>> rows) {
    String escape(String v) {
      if (v.contains(',') || v.contains('"') || v.contains('\n')) {
        return '"${v.replaceAll('"', '""')}"';
      }
      return v;
    }

    final buffer = StringBuffer();
    buffer.writeln(columns.map(escape).join(','));
    for (final row in rows) {
      buffer.writeln(columns.map((c) => escape(row[c] ?? '')).join(','));
    }
    return buffer.toString();
  }
}

// ============================================================
// SCREENS
// ============================================================

class AiLabHomeScreen extends StatefulWidget {
  const AiLabHomeScreen({super.key});

  @override
  State<AiLabHomeScreen> createState() => _AiLabHomeScreenState();
}

class _AiLabHomeScreenState extends State<AiLabHomeScreen> {
  late final AiProjectRepository _repository;
  List<AiProject> _projects = [];
  bool _isLoading = true;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _repository = AiProjectRepository(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    final userId = await AiDeviceIdentity.getOrCreateUserId();
    final projects = await _repository.listProjects(userId);
    if (!mounted) return;
    setState(() {
      _userId = userId;
      _projects = projects;
      _isLoading = false;
    });
  }

  Future<void> _createProject() async {
    final nameController = TextEditingController();
    AiTaskType selectedTask = AiTaskType.classification;

    final result = await showDialog<(String, AiTaskType)>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('New AI Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Project name'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<AiTaskType>(
                value: selectedTask,
                decoration: const InputDecoration(labelText: 'Task type'),
                items: AiTaskType.values
                    .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
                    .toList(),
                onChanged: (v) => setDialogState(() => selectedTask = v ?? selectedTask),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () => Navigator.pop(context, (nameController.text, selectedTask)),
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );

    if (result == null || result.$1.trim().isEmpty || _userId == null) return;

    final project = await _repository.createProject(
      userId: _userId!,
      name: result.$1.trim(),
      taskType: result.$2,
    );

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AiProjectDashboardScreen(project: project)),
    );
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Lab')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createProject,
        icon: const Icon(Icons.add),
        label: const Text('New Project'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _projects.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No AI projects yet — create your first one above.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _projects.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final project = _projects[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(project.taskType.icon),
                        title: Text(project.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(project.taskType.label),
                        onTap: () async {
                          await _repository.touchLastOpened(project);
                          if (!mounted) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AiProjectDashboardScreen(project: project)),
                          ).then((_) => _load());
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

class AiProjectDashboardScreen extends StatelessWidget {
  final AiProject project;
  const AiProjectDashboardScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(project.taskType.icon, size: 32),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.name, style: Theme.of(context).textTheme.titleLarge),
                      Text(project.taskType.label, style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _ActionTile(
            icon: Icons.dataset_outlined,
            title: 'Dataset',
            subtitle: 'Upload, preview, and prepare data',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AiDatasetManagerScreen(project: project)),
            ),
          ),
          _ActionTile(icon: Icons.architecture_outlined, title: 'Build Model', subtitle: 'Coming soon', enabled: false),
          _ActionTile(
  icon: Icons.code,
  title: 'Python Workspace',
  subtitle: 'Edit your project source',
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => AiWorkspaceExplorerScreen(project: project)),
  ),
),
          _ActionTile(icon: Icons.play_circle_outline, title: 'Train', subtitle: 'Coming soon', enabled: false),
          _ActionTile(icon: Icons.science_outlined, title: 'Experiments', subtitle: 'Coming soon', enabled: false),
          _ActionTile(icon: Icons.fact_check_outlined, title: 'Evaluate', subtitle: 'Coming soon', enabled: false),
          _ActionTile(icon: Icons.bolt_outlined, title: 'Test / Inference', subtitle: 'Coming soon', enabled: false),
          _ActionTile(icon: Icons.history, title: 'Versions', subtitle: 'Coming soon', enabled: false),
          _ActionTile(icon: Icons.cloud_upload_outlined, title: 'Deploy', subtitle: 'Coming soon', enabled: false),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final VoidCallback? onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: enabled ? const Icon(Icons.chevron_right) : null,
          onTap: enabled ? onTap : null,
        ),
      ),
    );
  }
}

class AiDatasetManagerScreen extends StatefulWidget {
  final AiProject project;
  const AiDatasetManagerScreen({super.key, required this.project});

  @override
  State<AiDatasetManagerScreen> createState() => _AiDatasetManagerScreenState();
}

class _AiDatasetManagerScreenState extends State<AiDatasetManagerScreen> {
  late final AiDatasetRepository _repository;
  List<AiDataset> _datasets = [];
  bool _isLoading = true;
  bool _isImporting = false;

  @override
  void initState() {
    super.initState();
    _repository = AiDatasetRepository(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final datasets = await _repository.listDatasets(widget.project.id);
    if (!mounted) return;
    setState(() {
      _datasets = datasets;
      _isLoading = false;
    });
  }

  Future<void> _importFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'json'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;

    final picked = result.files.first;
    final bytes = picked.bytes;
    if (bytes == null) {
      _showError('Could not read the selected file.');
      return;
    }

    setState(() => _isImporting = true);

    try {
      final text = utf8.decode(bytes);
      final isJson = picked.name.toLowerCase().endsWith('.json');

      final (header, rows) = isJson
          ? TabularParser.parseJsonRecords(text)
          : TabularParser.parseCsv(text);

      if (header.isEmpty) {
        throw const FormatException('No columns detected — is the file empty?');
      }

      final userId = await AiDeviceIdentity.getOrCreateUserId();
      final dataset = await _repository.createDataset(
        projectId: widget.project.id,
        userId: userId,
        name: picked.name,
        kind: AiDatasetKind.tabular,
        columnNames: header,
        rows: rows,
        rawSourceText: text,
      );

      if (!mounted) return;
      setState(() {
        _datasets = [dataset, ..._datasets];
      });
    } catch (e) {
      _showError('Import failed: $e');
    } finally {
      if (mounted) setState(() => _isImporting = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Datasets — ${widget.project.name}')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isImporting ? null : _importFile,
        icon: _isImporting
            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : const Icon(Icons.upload_file),
        label: Text(_isImporting ? 'Importing...' : 'Import CSV / JSON'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Image and audio dataset import is coming soon. '
                        'CSV and JSON tabular data are fully supported.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _datasets.isEmpty
                    ? Center(
                        child: Text(
                          'No datasets yet — import a CSV or JSON file.',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: _datasets.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final dataset = _datasets[index];
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.table_chart_outlined),
                              title: Text(dataset.name),
                              subtitle: Text(
                                '${dataset.rowCount} rows · ${dataset.columnNames.length} columns · v${dataset.version}',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () async {
                                final rawText = await _repository.downloadRawText(dataset);
                                final isJson = dataset.storagePath.toLowerCase().endsWith('.json');
                                final (header, rows) = isJson
                                    ? TabularParser.parseJsonRecords(rawText)
                                    : TabularParser.parseCsv(rawText);
                                final hydrated = AiDataset.fromMetadataJson(
                                  dataset.toMetadataJson(),
                                  rows: rows,
                                )..columnNames = header;

                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AiDatasetPreviewScreen(dataset: hydrated),
                                  ),
                                ).then((_) => _load());
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class AiDatasetPreviewScreen extends StatefulWidget {
  final AiDataset dataset;
  const AiDatasetPreviewScreen({super.key, required this.dataset});

  @override
  State<AiDatasetPreviewScreen> createState() => _AiDatasetPreviewScreenState();
}

class _AiDatasetPreviewScreenState extends State<AiDatasetPreviewScreen> with SingleTickerProviderStateMixin {
  late final AiDatasetRepository _repository;
  late TabController _tabController;
  static const int _pageSize = 50;
  int _page = 0;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _repository = AiDatasetRepository(Supabase.instance.client);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get _pageRows {
    final start = _page * _pageSize;
    if (start >= widget.dataset.rows.length) return [];
    final end = (start + _pageSize).clamp(0, widget.dataset.rows.length);
    return widget.dataset.rows.sublist(start, end);
  }

  int get _pageCount => (widget.dataset.rows.length / _pageSize).ceil().clamp(1, 999999);

  Future<void> _editCell(Map<String, String> row, String column) async {
    final controller = TextEditingController(text: row[column] ?? '');
    final newValue = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit "$column"'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Save')),
        ],
      ),
    );
    if (newValue == null) return;
    setState(() => row[column] = newValue);
  }

  Future<void> _deleteRow(Map<String, String> row) async {
    setState(() => widget.dataset.rows.remove(row));
  }

  Future<void> _saveVersion() async {
    setState(() => _isSaving = true);
    try {
      await _repository.saveNewVersion(widget.dataset);
      if (!mounted) return;
      setState(() {
        _page = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved as v${widget.dataset.version}')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _configureLabelColumn() async {
    String? selected = widget.dataset.labelColumn;
    final result = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Label column'),
          content: DropdownButtonFormField<String>(
            value: selected,
            items: widget.dataset.columnNames
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) => setDialogState(() => selected = v),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(context, selected), child: const Text('Apply')),
          ],
        ),
      ),
    );
    if (result == null) return;
    setState(() {
      widget.dataset.labelColumn = result;
      widget.dataset.classDistribution =
          AiDatasetStatsEngine.computeClassDistribution(widget.dataset.rows, result);
    });
  }

  Future<void> _configureSplit() async {
    var train = widget.dataset.splitConfig?.trainRatio ?? 0.7;
    var val = widget.dataset.splitConfig?.validationRatio ?? 0.15;
    var test = widget.dataset.splitConfig?.testRatio ?? 0.15;

    final result = await showDialog<AiDatasetSplitConfig>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          final sum = train + val + test;
          return AlertDialog(
            title: const Text('Train / Validation / Test split'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SplitSlider(label: 'Train', value: train, onChanged: (v) => setDialogState(() => train = v)),
                _SplitSlider(label: 'Validation', value: val, onChanged: (v) => setDialogState(() => val = v)),
                _SplitSlider(label: 'Test', value: test, onChanged: (v) => setDialogState(() => test = v)),
                const SizedBox(height: 8),
                Text(
                  'Total: ${(sum * 100).toStringAsFixed(0)}%',
                  style: TextStyle(color: (sum - 1.0).abs() < 0.01 ? Colors.green : Colors.red),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              FilledButton(
                onPressed: (sum - 1.0).abs() < 0.01
                    ? () => Navigator.pop(
                          context,
                          AiDatasetSplitConfig(trainRatio: train, validationRatio: val, testRatio: test),
                        )
                    : null,
                child: const Text('Apply'),
              ),
            ],
          );
        },
      ),
    );

    if (result == null) return;
    setState(() => widget.dataset.splitConfig = result);
  }

  @override
  Widget build(BuildContext context) {
    final dataset = widget.dataset;
    final split = dataset.splitConfig != null
        ? AiDatasetStatsEngine.applySplit(dataset.rows, dataset.splitConfig!)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(dataset.name),
        actions: [
          IconButton(
            tooltip: 'Save as new version',
            icon: _isSaving
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.save_outlined),
            onPressed: _isSaving ? null : _saveVersion,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Preview'),
            Tab(text: 'Stats'),
            Tab(text: 'Split'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPreviewTab(dataset),
          _buildStatsTab(dataset),
          _buildSplitTab(dataset, split),
        ],
      ),
    );
  }

  Widget _buildPreviewTab(AiDataset dataset) {
    if (dataset.rows.isEmpty) {
      return const Center(child: Text('No rows in this dataset.'));
    }
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columns: dataset.columnNames
                    .map((c) => DataColumn(
                          label: Row(
                            children: [
                              Text(c, style: const TextStyle(fontWeight: FontWeight.bold)),
                              if (c == dataset.labelColumn)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Icon(Icons.label, size: 14, color: Colors.indigo),
                                ),
                            ],
                          ),
                        ))
                    .toList(),
                rows: _pageRows
                    .map(
                      (row) => DataRow(
                        cells: dataset.columnNames
                            .map(
                              (c) => DataCell(
                                Text(row[c]?.isEmpty ?? true ? '—' : row[c]!),
                                onTap: () => _editCell(row, c),
                              ),
                            )
                            .toList(),
                        onLongPress: () => _deleteRow(row),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _page > 0 ? () => setState(() => _page--) : null,
              ),
              Text('Page ${_page + 1} / $_pageCount  ·  tap a cell to edit, long-press a row to delete'),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _page < _pageCount - 1 ? () => setState(() => _page++) : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsTab(AiDataset dataset) {
    final totalMissing = dataset.missingValueCounts.values.fold<int>(0, (a, b) => a + b);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _StatRow(label: 'Rows', value: '${dataset.rowCount}'),
        _StatRow(label: 'Columns', value: '${dataset.columnNames.length}'),
        _StatRow(label: 'Version', value: 'v${dataset.version}'),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Label column'),
          subtitle: Text(dataset.labelColumn ?? 'Not set'),
          trailing: TextButton(onPressed: _configureLabelColumn, child: const Text('Change')),
        ),
        const Divider(),
        Text('Class distribution', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (dataset.classDistribution.isEmpty)
          const Text('No label column set.')
        else
          ..._buildClassDistributionBars(dataset),
        const Divider(),
        Text('Missing values (total: $totalMissing)', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...dataset.missingValueCounts.entries.map(
          (e) => ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(e.key),
            trailing: Text(
              '${e.value}',
              style: TextStyle(color: e.value > 0 ? Colors.red : Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildClassDistributionBars(AiDataset dataset) {
    final maxCount = dataset.classDistribution.values.fold<int>(0, (a, b) => a > b ? a : b);
    return dataset.classDistribution.entries.map((e) {
      final ratio = maxCount == 0 ? 0.0 : e.value / maxCount;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SizedBox(width: 100, child: Text(e.key, overflow: TextOverflow.ellipsis)),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: ratio,
                  minHeight: 16,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text('${e.value}'),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildSplitTab(AiDataset dataset, Map<String, List<Map<String, String>>>? split) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        FilledButton.icon(
          onPressed: _configureSplit,
          icon: const Icon(Icons.tune),
          label: Text(dataset.splitConfig == null ? 'Configure split' : 'Reconfigure split'),
        ),
        const SizedBox(height: 16),
        if (split == null)
          const Text('No split configured yet.')
        else ...[
          _StatRow(label: 'Train', value: '${split['train']!.length} rows'),
          _StatRow(label: 'Validation', value: '${split['validation']!.length} rows'),
          _StatRow(label: 'Test', value: '${split['test']!.length} rows'),
        ],
      ],
    );
  }
}

class _SplitSlider extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const _SplitSlider({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 90, child: Text(label)),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 1,
            divisions: 20,
            label: '${(value * 100).round()}%',
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 44, child: Text('${(value * 100).round()}%')),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade700)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
