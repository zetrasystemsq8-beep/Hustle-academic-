import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Status of a formal proposal — mirrors how real standards proposals
/// move through a lifecycle rather than just existing as a static doc.
enum RfcStatus { draft, underReview, accepted, rejected }

extension RfcStatusLabel on RfcStatus {
  String get label {
    switch (this) {
      case RfcStatus.draft:
        return 'Draft';
      case RfcStatus.underReview:
        return 'Under Review';
      case RfcStatus.accepted:
        return 'Accepted';
      case RfcStatus.rejected:
        return 'Rejected';
    }
  }
}

/// A formal proposal for a new idea — a CSS pattern, JS idiom, mini
/// language, or component API — written up *before* being built out,
/// the same way real standards and research proposals work. Deliberately
/// structured into named sections rather than one big text box, so
/// writing one forces the same discipline a real RFC does.
class RfcDocument {
  final String id;
  String title;
  String motivation;
  String design;
  String alternatives;
  String openQuestions;
  RfcStatus status;
  final String projectId;
  final DateTime createdAt;
  DateTime updatedAt;

  RfcDocument({
    required this.id,
    required this.title,
    required this.projectId,
    this.motivation = '',
    this.design = '',
    this.alternatives = '',
    this.openQuestions = '',
    this.status = RfcStatus.draft,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'projectId': projectId,
        'motivation': motivation,
        'design': design,
        'alternatives': alternatives,
        'openQuestions': openQuestions,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory RfcDocument.fromJson(Map<String, dynamic> json) {
    return RfcDocument(
      id: json['id'] as String,
      title: json['title'] as String,
      projectId: json['projectId'] as String,
      motivation: json['motivation'] as String? ?? '',
      design: json['design'] as String? ?? '',
      alternatives: json['alternatives'] as String? ?? '',
      openQuestions: json['openQuestions'] as String? ?? '',
      status: RfcStatus.values.byName(json['status'] as String? ?? 'draft'),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

/// Persists all RFCs locally, across every project — an RFC is a
/// standalone idea document, not tied into a project's own file tree.
class RfcRepository {
  static const String _storageKey = 'web_lab.rfcs';

  Future<List<RfcDocument>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => RfcDocument.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<RfcDocument> rfcs) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(rfcs.map((r) => r.toJson()).toList()));
  }
}
