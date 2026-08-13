// ============================================================
// MISSION MODELS — guided, multi-step learning paths that walk
// a student through discover → attack → understand → evidence,
// as opposed to CTF's single flag-submission format.
// ============================================================

enum MissionCategory { recon, webVulnerabilities, authentication, authorization, cryptography, forensics, networking, osint }

enum MissionStepType { readInstructions, performInSandbox, submitAnswer, submitEvidence }

class MissionStep {
  final String id;
  final String title;
  final String instructions;
  final MissionStepType type;

  /// For submitAnswer steps — the expected answer's SHA-256 hash,
  /// same verification approach as CTF flags. Null for step types
  /// that don't require a checkable answer.
  final String? expectedAnswerHash;

  /// For submitEvidence steps — what fields the student must fill
  /// in (e.g. "Vulnerable parameter", "Request that triggered it").
  final List<String> evidenceFields;

  const MissionStep({
    required this.id,
    required this.title,
    required this.instructions,
    required this.type,
    this.expectedAnswerHash,
    this.evidenceFields = const [],
  });
}

class Mission {
  final String id;
  final String title;
  final String objective;
  final MissionCategory category;
  final int order; // determines unlock sequence within its category
  final List<MissionStep> steps;
  final String summary; // shown after completion — the "why it works" explanation

  const Mission({
    required this.id,
    required this.title,
    required this.objective,
    required this.category,
    required this.order,
    required this.steps,
    required this.summary,
  });

  String get categoryLabel {
    switch (category) {
      case MissionCategory.recon:
        return 'Reconnaissance';
      case MissionCategory.webVulnerabilities:
        return 'Web Vulnerabilities';
      case MissionCategory.authentication:
        return 'Authentication';
      case MissionCategory.authorization:
        return 'Authorization';
      case MissionCategory.cryptography:
        return 'Cryptography';
      case MissionCategory.forensics:
        return 'Forensics';
      case MissionCategory.networking:
        return 'Networking';
      case MissionCategory.osint:
        return 'OSINT';
    }
  }
}

class MissionProgress {
  final String id;
  final String userId;
  final String missionId;
  final int stepIndex;
  final List<int> completedSteps;
  final String status; // 'in_progress' | 'complete'
  final Map<String, dynamic>? evidence;
  final DateTime startedAt;
  final DateTime? completedAt;

  const MissionProgress({
    required this.id,
    required this.userId,
    required this.missionId,
    required this.stepIndex,
    required this.completedSteps,
    required this.status,
    this.evidence,
    required this.startedAt,
    this.completedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'mission_id': missionId,
        'step_index': stepIndex,
        'completed_steps': completedSteps,
        'status': status,
        'evidence': evidence,
        'started_at': startedAt.toIso8601String(),
        'completed_at': completedAt?.toIso8601String(),
      };

  factory MissionProgress.fromJson(Map<String, dynamic> json) {
    return MissionProgress(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      missionId: json['mission_id'] as String,
      stepIndex: json['step_index'] as int? ?? 0,
      completedSteps: (json['completed_steps'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
      status: json['status'] as String? ?? 'in_progress',
      evidence: json['evidence'] as Map<String, dynamic>?,
      startedAt: DateTime.tryParse(json['started_at'] as String? ?? '') ?? DateTime.now(),
      completedAt: json['completed_at'] != null ? DateTime.tryParse(json['completed_at'] as String) : null,
    );
  }
}
