import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ============================================================
// LEADERBOARD SCREEN — ranks students by total CTF score, real
// data from the cyber_leaderboard view (sum of correct
// submissions' points_awarded, no fake numbers).
// ============================================================

class LeaderboardEntry {
  final String userId;
  final String username;
  final int totalScore;
  final int challengesSolved;

  const LeaderboardEntry({
    required this.userId,
    required this.username,
    required this.totalScore,
    required this.challengesSolved,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['user_id'] as String,
      username: json['username'] as String? ?? 'Anonymous',
      totalScore: (json['total_score'] as num?)?.toInt() ?? 0,
      challengesSolved: (json['challenges_solved'] as num?)?.toInt() ?? 0,
    );
  }
}

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<LeaderboardEntry> _entries = [];
  bool _isLoading = true;
  String? _error;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = Supabase.instance.client.auth.currentUser?.id;
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await Supabase.instance.client
          .from('cyber_leaderboard')
          .select()
          .order('total_score', ascending: false)
          .limit(50);

      final entries = (response as List)
          .map((e) => LeaderboardEntry.fromJson(e as Map<String, dynamic>))
          .toList();

      if (mounted) setState(() => _entries = entries);
    } catch (e) {
      if (mounted) setState(() => _error = 'Could not load the leaderboard. Pull down to try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!, style: TextStyle(color: Colors.red.shade700)))
                : _entries.isEmpty
                    ? Center(
                        child: Text(
                          'No one has scored yet — solve a challenge to be the first!',
                          style: TextStyle(color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _entries.length,
                        itemBuilder: (context, i) => _buildEntryCard(_entries[i], i + 1),
                      ),
      ),
    );
  }

  Widget _buildEntryCard(LeaderboardEntry entry, int rank) {
    final isMe = entry.userId == _currentUserId;

    Color rankColor = Colors.grey.shade400;
    if (rank == 1) rankColor = Colors.amber;
    if (rank == 2) rankColor = Colors.grey.shade500;
    if (rank == 3) rankColor = Colors.brown.shade400;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isMe ? Colors.deepOrange.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isMe ? Colors.deepOrange.shade200 : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: rank <= 3
                ? Icon(Icons.emoji_events, color: rankColor, size: 26)
                : Text('#$rank', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(entry.username, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    if (isMe) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(6)),
                        child: const Text('You', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ],
                  ],
                ),
                Text('${entry.challengesSolved} challenges solved', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Text('${entry.totalScore} pts', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepOrange)),
        ],
      ),
    );
  }
}
