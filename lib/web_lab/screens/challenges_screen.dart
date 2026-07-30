import 'package:flutter/material.dart';
import '../controllers/challenge_controller.dart';
import '../controllers/project_controller.dart';
import '../models/challenge_model.dart';
import '../project_templates/challenge_registry.dart';
import '../services/challenge_validator_service.dart';
import 'project_explorer_screen.dart';

/// Lists all learning challenges and lets the student validate their
/// current project's code against a selected challenge's rules. Never
/// generates or reveals the answer — only pass/fail feedback per rule.
class ChallengesScreen extends StatefulWidget {
  final ProjectController projectController;

  const ChallengesScreen({super.key, required this.projectController});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  late final ChallengeController _challengeController;

  @override
  void initState() {
    super.initState();
    _challengeController = ChallengeController(
      validatorService: ChallengeValidatorService(),
      allChallenges: ChallengeRegistry.all,
    );
  }

  Future<void> _validate(ChallengeModel challenge) async {
    final project = widget.projectController.currentProject;
    if (project == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Open a project first to attempt this challenge.')),
      );
      return;
    }

    final result = await _challengeController.validate(project, challenge);
    await widget.projectController.saveCurrentProject();
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result.passed ? 'Challenge Passed! 🎉' : 'Not quite yet'),
        content: result.passed
            ? const Text('Great work — your code met every requirement.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: result.failedDescriptions
                    .map((d) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.close, size: 16, color: Colors.red),
                              const SizedBox(width: 6),
                              Expanded(child: Text(d)),
                            ],
                          ),
                        ))
                    .toList(),
              ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  Color _difficultyColor(ChallengeDifficulty difficulty) {
    switch (difficulty) {
      case ChallengeDifficulty.beginner:
        return Colors.green;
      case ChallengeDifficulty.intermediate:
        return Colors.orange;
      case ChallengeDifficulty.advanced:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.projectController.currentProject;

    return Scaffold(
      appBar: AppBar(title: const Text('Learning Challenges')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _challengeController.allChallenges.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final challenge = _challengeController.allChallenges[index];
          final completed = project != null && _challengeController.isCompleted(project, challenge.id);

          return Card(
            child: ListTile(
              leading: Icon(
                completed ? Icons.check_circle : Icons.circle_outlined,
                color: completed ? Colors.green : null,
              ),
              title: Text(challenge.title),
              subtitle: Text(challenge.description),
              trailing: Chip(
                label: Text(challenge.difficulty.name),
                backgroundColor: _difficultyColor(challenge.difficulty).withOpacity(0.15),
                labelStyle: TextStyle(color: _difficultyColor(challenge.difficulty)),
              ),
              onTap: () => _validate(challenge),
            ),
          );
        },
      ),
    );
  }
}
