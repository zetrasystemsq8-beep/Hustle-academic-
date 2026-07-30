import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/project_model.dart';
import 'local_storage_keys.dart';

/// A lightweight summary of a project used by the Home dashboard's
/// "Recent Projects" list, so the UI doesn't need to deserialize an
/// entire file tree just to show a name and a timestamp.
class ProjectSummary {
  final String id;
  final String name;
  final DateTime lastOpenedAt;
  final String? templateId;

  const ProjectSummary({
    required this.id,
    required this.name,
    required this.lastOpenedAt,
    this.templateId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastOpenedAt': lastOpenedAt.toIso8601String(),
        'templateId': templateId,
      };

  factory ProjectSummary.fromJson(Map<String, dynamic> json) {
    return ProjectSummary(
      id: json['id'] as String,
      name: json['name'] as String,
      lastOpenedAt:
          DateTime.tryParse(json['lastOpenedAt'] as String? ?? '') ??
              DateTime.now(),
      templateId: json['templateId'] as String?,
    );
  }

  factory ProjectSummary.fromProject(ProjectModel project) {
    return ProjectSummary(
      id: project.id,
      name: project.name,
      lastOpenedAt: project.lastOpenedAt,
      templateId: project.templateId,
    );
  }
}

/// Data-access layer responsible for all local persistence of Web Lab
/// projects. Every other layer (controllers, services) talks to storage
/// exclusively through this repository — no widget or controller should
/// call SharedPreferences directly.
///
/// Backed by SharedPreferences for simplicity and cross-platform support;
/// swap the internals here if a future version needs SQLite or file-based
/// storage instead, without touching any calling code.
class ProjectRepository {
  final SharedPreferences _prefs;

  ProjectRepository(this._prefs);

  /// Persists a full project (including its entire file tree) and updates
  /// the lightweight project index used by the dashboard.
  Future<void> saveProject(ProjectModel project) async {
    final key = LocalStorageKeys.projectKey(project.id);
    await _prefs.setString(key, jsonEncode(project.toJson()));
    await _updateIndex(ProjectSummary.fromProject(project));
  }

  /// Loads a single project's full data by its [projectId], or null if it
  /// doesn't exist (e.g. was deleted from another device/session).
  Future<ProjectModel?> loadProject(String projectId) async {
    final raw = _prefs.getString(LocalStorageKeys.projectKey(projectId));
    if (raw == null) return null;
    return ProjectModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  /// Returns lightweight summaries for every stored project, most
  /// recently opened first. Used to populate the Home dashboard without
  /// the cost of loading full file trees.
  Future<List<ProjectSummary>> listProjects() async {
    final raw = _prefs.getString(LocalStorageKeys.projectIndex);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    final summaries = list
        .map((e) => ProjectSummary.fromJson(e as Map<String, dynamic>))
        .toList();
    summaries.sort((a, b) => b.lastOpenedAt.compareTo(a.lastOpenedAt));
    return summaries;
  }

  /// Permanently deletes a project and removes it from the index.
  Future<void> deleteProject(String projectId) async {
    await _prefs.remove(LocalStorageKeys.projectKey(projectId));
    final summaries = await listProjects();
    summaries.removeWhere((s) => s.id == projectId);
    await _prefs.setString(
      LocalStorageKeys.projectIndex,
      jsonEncode(summaries.map((s) => s.toJson()).toList()),
    );
  }

  /// Renames a project both in its full record and in the index, without
  /// needing to touch its file tree.
  Future<void> renameProject(String projectId, String newName) async {
    final project = await loadProject(projectId);
    if (project == null) return;
    project.name = newName;
    await saveProject(project);
  }

  /// Inserts or updates a project's entry in the summary index.
  Future<void> _updateIndex(ProjectSummary summary) async {
    final summaries = await listProjects();
    summaries.removeWhere((s) => s.id == summary.id);
    summaries.add(summary);
    await _prefs.setString(
      LocalStorageKeys.projectIndex,
      jsonEncode(summaries.map((s) => s.toJson()).toList()),
    );
  }
}
