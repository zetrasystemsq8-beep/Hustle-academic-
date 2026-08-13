import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoProject {
  final String id;
  final String userId;
  final String title;
  final String contentType;
  final String status;
  final String filterPreset;

  const VideoProject({
    required this.id,
    required this.userId,
    required this.title,
    required this.contentType,
    required this.status,
    this.filterPreset = 'none',
  });

  factory VideoProject.fromJson(Map<String, dynamic> j) => VideoProject(
        id: j['id'],
        userId: j['user_id'],
        title: j['title'],
        contentType: j['content_type'],
        status: j['status'],
        filterPreset: j['filter_preset'] ?? 'none',
      );

  VideoProject copyWith({String? filterPreset}) => VideoProject(
        id: id,
        userId: userId,
        title: title,
        contentType: contentType,
        status: status,
        filterPreset: filterPreset ?? this.filterPreset,
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
  final int rotationDeg; // 0, 90, 180, 270
  final double scale; // 0.5–2.0
  final double speed; // 0.5–2.0

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
    this.rotationDeg = 0,
    this.scale = 1.0,
    this.speed = 1.0,
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
        rotationDeg: j['rotation_deg'] ?? 0,
        scale: (j['scale'] as num?)?.toDouble() ?? 1.0,
        speed: (j['speed'] as num?)?.toDouble() ?? 1.0,
      );

  TimelineClip copyWith({
    int? sourceStartMs,
    int? sourceEndMs,
    int? rotationDeg,
    double? scale,
    double? speed,
  }) =>
      TimelineClip(
        id: id,
        assetId: assetId,
        storagePath: storagePath,
        track: track,
        sourceStartMs: sourceStartMs ?? this.sourceStartMs,
        sourceEndMs: sourceEndMs ?? this.sourceEndMs,
        durationMs: durationMs,
        timelinePositionMs: timelinePositionMs,
        sortOrder: sortOrder,
        rotationDeg: rotationDeg ?? this.rotationDeg,
        scale: scale ?? this.scale,
        speed: speed ?? this.speed,
      );

  Map<String, dynamic> toInsertJson(String projectId) => {
        'project_id': projectId,
        'asset_id': assetId,
        'track': track,
        'source_start_ms': sourceStartMs,
        'source_end_ms': sourceEndMs,
        'timeline_position_ms': timelinePositionMs,
        'sort_order': sortOrder,
        'rotation_deg': rotationDeg,
        'scale': scale,
        'speed': speed,
      };
}

class TextOverlay {
  final String id;
  final String text;
  final int startMs;
  final int endMs;
  final String position;

  const TextOverlay({
    required this.id,
    required this.text,
    required this.startMs,
    required this.endMs,
    this.position = 'bottom',
  });

