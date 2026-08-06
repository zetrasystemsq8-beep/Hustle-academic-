import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ============================================================
// EDGE FUNCTION CLIENT — Talks to Supabase Edge Functions
// which internally trigger GitHub Actions (invisible to user)
// ============================================================

class GitHubDispatchException implements Exception {
  final String message;
  final int? statusCode;
  GitHubDispatchException(this.message, {this.statusCode});

  @override
  String toString() => 'GitHubDispatchException: $message';
}

class EdgeFunctionClient {
  final SupabaseClient supabase;

  EdgeFunctionClient({required this.supabase});

  /// Calls the `trigger-flutter-build` Edge Function.
  /// This Edge Function is the ONLY thing that knows about GitHub.
  /// It holds the GitHub PAT as a Supabase secret and calls
  /// GitHub's workflow_dispatch API server-side.
  Future<Map<String, dynamic>> triggerBuild({
    required String buildId,
    required String projectId,
    required String projectName,
    required String projectZipUrl,
  }) async {
    try {
      final response = await supabase.functions.invoke(
        'trigger-flutter-build',
        body: {
          'build_id': buildId,
          'project_id': projectId,
          'project_name': projectName,
          'project_zip_url': projectZipUrl,
          'requested_at': DateTime.now().toIso8601String(),
        },
      );

      if (response.status < 200 || response.status >= 300) {
        throw GitHubDispatchException(
          'Failed to trigger build: ${response.data}',
          statusCode: response.status,
        );
      }

      return Map<String, dynamic>.from(response.data ?? {});
    } catch (e) {
      debugPrint('EdgeFunctionClient.triggerBuild error: $e');
      rethrow;
    }
  }

  /// Polls the `build-status` Edge Function, which itself queries
  /// GitHub Actions run status server-side and normalizes it into
  /// our internal BuildStatus vocabulary — the app never talks to
  /// GitHub's API directly.
  Future<Map<String, dynamic>> pollBuildStatus(String buildId) async {
    try {
      final response = await supabase.functions.invoke(
        'build-status',
        body: {'build_id': buildId},
      );

      if (response.status < 200 || response.status >= 300) {
        throw GitHubDispatchException(
          'Failed to poll build status: ${response.data}',
          statusCode: response.status,
        );
      }

      return Map<String, dynamic>.from(response.data ?? {});
    } catch (e) {
      debugPrint('EdgeFunctionClient.pollBuildStatus error: $e');
      rethrow;
    }
  }

  /// Cancels a running build via the `cancel-build` Edge Function,
  /// which internally cancels the GitHub Actions workflow run.
  Future<void> cancelBuild(String buildId) async {
    try {
      final response = await supabase.functions.invoke(
        'cancel-build',
        body: {'build_id': buildId},
      );

      if (response.status < 200 || response.status >= 300) {
        throw GitHubDispatchException(
          'Failed to cancel build: ${response.data}',
          statusCode: response.status,
        );
      }
    } catch (e) {
      debugPrint('EdgeFunctionClient.cancelBuild error: $e');
      rethrow;
    }
  }

  /// Requests a signed, short-lived download URL for a completed APK
  /// from Supabase Storage. Never exposes a GitHub Releases URL.
  Future<String> getApkDownloadUrl(String buildId) async {
    try {
      final response = await supabase.functions.invoke(
        'get-apk-url',
        body: {'build_id': buildId},
      );

      if (response.status < 200 || response.status >= 300) {
        throw GitHubDispatchException(
          'Failed to get APK URL: ${response.data}',
          statusCode: response.status,
        );
      }

      final data = Map<String, dynamic>.from(response.data ?? {});
      final url = data['url'] as String?;
      if (url == null) {
        throw GitHubDispatchException('No APK URL returned');
      }
      return url;
    } catch (e) {
      debugPrint('EdgeFunctionClient.getApkDownloadUrl error: $e');
      rethrow;
    }
  }

