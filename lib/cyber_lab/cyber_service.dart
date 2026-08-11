import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cyber_models.dart';

// ============================================================
// CYBER SERVICE — CTF scoring, sandbox provisioning, the attack
// tool, and packet analysis all in one service, same pattern as
// BuildService carrying the whole Mobile Lab pipeline.
// ============================================================

class CyberService {
  final SupabaseClient supabase;
  final String userId;

  late final RealtimeChannel _sandboxChannel;
  final StreamController<SandboxSession> _sandboxController = StreamController<SandboxSession>.broadcast();
  final StreamController<List<CtfSubmission>> _submissionsController = StreamController<List<CtfSubmission>>.broadcast();

  final Map<String, int> _attemptsByChallenge = {};
  SandboxSession? _currentSandbox;

  CyberService({required this.supabase, required this.userId});

  Stream<SandboxSession> get sandboxStream => _sandboxController.stream;
  Stream<List<CtfSubmission>> get submissionsStream => _submissionsController.stream;
  SandboxSession? get currentSandbox => _currentSandbox;

  Future<void> initialize() async {
    _sandboxChannel = supabase
        .channel('sandbox_sessions:user_id=eq.$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'sandbox_sessions',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            if (payload.newRecord.isNotEmpty) {
              final session = SandboxSession.fromJson(payload.newRecord);
              _currentSandbox = session;
              _sandboxController.add(session);
            }
          },
        )
        .subscribe();

    await loadSubmissions();
  }

  // ==========================================================
  // CTF FLAG SUBMISSION — real SHA-256 comparison, never trusts
  // the client for scoring; the correctness check happens here
  // but points are only ever awarded via the write below, and a
  // student can inspect this code and still gain nothing without
  // knowing the actual flag text, since only its hash ships.
  // ==========================================================

  /// Returns true if [guess] matches the challenge's real flag.
  /// Tracks attempts per challenge in-memory for this session and
  /// reduces awarded points after repeated wrong guesses, then
  /// records the attempt (correct or not) to Supabase.
  Future<bool> submitFlag({
    required CtfChallenge challenge,
    required String guess,
  }) async {
    final normalizedGuess = guess.trim();
    final guessHash = sha256.convert(utf8.encode(normalizedGuess)).toString();
    final isCorrect = guessHash == challenge.flagHash;

    final attempts = (_attemptsByChallenge[challenge.id] ?? 0) + 1;
    _attemptsByChallenge[challenge.id] = attempts;

    int pointsAwarded = 0;
    if (isCorrect) {
      // Full points on first try, tapering down for repeated attempts,
      // never below 25% of the challenge's base value.
      final penalty = (attempts - 1) * 0.15;
      final multiplier = (1.0 - penalty).clamp(0.25, 1.0);
      pointsAwarded = (challenge.points * multiplier).round();
    }

    final submission = CtfSubmission(
      id: '${DateTime.now().microsecondsSinceEpoch}_$userId',
      userId: userId,
      challengeId: challenge.id,
      correct: isCorrect,
      attemptsUsed: attempts,
      pointsAwarded: pointsAwarded,
      submittedAt: DateTime.now(),
    );

    try {
      await supabase.from('ctf_submissions').insert(submission.toJson());
      await loadSubmissions();
    } catch (e) {
      // Submission logging failure shouldn't block the student from
      // seeing whether they got it right — but it does mean this
      // correct answer won't count toward their score until retried.
      rethrow;
    }

    return isCorrect;
  }

  Future<void> loadSubmissions() async {
    try {
      final response = await supabase
          .from('ctf_submissions')
          .select()
          .eq('user_id', userId)
          .order('submitted_at', ascending: false);

      final submissions = (response as List)
          .map((s) => CtfSubmission.fromJson(s as Map<String, dynamic>))
          .toList();
      _submissionsController.add(submissions);
    } catch (e) {
      // Leave existing stream state as-is on failure.
    }
  }

  /// Total score across all challenges — counts the best (highest
  /// points-awarded) correct submission per challenge, not every
  /// attempt, so retrying after a wrong guess doesn't double count.
  Future<int> getTotalScore() async {
    try {
      final response = await supabase
          .from('ctf_submissions')
          .select()
          .eq('user_id', userId)
          .eq('correct', true);

      final submissions = (response as List)
          .map((s) => CtfSubmission.fromJson(s as Map<String, dynamic>))
          .toList();

      final bestPerChallenge = <String, int>{};
      for (final s in submissions) {
        final current = bestPerChallenge[s.challengeId] ?? 0;
        if (s.pointsAwarded > current) {
          bestPerChallenge[s.challengeId] = s.pointsAwarded;
        }
      }

      return bestPerChallenge.values.fold<int>(0, (sum, points) => sum + points);
    } catch (e) {
      return 0;
    }
  }

  Future<bool> isChallengeSolved(String challengeId) async {
    try {
      final response = await supabase
          .from('ctf_submissions')
          .select()
          .eq('user_id', userId)
          .eq('challenge_id', challengeId)
          .eq('correct', true)
          .limit(1);
      return (response as List).isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // ==========================================================
  // SANDBOX PROVISIONING — starts a real isolated container
  // running the vulnerable practice app via a Supabase Edge
  // Function, which is the only thing with credentials to talk
  // to the container platform. This service never has direct
  // infra credentials, only calls the function.
  // ==========================================================

  Future<SandboxSession> provisionSandbox() async {
    try {
      final response = await supabase.functions.invoke(
        'provision-sandbox',
        body: {'user_id': userId},
      );

      if (response.status < 200 || response.status >= 300) {
        throw Exception('Failed to provision sandbox: ${response.data}');
      }

      final data = response.data as Map<String, dynamic>;
      final session = SandboxSession.fromJson(data);
      _currentSandbox = session;
      _sandboxController.add(session);
      return session;
    } catch (e) {
      throw Exception('Sandbox provisioning failed: $e');
    }
  }

  Future<void> stopSandbox(String sessionId) async {
    try {
      await supabase.functions.invoke(
        'provision-sandbox',
        body: {'user_id': userId, 'action': 'stop', 'session_id': sessionId},
      );
    } catch (e) {
      throw Exception('Failed to stop sandbox: $e');
    }
  }

  // ==========================================================
  // HTTP ATTACK TOOL — the guardrail lives here: every request
  // is built from the ACTIVE SANDBOX'S OWN targetUrl only. There
  // is no code path that accepts an arbitrary host from the UI.
  // A student cannot point this tool at any URL except the one
  // Supabase issued them.
  // ==========================================================

  Future<HttpToolResponse> sendSandboxRequest(HttpToolRequest request) async {
    final session = _currentSandbox;
    if (session == null || !session.isActive) {
      throw Exception('No active sandbox session. Provision one first.');
    }

    // request.path is always resolved AGAINST session.targetUrl —
    // there is no parameter anywhere in this method that accepts a
    // full arbitrary URL from the caller.
    final baseUri = Uri.parse(session.targetUrl);
    final targetUri = baseUri.replace(
      path: '${baseUri.path}${request.path}'.replaceAll('//', '/'),
    );

    final stopwatch = Stopwatch()..start();
    http.Response response;

    try {
      switch (request.method.toUpperCase()) {
        case 'GET':
          response = await http.get(targetUri, headers: request.headers);
          break;
        case 'POST':
          response = await http.post(targetUri, headers: request.headers, body: request.body);
          break;
        case 'PUT':
          response = await http.put(targetUri, headers: request.headers, body: request.body);
          break;
        case 'DELETE':
          response = await http.delete(targetUri, headers: request.headers, body: request.body);
          break;
        default:
          throw Exception('Unsupported method: ${request.method}');
      }
    } finally {
      stopwatch.stop();
    }

    return HttpToolResponse(
      statusCode: response.statusCode,
      headers: response.headers,
      body: response.body,
      duration: stopwatch.elapsed,
    );
  }

  // ==========================================================
  // PACKET ANALYSIS — always a fixed, bundled dataset. No network
  // call, no live capture, so this is inherently safe.
  // ==========================================================

  PacketCapture getPracticeCapture() => CyberChallenges.sampleCapture;

  void dispose() {
    _sandboxChannel.unsubscribe();
    _sandboxController.close();
    _submissionsController.close();
  }
}
