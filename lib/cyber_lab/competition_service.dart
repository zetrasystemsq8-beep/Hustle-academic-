import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'competition_models.dart';
import 'cyber_models.dart';
import 'cyber_models.dart' show CyberChallenges;

// ============================================================
// COMPETITION SERVICE — create/join duels, submit answers, and
// track opponents' live scores via Supabase realtime. Same
// SHA-256 flag verification as CTF — never trusts the client.
// ============================================================

class CompetitionService {
  final SupabaseClient supabase;
  final String userId;

  RealtimeChannel? _participantsChannel;
  final StreamController<List<CompetitionParticipant>> _participantsController =
      StreamController<List<CompetitionParticipant>>.broadcast();

  CompetitionService({required this.supabase, required this.userId});

  Stream<List<CompetitionParticipant>> get participantsStream => _participantsController.stream;

  /// Creates a duel: picks challengeCount random challenges (same
  /// pool for both competitors, so it's fair) and inserts the
  /// creator as the first participant.
  Future<CyberCompetition> createDuel({int challengeCount = 3}) async {
    final allChallenges = List.of(CyberChallenges.all)..shuffle();
    final selected = allChallenges.take(challengeCount).map((c) => c.id).toList();

    final competitionId = '${DateTime.now().microsecondsSinceEpoch}_$userId';
    final competition = CyberCompetition(
      id: competitionId,
      type: CompetitionType.duel,
      createdBy: userId,
      challengeIds: selected,
      status: CompetitionStatus.pending,
      createdAt: DateTime.now(),
    );

    await supabase.from('cyber_competitions').insert(competition.toJson());

    await supabase.from('cyber_competition_participants').insert({
      'id': '${DateTime.now().microsecondsSinceEpoch}_${userId}_p1',
      'competition_id': competitionId,
      'user_id': userId,
      'score': 0,
      'challenges_solved': 0,
    });

    return competition;
  }

  /// A second (or third+) student joins using the competition's
  /// ID/code. Also flips status to 'active' once at least 2
  /// participants have joined.
  Future<void> joinCompetition(String competitionId) async {
    final existing = await supabase
        .from('cyber_competition_participants')
        .select()
        .eq('competition_id', competitionId)
        .eq('user_id', userId)
        .maybeSingle();

    if (existing == null) {
      await supabase.from('cyber_competition_participants').insert({
        'id': '${DateTime.now().microsecondsSinceEpoch}_$userId',
        'competition_id': competitionId,
        'user_id': userId,
        'score': 0,
        'challenges_solved': 0,
      });
    }

    final participants = await supabase
        .from('cyber_competition_participants')
        .select()
        .eq('competition_id', competitionId);

    if ((participants as List).length >= 2) {
      await supabase
          .from('cyber_competitions')
          .update({'status': 'active', 'starts_at': DateTime.now().toIso8601String()})
          .eq('id', competitionId);
    }
  }

  Future<CyberCompetition?> getCompetition(String competitionId) async {
    final response = await supabase.from('cyber_competitions').select().eq('id', competitionId).maybeSingle();
    if (response == null) return null;
    return CyberCompetition.fromJson(response);
  }

  void subscribeToParticipants(String competitionId) {
    _participantsChannel?.unsubscribe();
    _participantsChannel = supabase
        .channel('cyber_competition_participants:competition_id=eq.$competitionId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'cyber_competition_participants',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'competition_id',
            value: competitionId,
          ),
          callback: (_) => _refreshParticipants(competitionId),
        )
        .subscribe();
    _refreshParticipants(competitionId);
  }

  Future<void> _refreshParticipants(String competitionId) async {
    try {
      final rows = await supabase
          .from('cyber_competition_participants')
          .select('*, profiles(username)')
          .eq('competition_id', competitionId)
          .order('score', ascending: false);

      final participants = (rows as List).map((r) {
        final map = Map<String, dynamic>.from(r as Map);
        final profile = map['profiles'] as Map<String, dynamic>?;
        map['username'] = profile?['username'];
        return CompetitionParticipant.fromJson(map);
      }).toList();

      _participantsController.add(participants);
    } catch (e) {
      // leave stream as-is on failure
    }
  }

  /// Verifies a flag the same way CTF does, and if correct,
  /// increments this student's score/solved count for this
  /// specific competition — separate from their overall CTF score.
  Future<bool> submitAnswer({
    required String competitionId,
    required CtfChallenge challenge,
    required String guess,
  }) async {
    final guessHash = sha256.convert(utf8.encode(guess.trim())).toString();
    final isCorrect = guessHash == challenge.flagHash;

    if (isCorrect) {
      final current = await supabase
          .from('cyber_competition_participants')
          .select()
          .eq('competition_id', competitionId)
          .eq('user_id', userId)
          .single();

      await supabase
          .from('cyber_competition_participants')
          .update({
            'score': (current['score'] as int) + challenge.points,
            'challenges_solved': (current['challenges_solved'] as int) + 1,
          })
          .eq('competition_id', competitionId)
          .eq('user_id', userId);
    }

    return isCorrect;
  }

  Future<void> markFinished(String competitionId) async {
    await supabase
        .from('cyber_competition_participants')
        .update({'finished_at': DateTime.now().toIso8601String()})
        .eq('competition_id', competitionId)
        .eq('user_id', userId);
  }

  void dispose() {
    _participantsChannel?.unsubscribe();
    _participantsController.close();
  }
}
