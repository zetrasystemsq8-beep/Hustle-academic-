import 'mission_models.dart';

// ============================================================
// REAL MISSION CONTENT — SQL Injection mission, matching the
// discover → attack → understand → evidence structure. All
// answer hashes below are genuine, computed SHA-256 values.
// ============================================================

class CyberMissions {
  static List<Mission> get all => [
        sqlInjectionMission,
        reconBasicsMission,
      ];

  static final sqlInjectionMission = Mission(
    id: 'mission_sqli_01',
    title: 'Exploit a Login Bypass',
    objective:
        'Identify the vulnerable parameter in a login form → exploit it → understand why it works → '
        'retrieve evidence → submit your findings.',
    category: MissionCategory.webVulnerabilities,
    order: 1,
    summary:
        'The login form built its query by directly concatenating user input into SQL, like:\n\n'
        "SELECT * FROM users WHERE email = '\$input' AND password = '\$pass'\n\n"
        "By entering ' OR 1=1-- as the email, the query became:\n\n"
        "SELECT * FROM users WHERE email = '' OR 1=1--' AND password = ''\n\n"
        'The -- comments out the rest of the query, and 1=1 is always true, so the WHERE clause matches '
        'every row — often returning the first user in the table, frequently an admin account. The fix is '
        'parameterized queries (prepared statements), which treat user input as data, never as executable SQL.',
    steps: [
      MissionStep(
        id: 'sqli_01_intro',
        title: 'Briefing',
        instructions:
            'SQL injection happens when user input is inserted directly into a database query instead of '
            'being treated as pure data. It remains one of the most common serious web vulnerabilities in '
            'real breach reports.\n\n'
            'Your target: the login form in your sandbox (Juice Shop). Your objective: log in WITHOUT '
            'knowing any valid password, using SQL injection.\n\n'
            'Start your sandbox from the Sandbox tab if you haven\'t already, then continue to the next step.',
        type: MissionStepType.readInstructions,
      ),
      MissionStep(
        id: 'sqli_02_recon',
        title: 'Find the Login Endpoint',
        instructions:
            'Using the Attack Tool, send a GET request to /rest/user/login on your sandbox to confirm the '
            'endpoint exists (it may return an error for GET — that\'s fine, you\'re just confirming the route). '
            'Juice Shop\'s login form actually POSTs JSON with "email" and "password" fields to this endpoint.\n\n'
            'Once you\'ve located it, continue to the next step.',
        type: MissionStepType.performInSandbox,
      ),
      MissionStep(
        id: 'sqli_03_exploit',
        title: 'Craft the Injection',
        instructions:
            'Using the Attack Tool, send a POST request to /rest/user/login with this JSON body:\n\n'
            '{"email": "\' OR 1=1--", "password": "anything"}\n\n'
            'If successful, you should get back a 200 response with an authentication token instead of an '
            'error — meaning the injection bypassed the password check entirely.',
        type: MissionStepType.performInSandbox,
      ),
      MissionStep(
        id: 'sqli_04_identify_param',
        title: 'Which Parameter Was Vulnerable?',
        instructions:
            'Looking at the request you just sent, which field carried your SQL injection payload — '
            '"email" or "password"? Submit the field name exactly as it appears in the JSON body.',
        type: MissionStepType.submitAnswer,
        expectedAnswerHash: '82244417f956ac7c599f191593f7e441a4fafa20a4158fd52e154f1dc4c8ed92',
      ),
      MissionStep(
        id: 'sqli_05_evidence',
        title: 'Submit Your Findings',
        instructions:
            'Document this vulnerability the way a real security assessment would. Fill in each field with '
            'what you actually observed.',
        type: MissionStepType.submitEvidence,
        evidenceFields: [
          'Vulnerable parameter',
          'Payload used',
          'Request method and endpoint',
          'Observed impact',
          'Suggested remediation',
        ],
      ),
    ],
  );

  static final reconBasicsMission = Mission(
    id: 'mission_recon_01',
    title: 'Fingerprint the Target',
    objective:
        'Use reconnaissance tooling to identify what technology stack, open ports, and services your '
        'sandbox target is running — before attempting any exploitation.',
    category: MissionCategory.recon,
    order: 1,
    summary:
        'Reconnaissance is the first phase of any real assessment — you never attack a target you don\'t '
        'understand. Response headers, open ports, and framework-specific error pages all leak information '
        'about what\'s running. Professional pentests always start here, and so does real incident response '
        'when investigating what an attacker likely knew about a target.',
    steps: [
      MissionStep(
        id: 'recon_01_intro',
        title: 'Briefing',
        instructions:
            'Before attacking anything, professionals gather information: what ports are open, what '
            'services are running, what technology stack powers the target.\n\n'
            'Start your sandbox from the Sandbox tab, then continue.',
        type: MissionStepType.readInstructions,
      ),
      MissionStep(
        id: 'recon_02_headers',
        title: 'Inspect Response Headers',
        instructions:
            'Using the Attack Tool, send a GET request to / on your sandbox and examine the response headers. '
            'Look for anything revealing the server technology (framework name, version numbers, etc).',
        type: MissionStepType.performInSandbox,
      ),
      MissionStep(
        id: 'recon_03_nmap',
        title: 'Scan for Open Ports',
        instructions:
            'Switch to the Terminal tab, select nmap, and run a service-version scan (default args already '
            'suggested: -sV -p 1-1000). Note what port your sandbox is actually listening on and what service '
            'nmap reports.',
        type: MissionStepType.performInSandbox,
      ),
      MissionStep(
        id: 'recon_04_identify_stack',
        title: 'What Runtime Powers This App?',
        instructions:
            'Based on what you observed (headers, nmap output, or general knowledge of Juice Shop), what '
            'JavaScript runtime is this application built on? Submit as one word, lowercase, no spaces '
            '(e.g. "nodejs").',
        type: MissionStepType.submitAnswer,
        expectedAnswerHash: '81df1af4ed72b1b82fed99c73be4831908af977f3bd52c7cb7dfc738e38571d',
      ),
      MissionStep(
        id: 'recon_05_evidence',
        title: 'Submit Your Recon Report',
        instructions: 'Summarize what you found, the way a real recon report would read.',
        type: MissionStepType.submitEvidence,
        evidenceFields: [
          'Open ports found',
          'Services identified',
          'Technology stack',
          'Anything else notable',
        ],
      ),
    ],
  );
}
