/// Broad category used to group challenges in the Challenges screen
/// (e.g. filtering by "Layout" or "JavaScript Basics").
enum ChallengeCategory {
  htmlBasics,
  cssBasics,
  javascriptBasics,
  layout,
  fullPage,
}

/// Difficulty tier shown as a badge on each Challenge card.
enum ChallengeDifficulty {
  beginner,
  intermediate,
  advanced,
}

/// A single rule the [ChallengeValidatorService] checks for when the
/// learner submits their work. Kept declarative (rather than as raw code)
/// so validation logic lives in one auditable place and no challenge ever
/// ships a hidden "answer" inside its own data.
class ChallengeRule {
  /// Human-readable description shown to the student if this rule fails,
  /// e.g. "Your page must contain an <h1> heading".
  final String description;

  /// Machine-readable rule type consumed by the validator service, e.g.
  /// 'has_tag', 'has_css_property', 'has_js_function_call'.
  final String ruleType;

  /// Arbitrary parameters the validator needs to check this rule, e.g.
  /// {'tag': 'h1'} or {'property': 'display', 'value': 'flex'}.
  final Map<String, dynamic> params;

  const ChallengeRule({
    required this.description,
    required this.ruleType,
    this.params = const {},
  });
}

/// A single learning challenge presented to the student, e.g. "Create a
/// heading" or "Build a login page". Challenges never contain the answer
/// code — only a task description and a set of [ChallengeRule]s used to
/// verify the student's own submission.
class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final ChallengeCategory category;
  final ChallengeDifficulty difficulty;

  /// Rules the learner's project must satisfy to pass this challenge.
  final List<ChallengeRule> rules;

  /// Optional starter file contents (may be empty strings for a fully
  /// blank start, per "no dummy placeholders" — used only when a
  /// challenge genuinely requires pre-existing markup to modify, e.g.
  /// "fix the broken button").
  final Map<String, String> starterFiles;

  const ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.rules,
    this.starterFiles = const {},
  });
}
