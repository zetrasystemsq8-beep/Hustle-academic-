import 'package:flutter/foundation.dart';
import '../models/file_node_model.dart';
import '../models/project_model.dart';
import '../services/storage_service.dart';
import '../services/file_system_service.dart';
import '../services/zip_export_service.dart';
import '../services/publish_service.dart';
import '../storage/project_repository.dart';

class ProjectController extends ChangeNotifier {
  final StorageService _storageService;
  final FileSystemService _fileSystemService;
  final ZipExportService _zipExportService;
  final PublishService _publishService;

  ProjectController({
    required StorageService storageService,
    required FileSystemService fileSystemService,
    required ZipExportService zipExportService,
    required PublishService publishService,
  })  : _storageService = storageService,
        _fileSystemService = fileSystemService,
        _zipExportService = zipExportService,
        _publishService = publishService;

  ProjectModel? _currentProject;
  List<ProjectSummary> _recentProjects = [];
  bool _isLoading = false;

  ProjectModel? get currentProject => _currentProject;
  List<ProjectSummary> get recentProjects => List.unmodifiable(_recentProjects);
  bool get isLoading => _isLoading;

  Future<void> loadRecentProjects() async {
    _isLoading = true;
    notifyListeners();
    _recentProjects = await _storageService.listProjects();
    _isLoading = false;
    notifyListeners();
  }

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

  Future<void> saveCurrentProject() async {
    final project = _currentProject;
    if (project == null) return;
    await _storageService.saveProject(project);
    await loadRecentProjects();
  }

  Future<void> renameCurrentProject(String newName) async {
    final project = _currentProject;
    if (project == null) return;
    project.name = newName;
    project.root.name = newName;
    await saveCurrentProject();
    notifyListeners();
  }

  Future<void> deleteProject(String projectId) async {
    await _storageService.deleteProject(projectId);
    if (_currentProject?.id == projectId) {
      _currentProject = null;
    }
    await loadRecentProjects();
  }

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

  void closeCurrentProject() {
    _currentProject = null;
    notifyListeners();
  }

  ({List<int> bytes, String fileName})? exportCurrentProjectAsZip() {
    final project = _currentProject;
    if (project == null) return null;
    final bytes = _zipExportService.exportProject(project);
    final fileName = _zipExportService.suggestedFileName(project);
    return (bytes: bytes, fileName: fileName);
  }

  /// Publishes the current project, optionally attaching a claimed
  /// Inventor Handle so it shows up on that student's public profile.
  /// [authorHandle] is optional since not every student will have
  /// claimed one yet.
  Future<PublishResult> publishCurrentProject({String? authorHandle}) async {
    final project = _currentProject;
    if (project == null) {
      throw StateError('No project open to publish.');
    }

    final result = await _publishService.publish(project, existingSlug: project.publishedSlug, authorHandle: authorHandle);
    project.publishedSlug = result.slug;
    project.publishedAt = DateTime.now();
    await saveCurrentProject();
    notifyListeners();
    return result;
  }

  Future<void> unpublishCurrentProject() async {
    final project = _currentProject;
    if (project == null || project.publishedSlug == null) return;

    await _publishService.unpublish(project.publishedSlug!);
    project.publishedSlug = null;
    project.publishedAt = null;
    await saveCurrentProject();
    notifyListeners();
  }

  String? publicUrlForCurrentProject() {
    final project = _currentProject;
    if (project == null || project.publishedSlug == null) return null;
    return _publishService.publicUrlForSlug(project.publishedSlug!);
  }

  /// Toggles a CDN package on/off for the current project and persists
  /// the change immediately, so the next preview/publish reflects it.
  Future<void> togglePackage(String packageId) async {
    final project = _currentProject;
    if (project == null) return;

    if (project.enabledCdnPackageIds.contains(packageId)) {
      project.enabledCdnPackageIds.remove(packageId);
    } else {
      project.enabledCdnPackageIds.add(packageId);
    }
    await saveCurrentProject();
    notifyListeners();
  }

  bool isPackageEnabled(String packageId) {
    return _currentProject?.enabledCdnPackageIds.contains(packageId) ?? false;
  }

  void notifyProjectChanged() => notifyListeners();
}
