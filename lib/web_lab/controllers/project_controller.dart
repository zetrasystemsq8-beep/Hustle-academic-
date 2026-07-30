import 'package:flutter/foundation.dart';
import '../models/file_node_model.dart';
import '../models/project_model.dart';
import '../services/storage_service.dart';
import '../services/file_system_service.dart';
import '../services/zip_export_service.dart';
import '../storage/project_repository.dart';

/// Owns the lifecycle of Web Lab projects: creating, opening, saving,
/// renaming, duplicating, deleting, and exporting them.
///
/// This is the single source of truth for "which project is currently
/// open" and its in-memory file tree. Screens listen to this via
/// [ChangeNotifier] rather than talking to [StorageService] directly.
class ProjectController extends ChangeNotifier {
  final StorageService _storageService;
  final FileSystemService _fileSystemService;
  final ZipExportService _zipExportService;

  ProjectController({
    required StorageService storageService,
    required FileSystemService fileSystemService,
    required ZipExportService zipExportService,
  })  : _storageService = storageService,
        _fileSystemService = fileSystemService,
        _zipExportService = zipExportService;

  ProjectModel? _currentProject;
  List<ProjectSummary> _recentProjects = [];
  bool _isLoading = false;

  /// The project currently open in the editor/preview, or null if the
  /// user is on the Home dashboard with nothing open.
  ProjectModel? get currentProject => _currentProject;

  /// Lightweight summaries for the Home dashboard's "Recent Projects".
  List<ProjectSummary> get recentProjects => List.unmodifiable(_recentProjects);

  bool get isLoading => _isLoading;

  /// Loads the recent-projects index. Call once on Home screen init.
  Future<void> loadRecentProjects() async {
    _isLoading = true;
    notifyListeners();
    _recentProjects = await _storageService.listProjects();
    _isLoading = false;
    notifyListeners();
  }

  /// Creates a brand-new blank project named [name] with three empty
  /// files — index.html, style.css, script.js — exactly as required:
  /// students write every line themselves, no pre-written boilerplate.
  Future<ProjectModel> createBlankProject(String name) async {
    final rootId = _fileSystemService.generateId();
    final root = FileNode(id: rootId, name: name, type: FileNodeType.folder, isExpanded: true);

    _fileSystemService.createFile(root, 'index.html');
    _fileSystemService.createFile(root, 'style.css');
    _fileSystemService.createFile(root, 'script.js');

    final project = ProjectModel(
      id: _fileSystemService.generateId(),
      name: name,
      root: root,
    );

    await _storageService.saveProject(project);
    _currentProject = project;
    await loadRecentProjects();
    notifyListeners();
    return project;
  }

  /// Creates a new project pre-populated from a locked/advanced template's
  /// starter files. Used only by the Templates flow for advanced users.
  Future<ProjectModel> createFromTemplate({
    required String name,
    required String templateId,
    required Map<String, String> starterFiles,
  }) async {
    final rootId = _fileSystemService.generateId();
    final root = FileNode(id: rootId, name: name, type: FileNodeType.folder, isExpanded: true);

    starterFiles.forEach((fileName, content) {
      final file = _fileSystemService.createFile(root, fileName);
      file.content = content;
    });

    final project = ProjectModel(
      id: _fileSystemService.generateId(),
      name: name,
      root: root,
      templateId: templateId,
    );

    await _storageService.saveProject(project);
    _currentProject = project;
    await loadRecentProjects();
    notifyListeners();
    return project;
  }

  /// Opens an existing project by id, making it the current project.
  Future<void> openProject(String projectId) async {
    _isLoading = true;
    notifyListeners();

    final project = await _storageService.loadProject(projectId);
    if (project != null) {
      project.lastOpenedAt = DateTime.now();
      await _storageService.saveProject(project);
      _currentProject = project;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Persists the current project's in-memory state (file tree edits,
  /// orientation, etc.) to local storage.
  Future<void> saveCurrentProject() async {
    final project = _currentProject;
    if (project == null) return;
    await _storageService.saveProject(project);
    await loadRecentProjects();
  }

  /// Renames the current project both in memory and in storage.
  Future<void> renameCurrentProject(String newName) async {
    final project = _currentProject;
    if (project == null) return;
    project.name = newName;
    project.root.name = newName;
    await saveCurrentProject();
    notifyListeners();
  }

  /// Deletes a project by id. If it happens to be the currently open
  /// project, clears the current-project state as well.
  Future<void> deleteProject(String projectId) async {
    await _storageService.deleteProject(projectId);
    if (_currentProject?.id == projectId) {
      _currentProject = null;
    }
    await loadRecentProjects();
  }

  /// Duplicates a stored project (not just the currently open one),
  /// giving the copy a new id and a "(copy)" suffixed name.
  Future<ProjectModel?> duplicateProject(String projectId) async {
    final original = await _storageService.loadProject(projectId);
    if (original == null) return null;

    final newRoot = original.root.deepCopy(
      newId: _fileSystemService.generateId(),
      newName: '${original.name} copy',
    );

    final copy = ProjectModel(
      id: _fileSystemService.generateId(),
      name: '${original.name} copy',
      root: newRoot,
      templateId: original.templateId,
    );

    await _storageService.saveProject(copy);
    await loadRecentProjects();
    notifyListeners();
    return copy;
  }

  /// Closes the current project, returning the user to a "no project
  /// open" state (e.g. when navigating back to Home).
  void closeCurrentProject() {
    _currentProject = null;
    notifyListeners();
  }

  /// Exports the current project as ZIP bytes ready for download/share.
  /// Returns null if no project is currently open.
  ({List<int> bytes, String fileName})? exportCurrentProjectAsZip() {
    final project = _currentProject;
    if (project == null) return null;
    final bytes = _zipExportService.exportProject(project);
    final fileName = _zipExportService.suggestedFileName(project);
    return (bytes: bytes, fileName: fileName);
  }

  /// Call after any in-place mutation of [currentProject]'s file tree
  /// (via [FileSystemService]) so listening widgets rebuild.
  void notifyProjectChanged() => notifyListeners();
}
