import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models_and_state.dart';

class VideoLabService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<VideoProject> createProject({required String title, required String contentType}) async {
    final userId = _client.auth.currentUser!.id;
    final row = await _client
        .from('video_projects')
        .insert({'user_id': userId, 'title': title, 'content_type': contentType})
        .select()
        .single();
    return VideoProject.fromJson(row);
  }

  Future<void> saveTimeline(VideoLabState state) async {
    final projectId = state.project!.id;

    for (final clip in state.clips) {
      await _client.from('timeline_clips').upsert({
        'id': clip.id,
        ...clip.toInsertJson(projectId),
      });
    }
    for (final overlay in state.overlays) {
      await _client.from('text_overlays').insert(overlay.toInsertJson(projectId));
    }
    for (final t in state.transitions) {
      await _client.from('transitions').insert(t.toInsertJson(projectId));
    }
  }

  Future<String> startExport({required String projectId, required String destination}) async {
    final res = await _client.functions.invoke('video-lab', body: {
      'action': 'create_job',
      'payload': {'project_id': projectId, 'destination': destination},
    });
    return res.data['job_id'] as String;
  }

  Stream<RenderJob> watchJob(String jobId) {
    final controller = StreamController<RenderJob>();

    final channel = _client
        .channel('render_job_$jobId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'render_jobs',
          filter: PostgresChangeFilter(type: PostgresChangeFilterType.eq, column: 'id', value: jobId),
          callback: (payload) {
            controller.add(RenderJob.fromJson(payload.newRecord));
          },
        )
        .subscribe();

    controller.onCancel = () => _client.removeChannel(channel);
    return controller.stream;
  }
}