  /// Uploads a zipped project to a private Supabase Storage bucket
  /// so the Edge Function / GitHub Action can download it during build.
  Future<String> uploadProjectArchive({
    required String userId,
    required String projectId,
    required List<int> zipBytes,
  }) async {
    try {
      final path = 'projects/$userId/$projectId/${DateTime.now().millisecondsSinceEpoch}.zip';

      await supabase.storage.from('project-archives').uploadBinary(
            path,
            Uint8ListView(zipBytes),
            fileOptions: const FileOptions(
              contentType: 'application/zip',
              upsert: true,
            ),
          );

      final signedUrl = await supabase.storage
          .from('project-archives')
          .createSignedUrl(path, 3600); // 1 hour, enough for CI to fetch

      return signedUrl;
    } catch (e) {
      debugPrint('EdgeFunctionClient.uploadProjectArchive error: $e');
      rethrow;
    }
  }

  /// Streams build logs incrementally via the `stream-logs` Edge
  /// Function, which tails GitHub Actions job logs server-side.
  Stream<String> streamBuildLogs(String buildId) async* {
    String? cursor;
    bool isComplete = false;

    while (!isComplete) {
      try {
        final response = await supabase.functions.invoke(
          'stream-logs',
          body: {
            'build_id': buildId,
            if (cursor != null) 'cursor': cursor,
          },
        );

        if (response.status >= 200 && response.status < 300) {
          final data = Map<String, dynamic>.from(response.data ?? {});
          final lines = (data['lines'] as List<dynamic>? ?? [])
              .map((l) => l.toString());

          for (final line in lines) {
            yield line;
          }

          cursor = data['cursor'] as String?;
          isComplete = data['is_complete'] as bool? ?? false;
        }

        if (!isComplete) {
          await Future.delayed(const Duration(seconds: 2));
        }
      } catch (e) {
        debugPrint('EdgeFunctionClient.streamBuildLogs error: $e');
        break;
      }
    }
  }
}

/// Thin helper so we don't need dart:typed_data imported everywhere.
class Uint8ListView {
  final List<int> _bytes;
  Uint8ListView(this._bytes);
}

// ============================================================
// BUILD ORCHESTRATOR — glues EdgeFunctionClient + BuildService
// together and drives the Realtime-based state machine.
// ============================================================

class BuildOrchestrator {
  final EdgeFunctionClient edgeFunctionClient;
  final SupabaseClient supabase;
  final String userId;

  final StreamController<Map<String, dynamic>> _statusController =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get statusStream => _statusController.stream;

  Timer? _pollTimer;

  BuildOrchestrator({
    required this.edgeFunctionClient,
    required this.supabase,
    required this.userId,
  });

  Future<String> startBuild({
    required String projectId,
    required String projectName,
    required List<int> projectZipBytes,
  }) async {
    // Step 1: Upload project archive to private storage
    final zipUrl = await edgeFunctionClient.uploadProjectArchive(
      userId: userId,
      projectId: projectId,
      zipBytes: projectZipBytes,
    );

    // Step 2: Create build record
    final buildId = '${DateTime.now().microsecondsSinceEpoch}_$userId';
    await supabase.from('build_jobs').insert({
      'id': buildId,
      'project_id': projectId,
      'project_name': projectName,
      'user_id': userId,
      'status': 'uploading',
      'created_at': DateTime.now().toIso8601String(),
    });

    // Step 3: Trigger the invisible GitHub Actions workflow
    await edgeFunctionClient.triggerBuild(
      buildId: buildId,
      projectId: projectId,
      projectName: projectName,
      projectZipUrl: zipUrl,
    );

    // Step 4: Begin polling / realtime monitoring
    _startPolling(buildId);

    return buildId;
  }

  void _startPolling(String buildId) {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final status = await edgeFunctionClient.pollBuildStatus(buildId);
        _statusController.add(status);

        final state = status['status'] as String?;
        if (state == 'complete' || state == 'failed' || state == 'cancelled') {
          timer.cancel();
        }
      } catch (e) {
        debugPrint('Polling error: $e');
      }
    });
  }

  Future<void> cancelBuild(String buildId) async {
    _pollTimer?.cancel();
    await edgeFunctionClient.cancelBuild(buildId);
  }

  void dispose() {
    _pollTimer?.cancel();
    _statusController.close();
  }
}