  factory TextOverlay.fromJson(Map<String, dynamic> j) => TextOverlay(
        id: j['id'],
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
  final String type; // crossfade | zoom | slide | wipe
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

class StickerOverlay {
  final String id;
  final String kind;
  final String content;
  final double posX;
  final double posY;
  final double scale;
  final int startMs;
  final int endMs;

  const StickerOverlay({
    required this.id,
    required this.kind,
    required this.content,
    this.posX = 0.5,
    this.posY = 0.5,
    this.scale = 1.0,
    this.startMs = 0,
    this.endMs = 3000,
  });

  factory StickerOverlay.fromJson(Map<String, dynamic> j) => StickerOverlay(
        id: j['id'],
        kind: j['kind'],
        content: j['content'],
        posX: (j['pos_x'] as num).toDouble(),
        posY: (j['pos_y'] as num).toDouble(),
        scale: (j['scale'] as num).toDouble(),
        startMs: j['start_ms'],
        endMs: j['end_ms'],
      );

  StickerOverlay copyWith({double? posX, double? posY}) => StickerOverlay(
        id: id,
        kind: kind,
        content: content,
        posX: posX ?? this.posX,
        posY: posY ?? this.posY,
        scale: scale,
        startMs: startMs,
        endMs: endMs,
      );

  Map<String, dynamic> toInsertJson(String projectId) => {
        'project_id': projectId,
        'kind': kind,
        'content': content,
        'pos_x': posX,
        'pos_y': posY,
        'scale': scale,
        'start_ms': startMs,
        'end_ms': endMs,
      };
}

class AudioTrack {
  final String id;
  final String kind;
  final String storagePath;
  final int startMs;
  final double volume;
  final int? durationMs;
  final bool cleaned; // apply noise reduction/normalization/silence trim

  const AudioTrack({
    required this.id,
    required this.kind,
    required this.storagePath,
    this.startMs = 0,
    this.volume = 1.0,
    this.durationMs,
    this.cleaned = false,
  });

  factory AudioTrack.fromJson(Map<String, dynamic> j) => AudioTrack(
        id: j['id'],
        kind: j['kind'],
        storagePath: j['storage_path'],
        startMs: j['start_ms'] ?? 0,
        volume: (j['volume'] as num?)?.toDouble() ?? 1.0,
        durationMs: j['duration_ms'],
        cleaned: j['cleaned'] ?? false,
      );

  AudioTrack copyWith({bool? cleaned}) => AudioTrack(
        id: id,
        kind: kind,
        storagePath: storagePath,
        startMs: startMs,
        volume: volume,
        durationMs: durationMs,
        cleaned: cleaned ?? this.cleaned,
      );

  Map<String, dynamic> toInsertJson(String projectId) => {
        'project_id': projectId,
        'kind': kind,
        'storage_path': storagePath,
        'start_ms': startMs,
        'volume': volume,
        'duration_ms': durationMs,
        'cleaned': cleaned,
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
  final List<StickerOverlay> stickers;
  final List<AudioTrack> audioTracks;
  final RenderJob? currentJob;

  const VideoLabData({
    this.project,
    this.clips = const [],
    this.overlays = const [],
    this.transitions = const [],
    this.stickers = const [],
    this.audioTracks = const [],
    this.currentJob,
  });

  VideoLabData copyWith({
    VideoProject? project,
    List<TimelineClip>? clips,
    List<TextOverlay>? overlays,
    List<TransitionSpec>? transitions,
    List<StickerOverlay>? stickers,
    List<AudioTrack>? audioTracks,
    RenderJob? currentJob,
  }) =>
      VideoLabData(
        project: project ?? this.project,
        clips: clips ?? this.clips,
        overlays: overlays ?? this.overlays,
        transitions: transitions ?? this.transitions,
        stickers: stickers ?? this.stickers,
        audioTracks: audioTracks ?? this.audioTracks,
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
    required List<StickerOverlay> stickers,
    required List<AudioTrack> audioTracks,
  }) {
    state = state.copyWith(
      clips: clips,
      overlays: overlays,
      transitions: transitions,
      stickers: stickers,
      audioTracks: audioTracks,
    );
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

  void transformClip(String clipId, {int? rotationDeg, double? scale, double? speed}) {
    final updated = state.clips
        .map((c) => c.id == clipId ? c.copyWith(rotationDeg: rotationDeg, scale: scale, speed: speed) : c)
        .toList();
    state = state.copyWith(clips: updated);
  }

  void removeClip(String clipId) {
    state = state.copyWith(clips: state.clips.where((c) => c.id != clipId).toList());
  }

  void addOverlay(TextOverlay overlay) {
    state = state.copyWith(overlays: [...state.overlays, overlay]);
  }

  void removeOverlay(String id) {
    state = state.copyWith(overlays: state.overlays.where((o) => o.id != id).toList());
  }

  void addTransition(TransitionSpec t) {
    state = state.copyWith(transitions: [...state.transitions, t]);
  }

  void addSticker(StickerOverlay sticker) {
    state = state.copyWith(stickers: [...state.stickers, sticker]);
  }

  void updateStickerPosition(String id, double posX, double posY) {
    final updated = state.stickers.map((s) => s.id == id ? s.copyWith(posX: posX, posY: posY) : s).toList();
    state = state.copyWith(stickers: updated);
  }

  void removeSticker(String id) {
    state = state.copyWith(stickers: state.stickers.where((s) => s.id != id).toList());
  }

  void addAudioTrack(AudioTrack track) {
    state = state.copyWith(audioTracks: [...state.audioTracks, track]);
  }

  void toggleAudioCleaned(String id) {
    final updated = state.audioTracks.map((a) => a.id == id ? a.copyWith(cleaned: !a.cleaned) : a).toList();
    state = state.copyWith(audioTracks: updated);
  }

  void removeAudioTrack(String id) {
    state = state.copyWith(audioTracks: state.audioTracks.where((a) => a.id != id).toList());
  }

  void updateJob(RenderJob job) {
    state = state.copyWith(currentJob: job);
  }

  void setFilterPreset(String preset) {
    final p = state.project;
    if (p == null) return;
    state = state.copyWith(project: p.copyWith(filterPreset: preset));
  }
}

final videoLabProvider = NotifierProvider<VideoLabNotifier, VideoLabData>(VideoLabNotifier.new);
