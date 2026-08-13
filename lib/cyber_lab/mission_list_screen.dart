import 'package:flutter/material.dart';
import 'mission_models.dart';
import 'mission_models_data.dart';
import 'mission_service.dart';
import 'mission_runner_screen.dart';

// ============================================================
// MISSION LIST SCREEN — browse guided missions by category
// ============================================================

class MissionListScreen extends StatefulWidget {
  final MissionService missionService;

  const MissionListScreen({super.key, required this.missionService});

  @override
  State<MissionListScreen> createState() => _MissionListScreenState();
}

class _MissionListScreenState extends State<MissionListScreen> {
  final Map<String, String> _statusCache = {}; // missionId -> 'not_started' | 'in_progress' | 'complete'
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatuses();
  }

  Future<void> _loadStatuses() async {
    setState(() => _isLoading = true);
    for (final mission in CyberMissions.all) {
      final progress = await widget.missionService.getProgress(mission.id);
      _statusCache[mission.id] = progress == null ? 'not_started' : progress.status;
    }
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _openMission(Mission mission) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MissionRunnerScreen(mission: mission, missionService: widget.missionService),
      ),
    );
    await _loadStatuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Missions'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: CyberMissions.all.length,
              itemBuilder: (context, i) => _buildMissionCard(CyberMissions.all[i]),
            ),
    );
  }

  Widget _buildMissionCard(Mission mission) {
    final status = _statusCache[mission.id] ?? 'not_started';
    final isComplete = status == 'complete';
    final isInProgress = status == 'in_progress';

    Color statusColor = Colors.grey;
    String statusLabel = 'Not Started';
    IconData statusIcon = Icons.circle_outlined;

    if (isComplete) {
      statusColor = Colors.green;
      statusLabel = 'Complete';
      statusIcon = Icons.check_circle;
    } else if (isInProgress) {
      statusColor = Colors.orange;
      statusLabel = 'In Progress';
      statusIcon = Icons.play_circle_outline;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        title: Text(mission.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mission.objective, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(mission.categoryLabel, style: const TextStyle(fontSize: 11, color: Colors.deepOrange)),
                  ),
                  const SizedBox(width: 8),
                  Icon(statusIcon, size: 14, color: statusColor),
                  const SizedBox(width: 4),
                  Text(statusLabel, style: TextStyle(fontSize: 11, color: statusColor, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _openMission(mission),
      ),
    );
  }
}
