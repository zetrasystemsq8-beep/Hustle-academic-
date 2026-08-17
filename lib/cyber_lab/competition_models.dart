// ============================================================
// COMPETITION MODELS — duels, async challenges, and tournaments
// all share this structure. A competition has a type, a fixed
// set of challenges, and participants tracked by score.
// ============================================================

enum CompetitionType { duel, challenge, tournament }

enum CompetitionStatus { pending, active, complete }

class CyberCompetition {
  final String id;
  final CompetitionType type;
  final String createdBy;
  final List<String> challengeIds;
  final CompetitionStatus status;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final DateTime createdAt;

  const CyberCompetition({
    required this.id,
    required this.type,
    required this.createdBy,
    required this.challengeIds,
    required this.status,
    this.startsAt,
    this.endsAt,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'created_by': createdBy,
        'challenge_ids': challengeIds,
        'status': status.name,
        'starts_at': startsAt?.toIso8601String(),
        'ends_at': endsAt?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
      };

  factory CyberCompetition.fromJson(Map<String, dynamic> json) {
    return CyberCompetition(
      id: json['id'] as String,
      type: CompetitionType.values.byName(json['type'] as String? ?? 'duel'),
      createdBy: json['created_by'] as String,
      challengeIds: (json['challenge_ids'] as List<dynamic>? ?? []).map((e) => e as String).toList(),
      status: CompetitionStatus.values.byName(json['status'] as String? ?? 'pending'),
      startsAt: json['starts_at'] != null ? DateTime.tryParse(json['starts_at'] as String) : null,
      endsAt: json['ends_at'] != null ? DateTime.tryParse(json['ends_at'] as String) : null,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

class CompetitionParticipant {
  final String id;
  final String competitionId;
  final String userId;
  final String? username;
  final int score;
  final int challengesSolved;
  final DateTime? finishedAt;
  final DateTime joinedAt;

  const CompetitionParticipant({
    required this.id,
    required this.competitionId,
    required this.userId,
    this.username,
    required this.score,
    required this.challengesSolved,
    this.finishedAt,
    required this.joinedAt,
  });

  factory CompetitionParticipant.fromJson(Map<String, dynamic> json) {
    return CompetitionParticipant(
      id: json['id'] as String,
      competitionId: json['competition_id'] as String,
      userId: json['user_id'] as String,
      username: json['username'] as String?,
      score: (json['score'] as num?)?.toInt() ?? 0,
      challengesSolved: (json['challenges_solved'] as num?)?.toInt() ?? 0,
      finishedAt: json['finished_at'] != null ? DateTime.tryParse(json['finished_at'] as String) : null,
      joinedAt: DateTime.tryParse(json['joined_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
