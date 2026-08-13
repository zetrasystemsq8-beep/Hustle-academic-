import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'mission_models.dart';

// ============================================================
// MISSION SERVICE — tracks a student's progress through guided
// missions: starting, answer verification (same real SHA-256
// approach as CTF), evidence submission, and completion.
// ============================================================

class MissionService {
  final SupabaseClient supabase;
  final String userId;

  MissionService({required this.supabase, required this.userId});

  Future<MissionProgress?> getProgress(String missionId) async {
    try {
      final response = await supabase
          .from('mission_progress')
          .select()
          .eq('user_id', userId)
          .eq('mission_id', missionId)
          .maybeSingle();

      if (response == null) return null;
      return MissionProgress.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<MissionProgress> startMission(String missionId) async {
    final existing = await getProgress(missionId);
    if (existing != null) return existing;

    final progress = MissionProgress(
      id: '${DateTime.now().microsecondsSinceEpoch}_$userId',
      userId: userId,
      missionId: missionId,
      stepIndex: 0,
      completedSteps: const [],
      status: 'in_progress',
      startedAt: DateTime.now(),
    );

    await supabase.from('mission_progress').insert(progress.toJson());
    return progress;
  }

  /// Checks a student's answer against the step's expected hash —
  /// same verification principle as CTF flag checking: the real
  /// answer never ships in plaintext, only its hash does.
  bool checkAnswer(MissionStep step, String answer) {
    if (step.expectedAnswerHash == null) return false;
    final normalized = answer.trim().toLowerCase();
    final hash = sha256.convert(utf8.encode(normalized)).toString();
    return hash == step.expectedAnswerHash;
  }

  Future<MissionProgress> advanceStep({
    required Mission mission,
    required int stepIndex,
    Map<String, dynamic>? evidence,
  }) async {
    final current = await getProgress(mission.id) ?? await startMission(mission.id);

    final updatedCompleted = {...current.completedSteps, stepIndex}.toList()..sort();
    final isLastStep = stepIndex == mission.steps.length - 1;
    final nextStepIndex = isLastStep ? stepIndex : stepIndex + 1;
    final status = isLastStep ? 'complete' : 'in_progress';

    Map<String, dynamic>? mergedEvidence = current.evidence;
    if (evidence != null) {
      mergedEvidence = {...?current.evidence, mission.steps[stepIndex].id: evidence};
    }

    final updated = MissionProgress(
      id: current.id,
      userId: userId,
      missionId: mission.id,
      stepIndex: nextStepIndex,
      completedSteps: updatedCompleted,
      status: status,
      evidence: mergedEvidence,
      startedAt: current.startedAt,
      completedAt: isLastStep ? DateTime.now() : null,
    );

    await supabase.from('mission_progress').update(updated.toJson()).eq('id', current.id);
    return updated;
  }

  Future<List<MissionProgress>> getAllProgress() async {
    try {
      final response = await supabase.from('mission_progress').select().eq('user_id', userId);
      return (response as List).map((p) => MissionProgress.fromJson(p as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> isMissionComplete(String missionId) async {
    final progress = await getProgress(missionId);
    return progress?.status == 'complete';
  }
}
