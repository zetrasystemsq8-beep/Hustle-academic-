import 'package:flutter/foundation.dart';

class VideoProject {
  final String id;
  final String userId;
  final String title;
  final String contentType; // project_video | screenshot_trim | explanation | new_theory
  final String status;

  VideoProject({
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
  int track;
  int sourceStartMs;
  int sourceEndMs;
  int timelinePositionMs;
  int sortOrder;

  TimelineClip({
    required this.id,
    required this.assetId,
    required this.storagePath,
    this.track = 0,
    required this.sourceStartMs,
    required this.sourceEndMs,
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
        timelinePositionMs: j['timeline_position_ms'],
        sortOrder: j['sort_order'] ?? 0,
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
  String text;
  int startMs;
  int endMs;
  String position;

  TextOverlay({required this.text, required this.startMs, required this.endMs, this.position = 'bottom'});

  Map<String, dynamic> toInsertJson(String projectId) => {
        'project_id': projectId,
        'text': text,
        'start_ms': startMs,
        'end_ms': endMs,
        'position': position,
      };
}

class TransitionSpec {
  String fromClipId;
  String toClipId;
  String type;
  int durationMs;

  TransitionSpec({required this.fromClipId, required this.toClipId, this.type = 'crossfade', this.durationMs = 500});

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

  RenderJob({required this.id, required this.status, required this.progressPct, this.outputUrl, this.error});

  factory RenderJob.fromJson(Map<String, dynamic> j) => RenderJob(
        id: j['id'],
        status: j['status'],
        progressPct: j['progress_pct'] ?? 0,
        outputUrl: j['output_url'],
        error: j['error'],
      );
}

class VideoLabState extends ChangeNotifier {
  VideoProject? project;
  final List<TimelineClip> clips = [];
  final List<TextOverlay> overlays = [];
  final List<TransitionSpec> transitions = [];
  RenderJob? currentJob;

  void setProject(VideoProject p) {
    project = p;
    notifyListeners();
  }

  void addClip(TimelineClip clip) {
    clips.add(clip);
    clips.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    notifyListeners();
  }

  void trimClip(String clipId, int startMs, int endMs) {
    final clip = clips.firstWhere((c) => c.id == clipId);
    clip.sourceStartMs = startMs;
    clip.sourceEndMs = endMs;
    notifyListeners();
  }

  void removeClip(String clipId) {
    clips.removeWhere((c) => c.id == clipId);
    notifyListeners();
  }

  void addOverlay(TextOverlay overlay) {
    overlays.add(overlay);
    notifyListeners();
  }

  void addTransition(TransitionSpec t) {
    transitions.add(t);
    notifyListeners();
  }

  void updateJob(RenderJob job) {
    currentJob = job;
    notifyListeners();
  }
}
