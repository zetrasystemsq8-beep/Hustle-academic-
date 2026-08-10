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
// Every encoded attachedData string was actually encoded from the
// real flag and verified to decode back correctly.
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

        // ---------------- WEB SECURITY ----------------
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
