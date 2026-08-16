import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'mobile_editor_screen.dart';

// ============================================================
// COLLABORATION SERVICE — invites resolved entirely inside
// Hustle Academy (ZetraMail address is just a lookup key against
// our own profiles table, no email is ever sent), plus a
// PR-style draft/review/merge flow so a collaborator's edits
// never touch the real project until the owner approves.
// ============================================================

class ProjectInvite {
  final String id;
  final String projectId;
  final String? projectName;
  final String ownerId;
  final String invitedZetramail;
  final String? invitedUserId;
  final String status;
  final DateTime createdAt;

  ProjectInvite({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.ownerId,
    required this.invitedZetramail,
    required this.invitedUserId,
    required this.status,
    required this.createdAt,
  });

  factory ProjectInvite.fromJson(Map<String, dynamic> json) {
    final nested = json['mobile_projects'] as Map<String, dynamic>?;
    return ProjectInvite(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      projectName: nested?['name'] as String?,
      ownerId: json['owner_id'] as String,
      invitedZetramail: json['invited_zetramail'] as String,
      invitedUserId: json['invited_user_id'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

class DraftInfo {
  final String id;
  final String projectId;
  final String? projectName;
  final String collaboratorId;
  final String status;
  final DateTime updatedAt;

  DraftInfo({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.collaboratorId,
    required this.status,
    required this.updatedAt,
  });

  factory DraftInfo.fromJson(Map<String, dynamic> json) {
    final nested = json['mobile_projects'] as Map<String, dynamic>?;
    return DraftInfo(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      projectName: nested?['name'] as String?,
      collaboratorId: json['collaborator_id'] as String,
      status: json['status'] as String,
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

enum FileDiffType { added, removed, modified }

class FileDiffEntry {
  final String path;
  final FileDiffType type;
  const FileDiffEntry(this.path, this.type);
}

class CollaborationService {
  final SupabaseClient supabase;
  CollaborationService({required this.supabase});

  String get _uid => supabase.auth.currentUser!.id;

  /// Looks up whether a ZetraMail address belongs to an existing
  /// Hustle Academy account. No email is sent — this is a lookup
  /// against our own profiles table via a restricted server-side
  /// function.
  Future<String?> findUserIdByZetramail(String zetramail) async {
    final result = await supabase.rpc('find_user_by_zetramail', params: {
      'p_zetramail': zetramail,
    });
    return result as String?;
  }

  Future<String?> getZetramailForUser(String userId) async {
    final result = await supabase.rpc('get_zetramail_for_user', params: {
      'p_user_id': userId,
    });
    return result as String?;
  }

  Future<void> inviteCollaborator({
    required String projectId,
    required String zetramail,
  }) async {
    final invitedUserId = await findUserIdByZetramail(zetramail);
    if (invitedUserId == null) {
      throw Exception('No Hustle Academy account found for that ZetraMail address');
    }
    if (invitedUserId == _uid) {
      throw Exception('You can\'t invite yourself');
    }

    await supabase.from('project_collaborators').insert({
      'project_id': projectId,
      'owner_id': _uid,
      'invited_zetramail': zetramail,
      'invited_user_id': invitedUserId,
      'status': 'pending',
      'role': 'editor',
    });
  }

  Future<List<ProjectInvite>> listInvitesForProject(String projectId) async {
    final data = await supabase
        .from('project_collaborators')
        .select('*, mobile_projects(name)')
        .eq('project_id', projectId)
        .order('created_at', ascending: false);
    return (data as List).map((e) => ProjectInvite.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<ProjectInvite>> listMyPendingInvites() async {
    final data = await supabase
        .from('project_collaborators')
        .select('*, mobile_projects(name)')
        .eq('invited_user_id', _uid)
        .eq('status', 'pending')
        .order('created_at', ascending: false);
    return (data as List).map((e) => ProjectInvite.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Accepts an invite and creates the collaborator's private
  /// draft — a copy of the project as it exists right now. Returns
  /// the new draft id. The real project is untouched by this.
  Future<String> acceptInvite(String inviteId) async {
    final result = await supabase.rpc('accept_project_invite', params: {
      'p_invite_id': inviteId,
    });
    return result as String;
  }

  Future<void> declineInvite(String inviteId) async {
    await supabase
        .from('project_collaborators')
        .update({'status': 'declined', 'responded_at': DateTime.now().toIso8601String()})
        .eq('id', inviteId);
  }

  Future<List<DraftInfo>> listMyDrafts() async {
    final data = await supabase
        .from('project_drafts')
        .select('*, mobile_projects(name)')
        .eq('collaborator_id', _uid)
        .inFilter('status', ['in_progress', 'submitted'])
        .order('updated_at', ascending: false);
    return (data as List).map((e) => DraftInfo.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Drafts submitted for review across every project this user
  /// owns — RLS on project_drafts already restricts this to only
  /// drafts belonging to the caller's own projects.
  Future<List<DraftInfo>> listPendingReviews({String? projectId}) async {
    var query = supabase
        .from('project_drafts')
        .select('*, mobile_projects(name)')
        .eq('status', 'submitted');
    if (projectId != null) {
      query = query.eq('project_id', projectId);
    }
    final data = await query.order('updated_at', ascending: false);
    return (data as List).map((e) => DraftInfo.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<MobileProject?> loadDraft(String draftId) async {
    try {
      final data = await supabase
          .from('project_drafts')
          .select('draft_json')
          .eq('id', draftId)
          .maybeSingle();
      if (data == null) return null;
      return MobileProject.fromJson(data['draft_json'] as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Failed to load draft $draftId: $e');
      return null;
    }
  }

  Future<void> saveDraft(String draftId, MobileProject project) async {
    await supabase.from('project_drafts').update({
      'draft_json': project.toJson(),
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', draftId);
  }

  Future<void> submitDraftForReview(String draftId) async {
    await supabase.from('project_drafts').update({
      'status': 'submitted',
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', draftId);
  }

  /// Applies the draft's content onto the real project. Only the
  /// project owner can do this successfully — enforced inside the
  /// database function itself, not just client-side.
  Future<void> mergeDraft(String draftId) async {
    await supabase.rpc('merge_project_draft', params: {'p_draft_id': draftId});
  }

  Future<void> rejectDraft(String draftId) async {
    await supabase.rpc('reject_project_draft', params: {'p_draft_id': draftId});
  }

  // ---------------- DIFF ----------------

  static Map<String, String> _flatten(MobileFileNode node, [String prefix = '']) {
    final map = <String, String>{};
    for (final child in node.children) {
      final path = prefix.isEmpty ? child.name : '$prefix/${child.name}';
      if (child.isFile) {
        map[path] = child.content;
      } else {
        map.addAll(_flatten(child, path));
      }
    }
    return map;
  }

  /// A simple per-file diff between the owner's current project and
  /// a collaborator's draft — which files were added, removed, or
  /// have different content. Not a line-by-line diff, but enough to
  /// see what actually changed before deciding to merge.
  static List<FileDiffEntry> diffProjects(MobileProject original, MobileProject draft) {
    final originalFiles = _flatten(original.root);
    final draftFiles = _flatten(draft.root);
    final entries = <FileDiffEntry>[];

    for (final path in draftFiles.keys) {
      if (!originalFiles.containsKey(path)) {
        entries.add(FileDiffEntry(path, FileDiffType.added));
      } else if (originalFiles[path] != draftFiles[path]) {
        entries.add(FileDiffEntry(path, FileDiffType.modified));
      }
    }
    for (final path in originalFiles.keys) {
      if (!draftFiles.containsKey(path)) {
        entries.add(FileDiffEntry(path, FileDiffType.removed));
      }
    }

    entries.sort((a, b) => a.path.compareTo(b.path));
    return entries;
  }
}
