import 'package:shared_preferences/shared_preferences.dart';
import '../models/project_model.dart';
import '../storage/project_repository.dart';

/// Application-facing storage facade used by controllers.
///
/// Wraps [ProjectRepository] and owns the async bootstrap of
/// SharedPreferences, so controllers never deal with initialization order
/// or the underlying persistence engine directly.
class StorageService {
  ProjectRepository? _repository;

  /// Must be called once (e.g. in `main()`) before any other method on
  /// this service is used.
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _repository = ProjectRepository(prefs);
  }

  ProjectRepository get _requireRepo {
    final repo = _repository;
    if (repo == null) {
      throw StateError(
        'StorageService.initialize() must be called before use.',
      );
    }
    return repo;
  }

  Future<void> saveProject(ProjectModel project) =>
      _requireRepo.saveProject(project);

  Future<ProjectModel?> loadProject(String projectId) =>
      _requireRepo.loadProject(projectId);

  Future<List<ProjectSummary>> listProjects() => _requireRepo.listProjects();

  Future<void> deleteProject(String projectId) =>
      _requireRepo.deleteProject(projectId);

  Future<void> renameProject(String projectId, String newName) =>
      _requireRepo.renameProject(projectId, newName);
}
