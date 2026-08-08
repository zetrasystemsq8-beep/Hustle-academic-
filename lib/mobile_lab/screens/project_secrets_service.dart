import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ============================================================
// PROJECT SECRETS SERVICE — CRUD for per-project key/value pairs.
// These are injected into the APK at build time as --dart-define
// values by the invisible build backend. Never bundled into the
// zipped project source, never visible to the GitHub workflow
// except as a short-lived signed URL it downloads once.
// ============================================================

class ProjectSecret {
  final String id;
  final String projectId;
  final String key;
  final String value;
  final DateTime updatedAt;

  ProjectSecret({
    required this.id,
    required this.projectId,
    required this.key,
    required this.value,
    required this.updatedAt,
  });

  factory ProjectSecret.fromJson(Map<String, dynamic> json) {
    return ProjectSecret(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

class ProjectSecretsService {
  final SupabaseClient supabase;
  final String userId;

  ProjectSecretsService({required this.supabase, required this.userId});

  Future<List<ProjectSecret>> listSecrets(String projectId) async {
    try {
      final response = await supabase
          .from('project_secrets')
          .select()
          .eq('project_id', projectId)
          .eq('user_id', userId)
          .order('key', ascending: true);

      return (response as List)
          .map((s) => ProjectSecret.fromJson(s as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('ProjectSecretsService.listSecrets error: $e');
      return [];
    }
  }

  Future<void> upsertSecret({
    required String projectId,
    required String key,
    required String value,
  }) async {
    await supabase.from('project_secrets').upsert({
      'project_id': projectId,
      'user_id': userId,
      'key': key,
      'value': value,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'project_id,key');
  }

  Future<void> deleteSecret(String id) async {
    await supabase.from('project_secrets').delete().eq('id', id);
  }
}
