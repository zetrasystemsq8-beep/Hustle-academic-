import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// The stage of scientific reasoning a single research entry represents.
/// Modeled after real lab notebooks: an idea isn't "research" until it's
/// written down as a hypothesis, tested with a method, and closed with
/// a result and conclusion — not just a scratch note.
enum ResearchEntryType { hypothesis, method, result, conclusion }

extension ResearchEntryTypeLabel on ResearchEntryType {
  String get label {
    switch (this) {
      case ResearchEntryType.hypothesis:
        return 'Hypothesis';
      case ResearchEntryType.method:
        return 'Method';
      case ResearchEntryType.result:
        return 'Result';
      case ResearchEntryType.conclusion:
        return 'Conclusion';
    }
  }

  String get prompt {
    switch (this) {
      case ResearchEntryType.hypothesis:
        return 'What do you think will happen, and why?';
      case ResearchEntryType.method:
        return 'What exactly did you do to test it?';
      case ResearchEntryType.result:
        return 'What actually happened? Be specific — numbers, behavior, screenshots described in words.';
      case ResearchEntryType.conclusion:
        return 'Was your hypothesis right? What would you test next?';
    }
  }
}

/// A single timestamped entry in a project's research notebook — never
/// editable after creation (matching how a real lab notebook works: you
/// add a correction as a new entry, you don't erase the record).
class ResearchEntry {
  final String id;
  final ResearchEntryType type;
  final String content;
  final DateTime createdAt;

  const ResearchEntry({
    required this.id,
    required this.type,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      };

  factory ResearchEntry.fromJson(Map<String, dynamic> json) {
    return ResearchEntry(
      id: json['id'] as String,
      type: ResearchEntryType.values.byName(json['type'] as String),
      content: json['content'] as String,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

/// The full research notebook for one project — its own persisted
/// record, separate from the project's code, since a hypothesis and its
/// outcome are worth keeping even if the code that tested it changes.
class ResearchNotebook {
  final String projectId;
  List<ResearchEntry> entries;

  ResearchNotebook({required this.projectId, List<ResearchEntry>? entries}) : entries = entries ?? [];

  List<ResearchEntry> entriesOfType(ResearchEntryType type) =>
      entries.where((e) => e.type == type).toList();

  Map<String, dynamic> toJson() => {
        'projectId': projectId,
        'entries': entries.map((e) => e.toJson()).toList(),
      };

  factory ResearchNotebook.fromJson(Map<String, dynamic> json) {
    return ResearchNotebook(
      projectId: json['projectId'] as String,
      entries: (json['entries'] as List<dynamic>? ?? [])
          .map((e) => ResearchEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Persists one research notebook per project locally — kept separate
/// from [ProjectRepository] since a notebook's lifecycle (append-only,
/// never overwritten wholesale) is different from a project's file tree.
class ResearchNotebookRepository {
  static const String _keyPrefix = 'web_lab.research_notebook.';

  Future<ResearchNotebook> load(String projectId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_keyPrefix$projectId');
    if (raw == null) return ResearchNotebook(projectId: projectId);
    return ResearchNotebook.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> save(ResearchNotebook notebook) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_keyPrefix${notebook.projectId}', jsonEncode(notebook.toJson()));
  }
}
