import 'controllers/project_controller.dart';
import 'services/storage_service.dart';
import 'services/file_system_service.dart';
import 'services/zip_export_service.dart';

/// Single access point for the Web Lab module's storage-backed
/// controller, mirroring the app's existing singleton pattern (see
/// `UserProgress`). Must be initialized once via [initialize] before
/// `runApp` — this awaits SharedPreferences setup, so it's done in
/// `main()` as an async step.
class WebLabRegistry {
  static final WebLabRegistry _instance = WebLabRegistry._internal();
  factory WebLabRegistry() => _instance;
  WebLabRegistry._internal();

  late final StorageService storageService;
  late final ProjectController projectController;

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    storageService = StorageService();
    await storageService.initialize();
    projectController = ProjectController(
      storageService: storageService,
      fileSystemService: FileSystemService(),
      zipExportService: ZipExportService(),
    );
    _initialized = true;
  }
}

final webLab = WebLabRegistry();
