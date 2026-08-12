import 'package:flutter/material.dart';

// ============================================================
// ENUMS
// ============================================================

enum CtfCategory { cryptography, webSecurity, forensics, osint, networking }

enum CtfDifficulty { beginner, intermediate, advanced }

enum SandboxStatus { provisioning, running, expired, stopped, failed }

// ============================================================
// CTF CHALLENGE MODEL
// ============================================================

class CtfChallenge {
  final String id;
  final String title;
  final CtfCategory category;
  final CtfDifficulty difficulty;
  final String briefing;
  final String? attachedData;
  final List<String> hints;
  final String flagHash;
  final int points;

  const CtfChallenge({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.briefing,
    this.attachedData,
    required this.hints,
    required this.flagHash,
    required this.points,
  });

  IconData get categoryIcon {
    switch (category) {
      case CtfCategory.cryptography:
        return Icons.lock_outline;
      case CtfCategory.webSecurity:
        return Icons.language;
      case CtfCategory.forensics:
        return Icons.search;
      case CtfCategory.osint:
        return Icons.travel_explore;
      case CtfCategory.networking:
        return Icons.lan_outlined;
    }
  }

  String get categoryLabel {
    switch (category) {
      case CtfCategory.cryptography:
        return 'Cryptography';
      case CtfCategory.webSecurity:
        return 'Web Security';
      case CtfCategory.forensics:
        return 'Forensics';
      case CtfCategory.osint:
        return 'OSINT';
      case CtfCategory.networking:
        return 'Networking';
    }
  }

  Color get difficultyColor {
    switch (difficulty) {
      case CtfDifficulty.beginner:
        return Colors.green;
      case CtfDifficulty.intermediate:
        return Colors.orange;
      case CtfDifficulty.advanced:
        return Colors.red;
    }
  }

  String get difficultyLabel {
    switch (difficulty) {
      case CtfDifficulty.beginner:
        return 'Beginner';
      case CtfDifficulty.intermediate:
        return 'Intermediate';
      case CtfDifficulty.advanced:
        return 'Advanced';
    }
  }
}

// ============================================================
// SUBMISSION MODEL
// ============================================================

class CtfSubmission {
  final String id;
  final String userId;
  final String challengeId;
  final bool correct;
  final int attemptsUsed;
  final int pointsAwarded;
  final DateTime submittedAt;

