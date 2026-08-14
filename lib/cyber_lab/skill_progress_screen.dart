import 'package:flutter/material.dart';
import 'cyber_models.dart';
import 'cyber_service.dart';
import 'mission_models.dart';
import 'mission_models_data.dart';
import 'mission_service.dart';

// ============================================================
// SKILL PROGRESS SCREEN — derives mastery per category from
// existing CTF submissions and mission completions. No new
// backend — pure computation over data that already exists.
// ============================================================

class SkillProgressScreen extends StatefulWidget {
  final CyberService cyberService;
  final MissionService missionService;

  const SkillProgressScreen({super.key, required this.cyberService, required this.missionService});

  @override
  State<SkillProgressScreen> createState() => _SkillProgressScreenState();
}

class _SkillProgressScreenState extends State<SkillProgressScreen> {
  bool _isLoading = true;
  final Map<String, _SkillStats> _statsByCategory = {};

  @override
  void initState() {
    super.initState();
    _compute();
  }

  Future<void> _compute() async {
    setState(() => _isLoading = true);

    final ctfByCategory = <CtfCategory, List<CtfChallenge>>{};
    for (final c in CyberChallenges.all) {
      ctfByCategory.putIfAbsent(c.category, () => []).add(c);
    }

    for (final entry in ctfByCategory.entries) {
      int solved = 0;
      for (final challenge in entry.value) {
        if (await widget.cyberService.isChallengeSolved(challenge.id)) solved++;
      }
      final label = entry.value.first.categoryLabel;
      _statsByCategory[label] = _SkillStats(solved: solved, total: entry.value.length);
    }

    final missionsByCategory = <MissionCategory, List<Mission>>{};
    for (final m in CyberMissions.all) {
      missionsByCategory.putIfAbsent(m.category, () => []).add(m);
    }

    for (final entry in missionsByCategory.entries) {
      int solved = 0;
      for (final mission in entry.value) {
        if (await widget.missionService.isMissionComplete(mission.id)) solved++;
      }
      final label = entry.value.first.categoryLabel;
      final existing = _statsByCategory[label];
      if (existing != null) {
        _statsByCategory[label] = _SkillStats(
          solved: existing.solved + solved,
          total: existing.total + entry.value.length,
        );
      } else {
        _statsByCategory[label] = _SkillStats(solved: solved, total: entry.value.length);
      }
    }

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Progress'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: _statsByCategory.entries.map((e) => _buildSkillCard(e.key, e.value)).toList(),
            ),
    );
  }

  Widget _buildSkillCard(String category, _SkillStats stats) {
    final progress = stats.total == 0 ? 0.0 : stats.solved / stats.total;
    final mastered = stats.total > 0 && stats.solved == stats.total;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(category, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
              if (mastered) const Icon(Icons.verified, color: Colors.green, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: mastered ? Colors.green : Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 6),
          Text('${stats.solved} / ${stats.total} mastered', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}

class _SkillStats {
  final int solved;
  final int total;
  const _SkillStats({required this.solved, required this.total});
}
