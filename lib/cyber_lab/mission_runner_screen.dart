import 'package:flutter/material.dart';
import 'mission_models.dart';
import 'mission_service.dart';

// ============================================================
// MISSION RUNNER SCREEN — walks a student through a mission's
// steps: instructions, sandbox actions, answer checks, and
// evidence submission, in order.
// ============================================================

class MissionRunnerScreen extends StatefulWidget {
  final Mission mission;
  final MissionService missionService;

  const MissionRunnerScreen({super.key, required this.mission, required this.missionService});

  @override
  State<MissionRunnerScreen> createState() => _MissionRunnerScreenState();
}

class _MissionRunnerScreenState extends State<MissionRunnerScreen> {
  MissionProgress? _progress;
  bool _isLoading = true;

  final _answerController = TextEditingController();
  final Map<String, TextEditingController> _evidenceControllers = {};

  bool? _lastAnswerCorrect;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final progress = await widget.missionService.startMission(widget.mission.id);
    if (mounted) {
      setState(() {
        _progress = progress;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _answerController.dispose();
    for (final c in _evidenceControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  MissionStep get _currentStep => widget.mission.steps[_progress!.stepIndex];

  Future<void> _continueStep() async {
    setState(() => _isSubmitting = true);
    final updated = await widget.missionService.advanceStep(
      mission: widget.mission,
      stepIndex: _progress!.stepIndex,
    );
    if (mounted) {
      setState(() {
        _progress = updated;
        _isSubmitting = false;
        _lastAnswerCorrect = null;
        _answerController.clear();
      });
    }
  }

  Future<void> _submitAnswer() async {
    final answer = _answerController.text.trim();
    if (answer.isEmpty) return;

    final correct = widget.missionService.checkAnswer(_currentStep, answer);
    setState(() => _lastAnswerCorrect = correct);

    if (correct) {
      await _continueStep();
    }
  }

  Future<void> _submitEvidence() async {
    final evidence = <String, dynamic>{};
    for (final field in _currentStep.evidenceFields) {
      evidence[field] = _evidenceControllers[field]?.text.trim() ?? '';
    }

    final allFilled = evidence.values.every((v) => (v as String).isNotEmpty);
    if (!allFilled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in every field before submitting.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    final updated = await widget.missionService.advanceStep(
      mission: widget.mission,
      stepIndex: _progress!.stepIndex,
      evidence: evidence,
    );
    if (mounted) {
      setState(() {
        _progress = updated;
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _progress == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_progress!.status == 'complete') {
      return _buildCompletionScreen();
    }

    final step = _currentStep;
    final stepNumber = _progress!.stepIndex + 1;
    final totalSteps = widget.mission.steps.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mission.title),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: stepNumber / totalSteps,
            backgroundColor: Colors.grey.shade200,
            color: Colors.deepOrange,
            minHeight: 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Step $stepNumber of $totalSteps', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text(step.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text(step.instructions, style: const TextStyle(fontSize: 15, height: 1.5)),
                  const SizedBox(height: 24),
                  _buildStepAction(step),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepAction(MissionStep step) {
    switch (step.type) {
      case MissionStepType.readInstructions:
      case MissionStepType.performInSandbox:
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isSubmitting ? null : _continueStep,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            child: _isSubmitting
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        );

      case MissionStepType.submitAnswer:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                hintText: 'Your answer',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onSubmitted: (_) => _submitAnswer(),
            ),
            if (_lastAnswerCorrect == false) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                child: Text('Not quite — review the step and try again.', style: TextStyle(color: Colors.red.shade900, fontSize: 13)),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitAnswer,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        );

      case MissionStepType.submitEvidence:
        for (final field in step.evidenceFields) {
          _evidenceControllers.putIfAbsent(field, () => TextEditingController());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final field in step.evidenceFields) ...[
              Text(field, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: _evidenceControllers[field],
                maxLines: field.toLowerCase().contains('remediation') || field.toLowerCase().contains('impact') ? 3 : 1,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 14),
            ],
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitEvidence,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: _isSubmitting
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Submit Findings', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildCompletionScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mission.title),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 64),
            const SizedBox(height: 16),
            const Text('Mission Complete', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('What Happened', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(widget.mission.summary, style: const TextStyle(fontSize: 14, height: 1.6)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Missions'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
