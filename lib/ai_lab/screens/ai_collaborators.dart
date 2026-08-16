import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ai_dataset_lab.dart' show AiProject;

// ============================================================
// AI LAB — Roles, Permissions, Collaboration
//
// Foundation layer everything else (review/approval, training
// history "who did this", dashboard contributors) depends on.
//
// Invite model: invite by email (the only identifier that works
// before the invited person has ever touched this project). The
// invite row is "pending" until someone logs in with a matching
// email and opens the project, at which point it's claimed and
// becomes "active" with their real user_id attached.
// ============================================================

enum AiCollaboratorRole { owner, engineer, developer, viewer }

extension AiCollaboratorRoleX on AiCollaboratorRole {
  String get label {
    switch (this) {
      case AiCollaboratorRole.owner:
        return 'Owner';
      case AiCollaboratorRole.engineer:
        return 'AI Engineer / Trainer';
      case AiCollaboratorRole.developer:
        return 'Developer';
      case AiCollaboratorRole.viewer:
        return 'Viewer';
    }
  }

  String get description {
    switch (this) {
      case AiCollaboratorRole.owner:
        return 'Full control — manage collaborators, approve training, deploy, delete.';
      case AiCollaboratorRole.engineer:
        return 'Can add/edit datasets and submit training data. Cannot approve their own submissions.';
      case AiCollaboratorRole.developer:
        return 'Can view the model and use it via app integration. Cannot edit datasets or training.';
      case AiCollaboratorRole.viewer:
        return 'Read-only access to dashboard and results.';
    }
  }
}

/// Central capability checks — every screen that needs to gate an
/// action should ask this class, not re-implement role logic.
class AiPermissions {
  final AiCollaboratorRole role;
  const AiPermissions(this.role);

  bool get canManageCollaborators => role == AiCollaboratorRole.owner;
  bool get canEditDataset => role == AiCollaboratorRole.owner || role == AiCollaboratorRole.engineer;
  bool get canSubmitTrainingData => role == AiCollaboratorRole.owner || role == AiCollaboratorRole.engineer;
  bool get canApproveTrainingData => role == AiCollaboratorRole.owner;
  bool get canStartTraining => role == AiCollaboratorRole.owner || role == AiCollaboratorRole.engineer;
  bool get canDeploy => role == AiCollaboratorRole.owner;
  bool get canUseIntegration => role != AiCollaboratorRole.viewer;
  bool get canView => true; // every role can view
}

class AiCollaborator {
  final String id;
  final String projectId;
  final String invitedEmail;
  final String? userId;
  final AiCollaboratorRole role;
  final String status; // 'pending' | 'active' | 'revoked'
  final String invitedBy;
  final DateTime createdAt;

  AiCollaborator({
    required this.id,
    required this.projectId,
    required this.invitedEmail,
    this.userId,
    required this.role,
    required this.status,
    required this.invitedBy,
    required this.createdAt,
  });

  factory AiCollaborator.fromJson(Map<String, dynamic> json) => AiCollaborator(
        id: json['id'] as String,
        projectId: json['project_id'] as String,
        invitedEmail: json['invited_email'] as String,
        userId: json['user_id'] as String?,
        role: AiCollaboratorRole.values.byName(json['role'] as String),
        status: json['status'] as String,
        invitedBy: json['invited_by'] as String,
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      );
}

class AiCollaboratorRepository {
  final SupabaseClient supabase;
  AiCollaboratorRepository(this.supabase);

  Future<List<AiCollaborator>> listCollaborators(String projectId) async {
    final response = await supabase
        .from('ai_project_collaborators')
        .select()
        .eq('project_id', projectId)
        .order('created_at', ascending: true);
    return (response as List).map((c) => AiCollaborator.fromJson(c)).toList();
  }

  Future<void> invite({
    required String projectId,
    required String email,
    required AiCollaboratorRole role,
    required String invitedByUserId,
  }) async {
    final id = '${DateTime.now().microsecondsSinceEpoch}_invite';
    await supabase.from('ai_project_collaborators').insert({
      'id': id,
      'project_id': projectId,
      'invited_email': email.trim().toLowerCase(),
      'role': role.name,
      'status': 'pending',
      'invited_by': invitedByUserId,
    });
  }

  /// Called when a logged-in user opens a project — claims any
  /// pending invite matching their email, attaching their real
  /// user_id. Safe to call every time; no-ops if nothing pending.
  Future<void> claimPendingInvites({
    required String projectId,
    required String currentUserId,
    required String? currentUserEmail,
  }) async {
    if (currentUserEmail == null) return;
    await supabase
        .from('ai_project_collaborators')
        .update({'status': 'active', 'user_id': currentUserId})
        .eq('project_id', projectId)
        .eq('invited_email', currentUserEmail.trim().toLowerCase())
        .eq('status', 'pending');
  }

  Future<void> changeRole(String collaboratorId, AiCollaboratorRole newRole) async {
    await supabase.from('ai_project_collaborators').update({'role': newRole.name}).eq('id', collaboratorId);
  }

  Future<void> revoke(String collaboratorId) async {
    await supabase.from('ai_project_collaborators').update({'status': 'revoked'}).eq('id', collaboratorId);
  }

