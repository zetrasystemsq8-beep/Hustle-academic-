import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'competition_models.dart';
import 'competition_service.dart';
import 'cyber_models.dart';
import 'cyber_service.dart';

// ============================================================
// DUEL SCREEN — both competitors see the same challenges and
// each other's live score via realtime. Flag verification is
// the same real SHA-256 check as CTF.
// ============================================================

class DuelScreen extends StatefulWidget {
  final String competitionId;
  final CyberService cyberService;

  const DuelScreen({super.key, required this.competitionId, required this.cyberService});

  @override
  State<DuelScreen> createState() => _DuelScreenState();
}

class _DuelScreenState extends State<DuelScreen> {
  late final CompetitionService _competitionService;
  final String _myUserId = Supabase.instance.client.auth.currentUser!.id;

  CyberCompetition? _competition;
  List<CtfChallenge> _challenges = [];
  int _currentIndex = 0;
  final _answerController = TextEditingController();
  bool? _lastCorrect;
  bool _isSubmitting = false;
  final Set<String> _solvedIds = {};

  @override
  void initState() {
    super.initState();
    _competitionService = CompetitionService(
      supabase: Supabase.instance.client,
      userId: _myUserId,
    );
    _init();
  }

  Future<void> _init() async {
    final competition = await _competitionService.getCompetition(widget.competitionId);
    if (competition == null) return;

    final challenges = competition.challengeIds
        .map((id) => CyberChallenges.all.where((c) => c.id == id).firstOrNull)
        .whereType<CtfChallenge>()
        .toList();

    _competitionService.subscribeToParticipants(widget.competitionId);

    if (mounted) {
      setState(() {
        _competition = competition;
        _challenges = challenges;
      });
    }
  }

  @override
  void dispose() {
    _answerController.dispose();
    _competitionService.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_challenges.isEmpty) return;
    final challenge = _challenges[_currentIndex];
    final answer = _answerController.text.trim();
    if (answer.isEmpty) return;

    setState(() => _isSubmitting = true);
    final correct = await _competitionService.submitAnswer(
      competitionId: widget.competitionId,
      challenge: challenge,
      guess: answer,
    );

    if (mounted) {
      setState(() {
        _lastCorrect = correct;
        _isSubmitting = false;
        if (correct) {
          _solvedIds.add(challenge.id);
          _answerController.clear();
        }
      });
    }

    if (correct && _currentIndex == _challenges.length - 1) {
      await _competitionService.markFinished(widget.competitionId);
    }
  }

  void _nextChallenge() {
    if (_currentIndex < _challenges.length - 1) {
      setState(() {
        _currentIndex++;
        _lastCorrect = null;
        _answerController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_competition == null || _challenges.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final challenge = _challenges[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Duel'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildDuelCodeBanner(),
          _buildScoreboard(),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Challenge ${_currentIndex + 1} of ${_challenges.length}',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text(challenge.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(challenge.briefing, style: const TextStyle(fontSize: 14, height: 1.5)),
                  if (challenge.attachedData != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(10)),
                      child: SelectableText(
                        challenge.attachedData!,
                        style: const TextStyle(color: Color(0xFF9CDCFE), fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  if (_solvedIds.contains(challenge.id))
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 8),
                          const Text('Solved! Waiting for opponent, or move on.', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  else ...[
                    TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        hintText: 'FLAG{...}',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onSubmitted: (_) => _submit(),
                    ),
                    if (_lastCorrect == false) ...[
                      const SizedBox(height: 10),
                      Text('Not quite — try again.', style: TextStyle(color: Colors.red.shade700, fontSize: 13)),
                    ],
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submit,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                        child: _isSubmitting
                            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Submit', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                  if (_currentIndex < _challenges.length - 1) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _nextChallenge,
                        child: const Text('Skip to next challenge'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDuelCodeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      color: Colors.deepOrange.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Duel code: ', style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
          SelectableText(widget.competitionId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildScoreboard() {
    return StreamBuilder<List<CompetitionParticipant>>(
      stream: _competitionService.participantsStream,
      builder: (context, snapshot) {
        final participants = snapshot.data ?? [];
        if (participants.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Waiting for an opponent to join with your duel code...'),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: participants.map((p) {
              final isMe = p.userId == _myUserId;
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.deepOrange.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isMe ? Colors.deepOrange.shade200 : Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Text(
                        isMe ? 'You' : (p.username ?? 'Opponent'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text('${p.score} pts', style: TextStyle(color: Colors.deepOrange.shade700, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('${p.challengesSolved} solved', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
