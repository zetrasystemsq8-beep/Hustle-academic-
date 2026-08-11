import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cyber_models.dart';

// ============================================================
// CYBER SERVICE — CTF scoring, sandbox provisioning, the attack
// tool, terminal commands, and packet analysis all in one
// service, same pattern as BuildService carrying the whole
// Mobile Lab pipeline.
// ============================================================

class CyberService {
  final SupabaseClient supabase;
  final String userId;

  late final RealtimeChannel _sandboxChannel;
  final StreamController<SandboxSession> _sandboxController = StreamController<SandboxSession>.broadcast();
  final StreamController<List<CtfSubmission>> _submissionsController = StreamController<List<CtfSubmission>>.broadcast();
  final StreamController<List<TerminalCommand>> _commandsController = StreamController<List<TerminalCommand>>.broadcast();

  final Map<String, int> _attemptsByChallenge = {};
  SandboxSession? _currentSandbox;
  RealtimeChannel? _commandsChannel;

  CyberService({required this.supabase, required this.userId});

  Stream<SandboxSession> get sandboxStream => _sandboxController.stream;
  Stream<List<CtfSubmission>> get submissionsStream => _submissionsController.stream;
  Stream<List<TerminalCommand>> get commandsStream => _commandsController.stream;
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
  // CTF FLAG SUBMISSION
  // ==========================================================

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

      return bestPerChallenge.values.fold(0, (sum, points) => sum + points);
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
  // SANDBOX PROVISIONING
  // ==========================================================

  Future<SandboxSession> provisionSandbox() async {
    try {
      final response = await supabase.functions.invoke(
        'cyber-sandbox',
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
        'cyber-sandbox',
        body: {'user_id': userId, 'action': 'stop', 'session_id': sessionId},
      );
    } catch (e) {
      throw Exception('Failed to stop sandbox: $e');
    }
  }

  // ==========================================================
  // HTTP ATTACK TOOL
  // ==========================================================

  Future<HttpToolResponse> sendSandboxRequest(HttpToolRequest request) async {
    final session = _currentSandbox;
    if (session == null || !session.isActive) {
      throw Exception('No active sandbox session. Provision one first.');
    }

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
  // TERMINAL COMMANDS — curl, nmap, nikto against the sandbox
  // only. Client-side checks here are a first filter; the real
  // enforcement happens in the cyber-sandbox edge function.
  // ==========================================================

  void subscribeToCommands(String sessionId) {
    _commandsChannel?.unsubscribe();
    _commandsChannel = supabase
        .channel('sandbox_commands:session_id=eq.$sessionId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'sandbox_commands',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'session_id',
            value: sessionId,
          ),
          callback: (_) => _refreshCommands(sessionId),
        )
        .subscribe();
    _refreshCommands(sessionId);
  }

  Future<void> _refreshCommands(String sessionId) async {
    try {
      final response = await supabase
          .from('sandbox_commands')
          .select()
          .eq('session_id', sessionId)
          .order('created_at', ascending: true);
      final commands = (response as List)
          .map((c) => TerminalCommand.fromJson(c as Map<String, dynamic>))
          .toList();
      _commandsController.add(commands);
    } catch (e) {
      // leave stream as-is on failure
    }
  }

  Future<void> submitTerminalCommand({required String tool, required String args}) async {
    final session = _currentSandbox;
    if (session == null || !session.isActive) {
      throw Exception('No active sandbox session. Provision one first.');
    }
    if (!kAllowedTerminalTools.contains(tool)) {
      throw Exception('Tool "$tool" is not allowed.');
    }

    final response = await supabase.functions.invoke(
      'cyber-sandbox',
      body: {
        'user_id': userId,
        'action': 'submit_command',
        'session_id': session.id,
        'tool': tool,
        'args': args,
      },
    );

    if (response.status < 200 || response.status >= 300) {
      final data = response.data;
      final message = (data is Map && data['error'] != null) ? data['error'] : 'Command rejected';
      throw Exception(message);
    }
  }

  // ==========================================================
  // PACKET ANALYSIS
  // ==========================================================

  PacketCapture getPracticeCapture() => CyberChallenges.sampleCapture;

  void dispose() {
    _sandboxChannel.unsubscribe();
    _commandsChannel?.unsubscribe();
    _sandboxController.close();
    _submissionsController.close();
    _commandsController.close();
  }
}
