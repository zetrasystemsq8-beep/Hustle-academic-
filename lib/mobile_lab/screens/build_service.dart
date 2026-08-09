import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'edge_function_client.dart';

enum BuildStatus {
  uploading,
  queued,
  preparingEnvironment,
  installingFlutter,
  installingDependencies,
  runningPubGet,
  analyzingProject,
  compilingReleaseApk,
  optimizingApk,
  signingApk,
  uploadingApk,
  complete,
  failed,
  cancelled,
}

enum BuildStage {
  uploadingProject,
  queued,
  preparingEnvironment,
  installingFlutter,
  installingDependencies,
  runningPubGet,
  analyzingProject,
  compilingReleaseApk,
  optimizingApk,
  signingApk,
  uploadingApk,
  buildComplete,
}

class BuildStageInfo {
  final BuildStage stage;
  final String displayName;
  final String icon;
  final bool isCompleted;
  final bool isActive;
  final DateTime? completedAt;
  final String? errorMessage;

  BuildStageInfo({
    required this.stage,
    required this.displayName,
    required this.icon,
    this.isCompleted = false,
    this.isActive = false,
    this.completedAt,
    this.errorMessage,
  });

  factory BuildStageInfo.fromJson(Map<String, dynamic> json) {
    return BuildStageInfo(
      stage: BuildStage.values.byName(json['stage'] as String),
      displayName: json['displayName'] as String,
      icon: json['icon'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.tryParse(json['completedAt'] as String)
          : null,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'stage': stage.name,
        'displayName': displayName,
        'icon': icon,
        'isCompleted': isCompleted,
        'isActive': isActive,
        'completedAt': completedAt?.toIso8601String(),
        'errorMessage': errorMessage,
      };
}

class BuildJob {
  final String id;
  final String projectId;
  final String projectName;
  final String userId;

  final BuildStatus status;
  final List<BuildStageInfo> stages;

  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;

  final String? apkUrl;
  final String? apkSize;
  final String? flutterVersion;
  final String? buildLogs;
  final String? errorLogs;

  final int buildTimeSeconds;
  final double progressPercentage;
  final String currentMessage;

  BuildJob({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.userId,
    this.status = BuildStatus.uploading,
    List<BuildStageInfo>? stages,
    DateTime? createdAt,
    this.startedAt,
    this.completedAt,
    this.apkUrl,
    this.apkSize,
    this.flutterVersion,
    this.buildLogs,
    this.errorLogs,
    this.buildTimeSeconds = 0,
    this.progressPercentage = 0.0,
    this.currentMessage = 'Initializing build...',
  })  : createdAt = createdAt ?? DateTime.now(),
        stages = stages ?? _initializeStages();

  static List<BuildStageInfo> _initializeStages() {
    return [
      BuildStageInfo(stage: BuildStage.uploadingProject, displayName: 'Uploading Project', icon: '📤', isActive: true),
      BuildStageInfo(stage: BuildStage.queued, displayName: 'Queued', icon: '⏳'),
      BuildStageInfo(stage: BuildStage.preparingEnvironment, displayName: 'Preparing Environment', icon: '🔧'),
      BuildStageInfo(stage: BuildStage.installingFlutter, displayName: 'Installing Flutter', icon: '📦'),
      BuildStageInfo(stage: BuildStage.installingDependencies, displayName: 'Installing Dependencies', icon: '📚'),
      BuildStageInfo(stage: BuildStage.runningPubGet, displayName: 'Running flutter pub get', icon: '🔍'),
      BuildStageInfo(stage: BuildStage.analyzingProject, displayName: 'Analyzing Project', icon: '🔎'),
      BuildStageInfo(stage: BuildStage.compilingReleaseApk, displayName: 'Compiling Release APK', icon: '⚙️'),
      BuildStageInfo(stage: BuildStage.optimizingApk, displayName: 'Optimizing APK', icon: '✨'),
      BuildStageInfo(stage: BuildStage.signingApk, displayName: 'Signing APK', icon: '🔐'),
      BuildStageInfo(stage: BuildStage.uploadingApk, displayName: 'Uploading APK', icon: '☁️'),
      BuildStageInfo(stage: BuildStage.buildComplete, displayName: 'Build Complete', icon: '✅'),
    ];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'project_id': projectId,
        'project_name': projectName,
        'user_id': userId,
        'status': status.name,
        'stages': stages.map((s) => s.toJson()).toList(),
        'created_at': createdAt.toIso8601String(),
        'started_at': startedAt?.toIso8601String(),
        'completed_at': completedAt?.toIso8601String(),
        'apk_url': apkUrl,
        'apk_size': apkSize,
        'flutter_version': flutterVersion,
        'build_logs': buildLogs,
        'error_logs': errorLogs,
        'build_time_seconds': buildTimeSeconds,
        'progress_percentage': progressPercentage,
        'current_message': currentMessage,
      };

  factory BuildJob.fromJson(Map<String, dynamic> json) {
    return BuildJob(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      projectName: json['project_name'] as String,
      userId: json['user_id'] as String,
      status: BuildStatus.values.byName(json['status'] as String? ?? 'uploading'),
      stages: (json['stages'] as List<dynamic>? ?? [])
          .map((s) => BuildStageInfo.fromJson(s as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      startedAt: json['started_at'] != null ? DateTime.tryParse(json['started_at'] as String) : null,
      completedAt: json['completed_at'] != null ? DateTime.tryParse(json['completed_at'] as String) : null,
      apkUrl: json['apk_url'] as String?,
      apkSize: json['apk_size'] as String?,
      flutterVersion: json['flutter_version'] as String?,
      buildLogs: json['build_logs'] as String?,
      errorLogs: json['error_logs'] as String?,
      buildTimeSeconds: json['build_time_seconds'] as int? ?? 0,
      progressPercentage: (json['progress_percentage'] as num?)?.toDouble() ?? 0.0,
      currentMessage: json['current_message'] as String? ?? 'Initializing build...',
    );
  }
}

class BuildService {
  final SupabaseClient supabase;
  final String userId;
  late final EdgeFunctionClient _edgeFunctionClient;

  RealtimeChannel? _buildChannel;
  final StreamController<BuildJob> _buildJobController = StreamController<BuildJob>.broadcast();
  final StreamController<String> _logController = StreamController<String>.broadcast();
  final StreamController<List<BuildJob>> _historyController = StreamController<List<BuildJob>>.broadcast();

  final Map<String, BuildJob> _buildJobs = {};

  BuildService({required this.supabase, required this.userId}) {
    _edgeFunctionClient = EdgeFunctionClient(supabase: supabase);
  }

  Stream<BuildJob> get buildJobStream => _buildJobController.stream;
  Stream<String> get logStream => _logController.stream;
  Stream<List<BuildJob>> get historyStream => _historyController.stream;

  Future<void> initialize() async {
    try {
      _buildChannel = supabase
          .channel('builds:user_id=eq.$userId')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'build_jobs',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'user_id',
              value: userId,
            ),
            callback: _handleBuildUpdate,
          )
          .subscribe();

      await loadBuildHistory();
    } catch (e) {
      debugPrint('BuildService initialization error: $e');
      rethrow;
    }
  }

  Future<BuildJob> createBuild({
    required String projectId,
    required String projectName,
    required List<int> projectZipBytes,
  }) async {
    final buildId = '${DateTime.now().microsecondsSinceEpoch}_$userId';
    final buildJob = BuildJob(
      id: buildId,
      projectId: projectId,
      projectName: projectName,
      userId: userId,
      status: BuildStatus.uploading,
      currentMessage: 'Uploading project...',
    );

    await supabase.from('build_jobs').insert(buildJob.toJson());
    _buildJobs[buildId] = buildJob;
    _buildJobController.add(buildJob);
    _logController.add('📤 Uploading project archive...');

    try {
      await _edgeFunctionClient.uploadAndTrigger(
        buildId: buildId,
        userId: userId,
        projectId: projectId,
        projectName: projectName,
        zipBytes: projectZipBytes,
      );
      _logController.add('✅ Project uploaded — build queued on the runner');
    } catch (e) {
      _logController.add('❌ Failed to start build: $e');
      await supabase.from('build_jobs').update({
        'status': 'failed',
        'error_logs': 'Failed to start build: $e',
        'completed_at': DateTime.now().toIso8601String(),
      }).eq('id', buildId);
    }

    return buildJob;
  }

  void _handleBuildUpdate(PostgresChangePayload payload) {
    try {
      if (payload.newRecord.isNotEmpty) {
        final buildJob = BuildJob.fromJson(payload.newRecord);
        _buildJobs[buildJob.id] = buildJob;
        _buildJobController.add(buildJob);
        _logController.add(buildJob.currentMessage);
        _refreshHistorySnapshot();
      }
    } catch (e) {
      debugPrint('Error handling build update: $e');
    }
  }

  void _refreshHistorySnapshot() {
    final list = _buildJobs.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _historyController.add(list);
  }

  Future<void> loadBuildHistory() async {
    try {
      final response = await supabase
          .from('build_jobs')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final builds = (response as List).map((b) => BuildJob.fromJson(b)).toList();
      for (final b in builds) {
        _buildJobs[b.id] = b;
      }
      _historyController.add(builds);
    } catch (e) {
      debugPrint('Error loading build history: $e');
    }
  }

  Future<void> cancelBuild(String buildId) async {
    try {
      await _edgeFunctionClient.cancelBuild(buildId);
      await supabase.from('build_jobs').update({
        'status': 'cancelled',
        'completed_at': DateTime.now().toIso8601String(),
        'current_message': 'Build cancelled by user.',
      }).eq('id', buildId);
      _logController.add('⚠️ Build cancelled by user');
    } catch (e) {
      debugPrint('Error cancelling build: $e');
    }
  }

  Future<String?> downloadApk(String buildId) async {
    try {
      return await _edgeFunctionClient.getApkDownloadUrl(buildId);
    } catch (e) {
      debugPrint('Error getting APK download URL: $e');
      return _buildJobs[buildId]?.apkUrl;
    }
  }

  /// Fetches the exact raw log file produced by the GitHub Actions
  /// runner for this build. Returns null while still building (log
  /// isn't uploaded until the job finishes) or if genuinely missing.
  Future<String?> fetchFullBuildLog(String buildId) {
    return _edgeFunctionClient.fetchFullBuildLog(buildId);
  }

  Future<void> deleteBuild(String buildId) async {
    await supabase.from('build_jobs').delete().eq('id', buildId);
    _buildJobs.remove(buildId);
    _refreshHistorySnapshot();
  }

  void dispose() {
    _buildChannel?.unsubscribe();
    _buildJobController.close();
    _logController.close();
    _historyController.close();
  }
}
