import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoProject {
  final String id;
  final String userId;
  final String title;
  final String contentType;
  final String status;

  const VideoProject({
    required this.id,
    required this.userId,
    required this.title,
    required this.contentType,
    required this.status,
  });

  factory VideoProject.fromJson(Map<String, dynamic> j) => VideoProject(
        id: j['id'],
        userId: j['user_id'],
        title: j['title'],
        contentType: j['content_type'],
        status: j['status'],
      );
}

class TimelineClip {
  final String id;
  final String assetId;
  final String storagePath;
  final int track;
  final int sourceStartMs;
  final int sourceEndMs;
  final int durationMs;
  final int timelinePositionMs;
  final int sortOrder;

  const TimelineClip({
    required this.id,
    required this.assetId,
    required this.storagePath,
    this.track = 0,
    required this.sourceStartMs,
    required this.sourceEndMs,
    required this.durationMs,
    required this.timelinePositionMs,
    this.sortOrder = 0,
  });

  factory TimelineClip.fromJson(Map<String, dynamic> j) => TimelineClip(
        id: j['id'],
        assetId: j['asset_id'],
        storagePath: j['assets']?['storage_path'] ?? '',
        track: j['track'] ?? 0,
        sourceStartMs: j['source_start_ms'],
        sourceEndMs: j['source_end_ms'],
        durationMs: j['assets']?['duration_ms'] ?? (j['source_end_ms'] as int),
        timelinePositionMs: j['timeline_position_ms'],
        sortOrder: j['sort_order'] ?? 0,
      );

  TimelineClip copyWith({int? sourceStartMs, int? sourceEndMs}) => TimelineClip(
        id: id,
        assetId: assetId,
        storagePath: storagePath,
        track: track,
        sourceStartMs: sourceStartMs ?? this.sourceStartMs,
        sourceEndMs: sourceEndMs ?? this.sourceEndMs,
        durationMs: durationMs,
        timelinePositionMs: timelinePositionMs,
        sortOrder: sortOrder,
      );

  Map<String, dynamic> toInsertJson(String projectId) => {
        'project_id': projectId,
        'asset_id': assetId,
        'track': track,
        'source_start_ms': sourceStartMs,
        'source_end_ms': sourceEndMs,
        'timeline_position_ms': timelinePositionMs,
        'sort_order': sortOrder,
      };
}

class TextOverlay {
  final String text;
  final int startMs;
  final int endMs;
  final String position;

  const TextOverlay({
    required this.text,
    required this.startMs,
    required this.endMs,
    this.position = 'bottom',
  });

  factory TextOverlay.fromJson(Map<String, dynamic> j) => TextOverlay(
        text: j['text'],
        startMs: j['start_ms'],
        endMs: j['end_ms'],
        position: j['position'] ?? 'bottom',
      );

  Map<String, dynamic> toInsertJson(String projectId) => {
        'project_id': projectId,
        'text': text,
        'start_ms': startMs,
        'end_ms': endMs,
        'position': position,
      };
}

class TransitionSpec {
  final String fromClipId;
  final String toClipId;
  final String type;
  final int durationMs;

  const TransitionSpec({
    required this.fromClipId,
    required this.toClipId,
    this.type = 'crossfade',
    this.durationMs = 500,
  });

  factory TransitionSpec.fromJson(Map<String, dynamic> j) => TransitionSpec(
        fromClipId: j['from_clip_id'],
        toClipId: j['to_clip_id'],
        type: j['type'] ?? 'crossfade',
        durationMs: j['duration_ms'] ?? 500,
      );

  Map<String, dynamic> toInsertJson(String projectId) => {
        'project_id': projectId,
        'from_clip_id': fromClipId,
        'to_clip_id': toClipId,
        'type': type,
        'duration_ms': durationMs,
      };
}

class RenderJob {
  final String id;
  final String status;
  final int progressPct;
  final String? outputUrl;
  final String? error;

  const RenderJob({
    required this.id,
    required this.status,
    required this.progressPct,
    this.outputUrl,
    this.error,
  });

  factory RenderJob.fromJson(Map<String, dynamic> j) => RenderJob(
        id: j['id'],
        status: j['status'],
        progressPct: j['progress_pct'] ?? 0,
        outputUrl: j['output_url'],
        error: j['error'],
      );
}

class VideoLabData {
  final VideoProject? project;
  final List<TimelineClip> clips;
  final List<TextOverlay> overlays;
  final List<TransitionSpec> transitions;
  final RenderJob? currentJob;

  const VideoLabData({
    this.project,
    this.clips = const [],
    this.overlays = const [],
    this.transitions = const [],
    this.currentJob,
  });

  VideoLabData copyWith({
    VideoProject? project,
    List<TimelineClip>? clips,
    List<TextOverlay>? overlays,
    List<TransitionSpec>? transitions,
    RenderJob? currentJob,
  }) =>
      VideoLabData(
        project: project ?? this.project,
        clips: clips ?? this.clips,
        overlays: overlays ?? this.overlays,
        transitions: transitions ?? this.transitions,
        currentJob: currentJob ?? this.currentJob,
      );
}

class VideoLabNotifier extends Notifier<VideoLabData> {
  @override
  VideoLabData build() => const VideoLabData();

  void setProject(VideoProject p) {
    state = VideoLabData(project: p);
  }

  void hydrate({
    required List<TimelineClip> clips,
    required List<TextOverlay> overlays,
    required List<TransitionSpec> transitions,
  }) {
    state = state.copyWith(clips: clips, overlays: overlays, transitions: transitions);
  }

  void addClip(TimelineClip clip) {
    final updated = [...state.clips, clip]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    state = state.copyWith(clips: updated);
  }

  void trimClip(String clipId, int startMs, int endMs) {
    final updated = state.clips
        .map((c) => c.id == clipId ? c.copyWith(sourceStartMs: startMs, sourceEndMs: endMs) : c)
        .toList();
    state = state.copyWith(clips: updated);
  }

  void removeClip(String clipId) {
    state = state.copyWith(clips: state.clips.where((c) => c.id != clipId).toList());
  }

  void addOverlay(TextOverlay overlay) {
    state = state.copyWith(overlays: [...state.overlays, overlay]);
  }

  void addTransition(TransitionSpec t) {
    state = state.copyWith(transitions: [...state.transitions, t]);
  }

  void updateJob(RenderJob job) {
    state = state.copyWith(currentJob: job);
  }
}

final videoLabProvider = NotifierProvider<VideoLabNotifier, VideoLabData>(VideoLabNotifier.new);