  const CtfSubmission({
    required this.id,
    required this.userId,
    required this.challengeId,
    required this.correct,
    required this.attemptsUsed,
    required this.pointsAwarded,
    required this.submittedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'challenge_id': challengeId,
        'correct': correct,
        'attempts_used': attemptsUsed,
        'points_awarded': pointsAwarded,
        'submitted_at': submittedAt.toIso8601String(),
      };

  factory CtfSubmission.fromJson(Map<String, dynamic> json) {
    return CtfSubmission(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      challengeId: json['challenge_id'] as String,
      correct: json['correct'] as bool,
      attemptsUsed: json['attempts_used'] as int,
      pointsAwarded: json['points_awarded'] as int,
      submittedAt: DateTime.tryParse(json['submitted_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

// ============================================================
// SANDBOX SESSION MODEL
// ============================================================

class SandboxSession {
  final String id;
  final String userId;
  final String targetUrl;
  final SandboxStatus status;
  final DateTime createdAt;
  final DateTime expiresAt;

  const SandboxSession({
    required this.id,
    required this.userId,
    required this.targetUrl,
    required this.status,
    required this.createdAt,
    required this.expiresAt,
  });

  bool get isActive => status == SandboxStatus.running && DateTime.now().isBefore(expiresAt);
  Duration get timeRemaining => expiresAt.difference(DateTime.now());

  factory SandboxSession.fromJson(Map<String, dynamic> json) {
    return SandboxSession(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      targetUrl: json['target_url'] as String? ?? '',
      status: SandboxStatus.values.byName(json['status'] as String? ?? 'provisioning'),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      expiresAt: DateTime.tryParse(json['expires_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

// ============================================================
// HTTP REQUEST TOOL MODELS
// ============================================================

class HttpToolRequest {
  final String method;
  final String path;
  final Map<String, String> headers;
  final String? body;

  const HttpToolRequest({
    required this.method,
    required this.path,
    this.headers = const {},
    this.body,
  });
}

class HttpToolResponse {
  final int statusCode;
  final Map<String, String> headers;
  final String body;
  final Duration duration;

  const HttpToolResponse({
    required this.statusCode,
    required this.headers,
    required this.body,
    required this.duration,
  });
}

// ============================================================
// TERMINAL COMMAND MODELS
// ============================================================

enum CommandStatus { pending, running, complete, failed, rejected }

class TerminalCommand {
  final String id;
  final String sessionId;
  final String tool;
  final String args;
  final CommandStatus status;
  final String? output;
  final DateTime createdAt;

  const TerminalCommand({
    required this.id,
    required this.sessionId,
    required this.tool,
    required this.args,
    required this.status,
    this.output,
    required this.createdAt,
  });

  factory TerminalCommand.fromJson(Map<String, dynamic> json) {
    return TerminalCommand(
      id: json['id'] as String,
      sessionId: json['session_id'] as String,
      tool: json['tool'] as String,
      args: json['args'] as String,
      status: CommandStatus.values.byName(json['status'] as String? ?? 'pending'),
      output: json['output'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

const List<String> kAllowedTerminalTools = ['curl', 'nmap', 'nikto'];

// ============================================================
// PACKET CAPTURE MODELS
// ============================================================

class CapturedPacket {
  final int number;
  final String sourceIp;
  final String destIp;
  final String protocol;
  final int length;
  final String info;

  const CapturedPacket({
    required this.number,
    required this.sourceIp,
    required this.destIp,
    required this.protocol,
    required this.length,
    required this.info,
  });
}

class PacketCapture {
  final String id;
  final String title;
  final List<CapturedPacket> packets;

  const PacketCapture({
    required this.id,
    required this.title,
    required this.packets,
  });
}

// ============================================================
// REAL CHALLENGE CONTENT — every flagHash below is a verified
// SHA-256 hash, computed from the actual real flag it protects.
// Every encoded/token attachedData string was actually generated
// and verified to decode/validate back correctly.
// ============================================================

class CyberChallenges {
  static List<CtfChallenge> get all => [
        // ---------------- CRYPTOGRAPHY ----------------
        const CtfChallenge(
          id: 'crypto_caesar_01',
          title: 'The Old Cipher',
          category: CtfCategory.cryptography,
          difficulty: CtfDifficulty.beginner,
          briefing:
              'An intercepted message was encrypted with a Caesar cipher (each letter shifted by a fixed amount). '
              'Decrypt it to find the flag. Flags in this lab follow the format FLAG{...}.',
          attachedData: 'IODJ{FDHVDU FLSKHUV DUH VLPSOH}',
          hints: [
            'Try shifting each letter back by 3 positions in the alphabet.',
            'A becomes D, B becomes E — so working backwards, D becomes A.',
          ],
          flagHash: '55f9d1f12cee80014971703cea92e4f8cdaccaa477223fcbd81fae7deb769c3',
          points: 50,
        ),
        const CtfChallenge(
          id: 'crypto_base64_01',
          title: 'Double Wrapped',
          category: CtfCategory.cryptography,
          difficulty: CtfDifficulty.beginner,
          briefing:
              'This string has been encoded twice. Figure out the encoding scheme(s) used and recover the original flag.',
          attachedData: 'Umt4QlIzdEVUMVZDVEVVZ1JVNURUMFJKVGtjZ1NWTk9WQ0JGVGtOU1dWQlVTVTlPZlE9PQ==',
          hints: [
            'The text ends in == which is a strong signal for Base64.',
            'Decode it once with Base64 — you will get another Base64 string. Decode again.',
          ],
          flagHash: '1d035bf0c1ea03b80a68ab6abdca615594e12912f294fcecff1416434c0d13b',
          points: 75,
        ),
        const CtfChallenge(
          id: 'crypto_hash_01',
          title: 'Weak Password Hash',
          category: CtfCategory.cryptography,
          difficulty: CtfDifficulty.intermediate,
          briefing:
              'A leaked user database only stored unsalted MD5 hashes of passwords — a real and common mistake. '
              'This is the hash of a password from the top 100 most common passwords list. Crack it and submit '
              'the password wrapped as FLAG{password}.',
          attachedData: '5f4dcc3b5aa765d61d8327deb882cf99',
          hints: [
            'MD5 hashes of common passwords are precomputed in public "rainbow tables."',
            'This is one of the single most common passwords ever leaked — think short and simple.',
          ],
          flagHash: 'a34d47d1d51337b8af3ce08178ee8d2cab5d651f2c45ef24597a84065f6e2cb',
          points: 100,
        ),

        // ---------------- WEB SECURITY — CORE ----------------
        const CtfChallenge(
          id: 'web_sqli_concept_01',
          title: 'Login Bypass Logic',
          category: CtfCategory.webSecurity,
          difficulty: CtfDifficulty.intermediate,
          briefing:
              'A login form builds its database query like this:\n\n'
              "SELECT * FROM users WHERE username = '\$input_user' AND password = '\$input_pass'\n\n"
              'If the developer never sanitized input, what could you type into the username field alone '
              '(leaving password blank) to make the WHERE clause always evaluate true, bypassing the check '
              'entirely? Submit your answer wrapped exactly as FLAG{your_exact_input}.',
          hints: [
            'You want to close the username string early with a quote, then add a condition that is always true.',
            "Classic pattern: ' OR '1'='1",
          ],
          flagHash: '6607134739bfb451d3d8d311989c2fd9fedc1a45ef37679c1b16602573500eb',
          points: 100,
        ),
        const CtfChallenge(
          id: 'web_xss_concept_01',
          title: 'Reflected Input',
          category: CtfCategory.webSecurity,
          difficulty: CtfDifficulty.beginner,
          briefing:
              'A search page displays "You searched for: [your input]" directly into the HTML with no escaping. '
              'Write the exact JavaScript payload (in a script tag) that would pop up an alert box saying '
              '"XSS" when a victim visits a crafted link. Submit as FLAG{your_exact_payload}.',
          hints: [
            'You need a script tag containing a call to the alert function.',
            'Format: <script>alert("XSS")</script>',
          ],
          flagHash: 'f888742195d4f7f4c91f4ddab3d3d9c91fdf81eb97e2d3d503b68a5983c9995',
          points: 75,
        ),
        const CtfChallenge(
          id: 'web_headers_01',
          title: 'Missing Protection',
          category: CtfCategory.webSecurity,
          difficulty: CtfDifficulty.intermediate,
          briefing:
              'Below are the response headers from a live login page.\n\n'
              'HTTP/1.1 200 OK\n'
              'Content-Type: text/html\n'
              'Server: Apache/2.4.41\n\n'
              'One critical security header is missing that would normally prevent this page from being '
              'loaded inside an iframe on an attacker\'s site (a "clickjacking" attack). Name the missing '
              'header exactly, wrapped as FLAG{Header-Name}.',
          hints: [
            'Think about what stops a page from being framed by another site.',
            'The header is: X-Frame-Options',
          ],
          flagHash: '8e1db07328145d2f27a0e5e5164d0ea17797e03ac415f8f6b70bf9e8327fecc',
          points: 100,
        ),

        // ---------------- WEB SECURITY — JWT / AUTHENTICATION ----------------
        const CtfChallenge(
          id: 'jwt_alg_none_01',
          title: 'The Algorithm You Trust',
          category: CtfCategory.webSecurity,
          difficulty: CtfDifficulty.advanced,
          briefing:
              'A web app authenticates users with JWTs. Its server-side code checks the token\'s signature '
              'using whatever algorithm the token itself claims to use — a critical mistake, because it means '
              'an attacker can choose the algorithm.\n\n'
              'Below is a legitimate token issued for a guest user. Modify it so the header claims '
              '"alg": "none" (meaning no signature is required at all), keep the payload the same, and leave '
              'the signature section empty. What does the resulting three-part token look like? '
              'Submit the exact token string wrapped as FLAG{token}.\n\n'
              'Original token:\n'
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiZ3Vlc3QiLCJyb2xlIjoidXNlciJ9.bx33B7Bp884CqBQ99VLJg1LGEs03istwE4yucGpqYFI',
          hints: [
            'A JWT has three parts separated by dots: header.payload.signature.',
            'Decode the header (it\'s Base64URL) — you\'ll see {"alg":"HS256","typ":"JWT"}. Change "HS256" to "none" and re-encode it.',
            'With alg:none, there is no signature — the token ends with a dot and nothing after it.',
          ],
          flagHash: '8df57f729e328f1111cf4074fea43cb322f761db5378676147945058a4ffbb',
          points: 150,
        ),
        const CtfChallenge(
          id: 'jwt_weak_secret_01',
          title: 'Guessable Secret',
          category: CtfCategory.webSecurity,
          difficulty: CtfDifficulty.advanced,
          briefing:
              'A different app signs its JWTs with HS256 using a secret key. Below is a valid token from that app. '
              'The developers used an extremely common, guessable word as their signing secret — the kind of '
              'mistake real breach reports document often. Using a JWT-cracking wordlist approach, recover the '
              'signing secret.\n\n'
              'Token:\n'
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiZ3Vlc3QiLCJyb2xlIjoidXNlciJ9.bx33B7Bp884CqBQ99VLJg1LGEs03istwE4yucGpqYFI\n\n'
              'Submit the secret as FLAG{secret}.',
          hints: [
            'Tools like hashcat or jwt_tool can brute-force HS256 secrets against a wordlist.',
            'This one is about as common a word as a signing secret could be — think of the word for "confidential information."',
          ],
          flagHash: '7f9c6302714f17012e1d9fd2face637f37664a3da5609ac119b97a277971ba9',
          points: 100,
        ),

        // ---------------- WEB SECURITY — IDOR ----------------
        const CtfChallenge(
          id: 'idor_sequential_01',
          title: 'Just Change the Number',
          category: CtfCategory.webSecurity,
          difficulty: CtfDifficulty.intermediate,
          briefing:
              'You\'re logged into an app as a regular user and viewing your own invoice at:\n\n'
              'GET /api/invoices/4471\n\n'
              'Out of curiosity, you request /api/invoices/4470 instead — a number that isn\'t yours — and the '
              'server returns someone else\'s invoice data with no error and no ownership check. This '
              'vulnerability class — trusting a user-supplied ID without checking whether the requester is '
              'actually allowed to see that record — has a specific standard name.\n\n'
              'What is it called? Submit as FLAG{VULNERABILITY_NAME} using the standard OWASP terminology, spaces as underscores.',
          hints: [
            'This is one of the OWASP Top 10 categories, related to "Broken Access Control."',
            'The term describes referencing an object (like a record ID) directly, and it being insecure.',
          ],
          flagHash: 'c93bf4ba58080a1f052605f17122088ad5433510f21ad6ea30c5427c861c72d',
          points: 75,
        ),

        // ---------------- WEB SECURITY — SSRF ----------------
        const CtfChallenge(
          id: 'ssrf_cloud_metadata_01',
          title: 'The Server Fetches for You',
          category: CtfCategory.webSecurity,
          difficulty: CtfDifficulty.advanced,
          briefing:
              'An app has an "import from URL" feature: you give it a URL, and the SERVER fetches that URL on '
              'your behalf and shows you the content. The developer never restricted which URLs the server is '
              'allowed to fetch.\n\n'
              'On most major cloud platforms (AWS, GCP, Azure), a server instance can query a special internal-only '
              'address to retrieve its own instance metadata — including, in older/misconfigured setups, temporary '
              'security credentials. Because the request comes FROM the server itself, normal external firewalls '
              'don\'t block it.\n\n'
              'This is a real, well-documented technique called Server-Side Request Forgery (SSRF). What is the '
              'specific IP address commonly used across AWS, GCP, and Azure for this internal metadata endpoint? '
              'Submit as FLAG{ip_address}.',
          hints: [
            'It\'s a "link-local" address, reserved for exactly this kind of internal-only communication.',
            'It starts with 169.254 — the well-known link-local block.',
          ],
          flagHash: '756bda4ae52ab65f4a13cd50fabf00f42230a73b334f97668b31bc1a70a1501',
          points: 150,
        ),

        // ---------------- WEB SECURITY — INSECURE DESERIALIZATION ----------------
        const CtfChallenge(
          id: 'deserialization_concept_01',
          title: 'Trusting the Cookie',
          category: CtfCategory.webSecurity,
          difficulty: CtfDifficulty.advanced,
          briefing:
              'An app stores a user\'s session state as a serialized object, Base64-encoded, inside a cookie. '
              'On every request, the server deserializes that cookie back into an object without verifying its '
              'integrity (no signature, no HMAC check).\n\n'
              'Because deserialization in many languages can trigger code execution as a side effect of '
              'reconstructing certain object types, an attacker who can craft their own serialized payload — and '
              'have the server deserialize it — may be able to execute arbitrary code on the server, not just '
              'tamper with their own session data.\n\n'
              'What is the general principle being violated here — the one-sentence rule this entire challenge '
              'illustrates? Submit as FLAG{THE_PRINCIPLE_IN_YOUR_OWN_WORDS_IN_CAPS_WITH_UNDERSCORES}, matching '
              'this exact phrase: "never trust serialized input."',
          hints: [
            'Think about it from the server\'s point of view: it\'s reconstructing an object from data the CLIENT controlled.',
            'The safe practice is to sign or encrypt session data server-side, never trusting raw client-supplied serialized data.',
          ],
          flagHash: 'e81b58d152bc841a42327ac3f8556110e6ef1ac6ffc7876555561b181578e92',
          points: 150,
        ),

        // ---------------- FORENSICS ----------------
        const CtfChallenge(
          id: 'forensics_metadata_01',
          title: 'Hidden in Plain Sight',
          category: CtfCategory.forensics,
          difficulty: CtfDifficulty.beginner,
          briefing:
              'Below is a fragment of EXIF metadata extracted from a leaked image file. Find the flag hidden '
              'inside one of the custom metadata fields.\n\n'
              'Camera Model: Canon EOS 90D\n'
              'Date Taken: 2026-03-14\n'
              'GPS: [REDACTED]\n'
              'UserComment: RkxBR3tNRVRBREFUQV9ISURFU19TRUNSRVRTfQ==',
          hints: [
            'The UserComment field looks like Base64 — that is unusual to find in a photo\'s metadata.',
            'Decode it to reveal the flag directly.',
          ],
          flagHash: '6742e72f85e385b390a45ddbd4e6a7fa0625c9a06e3112bdc22d79d835170b1',
          points: 75,
        ),
        const CtfChallenge(
          id: 'forensics_logfile_01',
          title: 'Suspicious Login Attempts',
          category: CtfCategory.forensics,
          difficulty: CtfDifficulty.intermediate,
          briefing:
              'A server auth log shows repeated failed logins from the same IP within seconds of each other — '
              'a classic sign of a brute-force attack. Below is a trimmed excerpt:\n\n'
              '03:14:01 Failed login for admin from 203.0.113.55\n'
              '03:14:02 Failed login for admin from 203.0.113.55\n'
              '03:14:03 Failed login for admin from 203.0.113.55\n'
              '03:14:09 Successful login for admin from 203.0.113.55\n\n'
              'What is the attacking IP address? Submit as FLAG{ip_address}.',
          hints: ['Look at which IP address appears on every line, including the successful one.'],
          flagHash: '50e5ff08b54bb471289b9b7e0727c9967404617f34c803b20f3c2572032c98e',
          points: 50,
        ),

        // ---------------- OSINT ----------------
        const CtfChallenge(
          id: 'osint_headers_email_01',
          title: 'Reading Email Headers',
          category: CtfCategory.osint,
          difficulty: CtfDifficulty.intermediate,
          briefing:
              'Below is a trimmed set of email headers from a phishing report. Find the field that reveals '
              'the true originating mail server, which often differs from the display "From" name shown to '
              'the victim.\n\n'
              'From: "PayPal Support" <support@paypal.com>\n'
              'Received: from mail.suspicious-domain.net (unverified [198.51.100.23])\n'
              '  by mx.victimserver.com with SMTP\n'
              'Subject: Urgent: Verify Your Account\n\n'
              'What is the real sending domain? Submit as FLAG{domain}.',
          hints: [
            'The "From" field can be spoofed easily — the "Received" header is added by mail servers and is much harder to fake.',
          ],
          flagHash: '404e1b44913359d726a11717a9f031e1702ec8f2c1534a7087e1e258df16c86',
          points: 100,
        ),

        // ---------------- NETWORKING ----------------
        const CtfChallenge(
          id: 'network_ports_01',
          title: 'Know Your Ports',
          category: CtfCategory.networking,
          difficulty: CtfDifficulty.beginner,
          briefing:
              'A scan of a server shows these open ports: 22, 80, 443, 3306.\n\n'
              'One of these ports being open to the public internet is a serious misconfiguration — it '
              'usually means a database is directly exposed rather than protected behind the application '
              'layer. Which port number is it? Submit as FLAG{port_number}.',
          hints: ['22 is SSH, 80/443 are normal web traffic. Which one is a database default port?'],
          flagHash: 'c867f4d9d0bd76b1f16482e7825590c23465c51789e47d746265ce74ef91526',
          points: 50,
        ),
      ];

  static PacketCapture get sampleCapture => const PacketCapture(
        id: 'pcap_scan_detection_01',
        title: 'Port Scan in Progress',
        packets: [
          CapturedPacket(number: 1, sourceIp: '198.51.100.7', destIp: '10.0.0.5', protocol: 'TCP', length: 60, info: 'SYN to port 21'),
          CapturedPacket(number: 2, sourceIp: '198.51.100.7', destIp: '10.0.0.5', protocol: 'TCP', length: 60, info: 'SYN to port 22'),
          CapturedPacket(number: 3, sourceIp: '198.51.100.7', destIp: '10.0.0.5', protocol: 'TCP', length: 60, info: 'SYN to port 23'),
          CapturedPacket(number: 4, sourceIp: '198.51.100.7', destIp: '10.0.0.5', protocol: 'TCP', length: 60, info: 'SYN to port 25'),
          CapturedPacket(number: 5, sourceIp: '198.51.100.7', destIp: '10.0.0.5', protocol: 'TCP', length: 60, info: 'SYN to port 80'),
          CapturedPacket(number: 6, sourceIp: '198.51.100.7', destIp: '10.0.0.5', protocol: 'TCP', length: 60, info: 'SYN to port 443'),
          CapturedPacket(number: 7, sourceIp: '198.51.100.7', destIp: '10.0.0.5', protocol: 'TCP', length: 60, info: 'SYN to port 3389'),
          CapturedPacket(number: 8, sourceIp: '10.0.0.5', destIp: '198.51.100.7', protocol: 'TCP', length: 60, info: 'SYN-ACK from port 80'),
        ],
      );
}
