import 'package:flutter/foundation.dart';
import '../models/challenge_model.dart';
import '../models/project_model.dart';
import '../services/challenge_validator_service.dart';

/// Drives the Challenges screen: listing available challenges, tracking
/// which ones a project has completed, and running validation when the
/// student submits their work.
class ChallengeController extends ChangeNotifier {
  final ChallengeValidatorService _validatorService;
  final List<ChallengeModel> _allChallenges;

  ChallengeController({
    required ChallengeValidatorService validatorService,
    required List<ChallengeModel> allChallenges,
  })  : _validatorService = validatorService,
        _allChallenges = allChallenges;

  ChallengeValidationResult? _lastResult;
  bool _isValidating = false;

  List<ChallengeModel> get allChallenges => List.unmodifiable(_allChallenges);

  ChallengeValidationResult? get lastResult => _lastResult;
  bool get isValidating => _isValidating;

  List<ChallengeModel> byCategory(ChallengeCategory category) =>
      _allChallenges.where((c) => c.category == category).toList();

  ChallengeModel? findById(String id) {
    try {
      return _allChallenges.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Runs validation for [challenge] against [project]'s current files,
  /// then stores the result for the UI to render pass/fail feedback.
  /// If the challenge passes and isn't already recorded as complete for
  /// this project, it's added to the project's completed list.
  Future<ChallengeValidationResult> validate(
    ProjectModel project,
    ChallengeModel challenge,
  ) async {
    _isValidating = true;
    notifyListeners();

    final result = _validatorService.validate(project, challenge);

    if (result.passed && !project.completedChallengeIds.contains(challenge.id)) {
      project.completedChallengeIds.add(challenge.id);
    }

    _lastResult = result;
    _isValidating = false;
    notifyListeners();
    return result;
  }

  bool isCompleted(ProjectModel project, String challengeId) =>
      project.completedChallengeIds.contains(challengeId);

  double progressForProject(ProjectModel project) {
    if (_allChallenges.isEmpty) return 0;
    final completed = _allChallenges
        .where((c) => project.completedChallengeIds.contains(c.id))
        .length;
    return completed / _allChallenges.length;
  }

  /// Clears the last validation result, e.g. when the student navigates
  /// away from a challenge or edits their code again.
  void clearResult() {
    _lastResult = null;
    notifyListeners();
  }
}