  /// Resolves the current user's effective role for a project.
  /// The project creator is always 'owner' — collaborators table
  /// is only consulted for everyone else.
  Future<AiCollaboratorRole> resolveRole({
    required AiProject project,
    required String currentUserId,
  }) async {
    if (project.userId == currentUserId) return AiCollaboratorRole.owner;

    final response = await supabase
        .from('ai_project_collaborators')
        .select()
        .eq('project_id', project.id)
        .eq('user_id', currentUserId)
        .eq('status', 'active')
        .maybeSingle();

    if (response == null) return AiCollaboratorRole.viewer;
    return AiCollaboratorRole.values.byName(response['role'] as String);
  }
}

// ============================================================
// SCREEN
// ============================================================

class AiCollaboratorsScreen extends StatefulWidget {
  final AiProject project;
  const AiCollaboratorsScreen({super.key, required this.project});

  @override
  State<AiCollaboratorsScreen> createState() => _AiCollaboratorsScreenState();
}

class _AiCollaboratorsScreenState extends State<AiCollaboratorsScreen> {
  late final AiCollaboratorRepository _repository;
  List<AiCollaborator> _collaborators = [];
  bool _isLoading = true;
  bool _isOwner = false;

  @override
  void initState() {
    super.initState();
    _repository = AiCollaboratorRepository(Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    _isOwner = currentUser != null && currentUser.id == widget.project.userId;

    final collaborators = await _repository.listCollaborators(widget.project.id);
    if (!mounted) return;
    setState(() {
      _collaborators = collaborators;
      _isLoading = false;
    });
  }

  Future<void> _showInviteDialog() async {
    final emailController = TextEditingController();
    AiCollaboratorRole selectedRole = AiCollaboratorRole.engineer;

    final result = await showDialog<(String, AiCollaboratorRole)>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Invite Collaborator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: emailController,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<AiCollaboratorRole>(
                value: selectedRole,
                decoration: const InputDecoration(labelText: 'Role'),
                items: [AiCollaboratorRole.engineer, AiCollaboratorRole.developer, AiCollaboratorRole.viewer]
                    .map((r) => DropdownMenuItem(value: r, child: Text(r.label)))
                    .toList(),
                onChanged: (v) => setDialogState(() => selectedRole = v ?? selectedRole),
              ),
              const SizedBox(height: 8),
              Text(selectedRole.description, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () => Navigator.pop(context, (emailController.text, selectedRole)),
              child: const Text('Send Invite'),
            ),
          ],
        ),
      ),
    );

    if (result == null || result.$1.trim().isEmpty) return;

    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) return;

    try {
      await _repository.invite(
        projectId: widget.project.id,
        email: result.$1,
        role: result.$2,
        invitedByUserId: currentUser.id,
      );
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invite sent')));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invite failed: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _changeRole(AiCollaborator collaborator) async {
    AiCollaboratorRole selected = collaborator.role;
    final result = await showDialog<AiCollaboratorRole>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Change Role'),
          content: DropdownButtonFormField<AiCollaboratorRole>(
            value: selected,
            items: [AiCollaboratorRole.engineer, AiCollaboratorRole.developer, AiCollaboratorRole.viewer]
                .map((r) => DropdownMenuItem(value: r, child: Text(r.label)))
                .toList(),
            onChanged: (v) => setDialogState(() => selected = v ?? selected),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(context, selected), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (result == null) return;
    await _repository.changeRole(collaborator.id, result);
    await _load();
  }

  Future<void> _revoke(AiCollaborator collaborator) async {
    await _repository.revoke(collaborator.id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final active = _collaborators.where((c) => c.status == 'active').toList();
    final pending = _collaborators.where((c) => c.status == 'pending').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Collaborators')),
      floatingActionButton: _isOwner
          ? FloatingActionButton.extended(
              onPressed: _showInviteDialog,
              icon: const Icon(Icons.person_add),
              label: const Text('Invite'),
            )
          : null,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.star)),
                    title: const Text('You (Owner)', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Full control'),
                  ),
                ),
                const SizedBox(height: 16),
                if (active.isNotEmpty) ...[
                  Text('Active', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...active.map((c) => _collaboratorTile(c)),
                  const SizedBox(height: 16),
                ],
                if (pending.isNotEmpty) ...[
                  Text('Pending', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...pending.map((c) => _collaboratorTile(c)),
                ],
                if (active.isEmpty && pending.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Text('No collaborators yet.'),
                  ),
              ],
            ),
    );
  }

  Widget _collaboratorTile(AiCollaborator c) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(c.invitedEmail[0].toUpperCase())),
        title: Text(c.invitedEmail),
        subtitle: Text('${c.role.label}${c.status == 'pending' ? ' · invite pending' : ''}'),
        trailing: _isOwner
            ? PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'change_role') _changeRole(c);
                  if (value == 'revoke') _revoke(c);
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'change_role', child: Text('Change role')),
                  PopupMenuItem(value: 'revoke', child: Text('Remove')),
                ],
              )
            : null,
      ),
    );
  }
}
