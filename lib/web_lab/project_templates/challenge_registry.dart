import '../models/challenge_model.dart';

/// Static registry of all learning challenges available in the
/// Challenges screen. Every challenge is declarative — a description and
/// a set of [ChallengeRule]s — never a hidden answer, per requirements.
class ChallengeRegistry {
  ChallengeRegistry._();

  static final List<ChallengeModel> all = [
    const ChallengeModel(
      id: 'create_heading',
      title: 'Create a Heading',
      description: 'Add an <h1> heading to your index.html with any text inside it.',
      category: ChallengeCategory.htmlBasics,
      difficulty: ChallengeDifficulty.beginner,
      rules: [
        ChallengeRule(description: 'Your page must contain an <h1> element.', ruleType: 'has_tag', params: {'tag': 'h1'}),
      ],
    ),
    const ChallengeModel(
      id: 'create_button',
      title: 'Create a Button',
      description: 'Add a <button> element to your index.html.',
      category: ChallengeCategory.htmlBasics,
      difficulty: ChallengeDifficulty.beginner,
      rules: [
        ChallengeRule(description: 'Your page must contain a <button> element.', ruleType: 'has_tag', params: {'tag': 'button'}),
      ],
    ),
    const ChallengeModel(
      id: 'center_a_div',
      title: 'Center a Div',
      description: 'Add a <div> to your HTML and use CSS to center it using flexbox.',
      category: ChallengeCategory.layout,
      difficulty: ChallengeDifficulty.intermediate,
      rules: [
        ChallengeRule(description: 'Your page must contain a <div> element.', ruleType: 'has_tag', params: {'tag': 'div'}),
        ChallengeRule(description: 'Your CSS must set display: flex.', ruleType: 'has_css_property', params: {'property': 'display', 'value': 'flex'}),
        ChallengeRule(description: 'Your CSS must set justify-content.', ruleType: 'has_css_property', params: {'property': 'justify-content'}),
      ],
    ),
    const ChallengeModel(
      id: 'log_to_console',
      title: 'Log to the Console',
      description: 'Use console.log() in your script.js to print a message.',
      category: ChallengeCategory.javascriptBasics,
      difficulty: ChallengeDifficulty.beginner,
      rules: [
        ChallengeRule(description: 'Your script.js must call console.log().', ruleType: 'has_js_function_call', params: {'function': 'console.log'}),
      ],
    ),
    const ChallengeModel(
      id: 'build_login_page',
      title: 'Build a Login Page',
      description: 'Create a form with a username field, a password field, and a submit button.',
      category: ChallengeCategory.fullPage,
      difficulty: ChallengeDifficulty.intermediate,
      rules: [
        ChallengeRule(description: 'Your page must contain a <form>.', ruleType: 'has_tag', params: {'tag': 'form'}),
        ChallengeRule(description: 'Your page must contain at least one <input>.', ruleType: 'has_tag', params: {'tag': 'input'}),
        ChallengeRule(description: 'Your page must contain a <button>.', ruleType: 'has_tag', params: {'tag': 'button'}),
      ],
    ),
    const ChallengeModel(
      id: 'build_portfolio',
      title: 'Build a Portfolio',
      description: 'Create a page with a heading, at least one section, and some styling.',
      category: ChallengeCategory.fullPage,
      difficulty: ChallengeDifficulty.advanced,
      rules: [
        ChallengeRule(description: 'Your page must contain an <h1>.', ruleType: 'has_tag', params: {'tag': 'h1'}),
        ChallengeRule(description: 'Your page must contain a <section>.', ruleType: 'has_tag', params: {'tag': 'section'}),
        ChallengeRule(description: 'Your CSS must not be empty.', ruleType: 'min_length', params: {'target': 'css', 'min': 20}),
      ],
    ),
    const ChallengeModel(
      id: 'build_landing_page',
      title: 'Build a Landing Page',
      description: 'Create a landing page with a heading, a paragraph, and a call-to-action button.',
      category: ChallengeCategory.fullPage,
      difficulty: ChallengeDifficulty.advanced,
      rules: [
        ChallengeRule(description: 'Your page must contain an <h1>.', ruleType: 'has_tag', params: {'tag': 'h1'}),
        ChallengeRule(description: 'Your page must contain a <p>.', ruleType: 'has_tag', params: {'tag': 'p'}),
        ChallengeRule(description: 'Your page must contain a <button>.', ruleType: 'has_tag', params: {'tag': 'button'}),
      ],
    ),
  ];
}
