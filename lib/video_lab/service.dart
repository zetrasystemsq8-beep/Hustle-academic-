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

  Future<List<VideoProject>> listProjects() async {
    final userId = _client.auth.currentUser!.id;
    final rows = await _client
        .from('video_projects')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return (rows as List).map((r) => VideoProject.fromJson(r)).toList();
  }

  Future<({
    List<TimelineClip> clips,
    List<TextOverlay> overlays,
    List<TransitionSpec> transitions,
    List<StickerOverlay> stickers,
    List<AudioTrack> audioTracks,
  })> loadTimeline(String projectId) async {
    final clipsRows = await _client
        .from('timeline_clips')
        .select('*, assets(storage_path, duration_ms)')
        .eq('project_id', projectId)
        .order('sort_order');
    final overlaysRows = await _client.from('text_overlays').select().eq('project_id', projectId);
    final transitionsRows = await _client.from('transitions').select().eq('project_id', projectId);
    final stickersRows = await _client.from('stickers').select().eq('project_id', projectId);
    final audioRows = await _client.from('audio_tracks').select().eq('project_id', projectId);

    return (
      clips: (clipsRows as List).map((r) => TimelineClip.fromJson(r)).toList(),
      overlays: (overlaysRows as List).map((r) => TextOverlay.fromJson(r)).toList(),
      transitions: (transitionsRows as List).map((r) => TransitionSpec.fromJson(r)).toList(),
      stickers: (stickersRows as List).map((r) => StickerOverlay.fromJson(r)).toList(),
      audioTracks: (audioRows as List).map((r) => AudioTrack.fromJson(r)).toList(),
    );
  }

  Future<void> saveTimeline(VideoLabData data) async {
    final projectId = data.project!.id;

    for (final clip in data.clips) {
      await _client.from('timeline_clips').upsert({'id': clip.id, ...clip.toInsertJson(projectId)});
    }
    for (final overlay in data.overlays) {
      await _client.from('text_overlays').upsert({'id': overlay.id, ...overlay.toInsertJson(projectId)});
    }
    for (final t in data.transitions) {
      await _client.from('transitions').insert(t.toInsertJson(projectId));
    }
    for (final s in data.stickers) {
      await _client.from('stickers').upsert({'id': s.id, ...s.toInsertJson(projectId)});
    }
    for (final a in data.audioTracks) {
      await _client.from('audio_tracks').upsert({'id': a.id, ...a.toInsertJson(projectId)});
    }
  }

  Future<void> updateFilterPreset(String projectId, String preset) async {
    await _client.from('video_projects').update({'filter_preset': preset}).eq('id', projectId);
  }

  Future<String> uploadStickerImage({required String projectId, required dynamic file, required String filename}) async {
    final storagePath = 'stickers/${DateTime.now().millisecondsSinceEpoch}_$filename';
    await _client.storage.from('assets').upload(storagePath, file);
    return storagePath;
  }

  Future<String> uploadAudioFile({required String projectId, required dynamic file, required String filename}) async {
    final storagePath = 'audio/${DateTime.now().millisecondsSinceEpoch}_$filename';
    await _client.storage.from('assets').upload(storagePath, file);
    return storagePath;
  }

  Future<String> startExport({required String projectId, required String destination}) async {
    final res = await _client.functions.invoke('video-lab', body: {
      'action': 'create_job',
      'payload': {'project_id': projectId, 'destination': destination},
    });
    if (res.status != 200) {
      throw Exception('Export failed (${res.status}): ${res.data}');
    }
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
          callback: (payload) => controller.add(RenderJob.fromJson(payload.newRecord)),
        )
        .subscribe();
    controller.onCancel = () => _client.removeChannel(channel);
    return controller.stream;
  }

  Future<String> signedUrl(String bucket, String path, {int expiresInSeconds = 3600}) async {
    return await _client.storage.from(bucket).createSignedUrl(path, expiresInSeconds);
  }

  Future<Map<String, dynamic>> uploadAndRegisterAsset({
    required String projectId,
    required String storagePath,
    required dynamic file,
    required int durationMs,
  }) async {
    await _client.storage.from('assets').upload(storagePath, file);
    final row = await _client
        .from('assets')
        .insert({'project_id': projectId, 'storage_path': storagePath, 'duration_ms': durationMs, 'kind': 'clip'})
        .select()
        .single();
    return row;
  }
}
