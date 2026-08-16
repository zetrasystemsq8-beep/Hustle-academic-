import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'mobile_collaboration_service.dart';
import 'mobile_editor_screen.dart';

// ============================================================
// PROJECT COLLABORATION SCREEN — owner side, opened from inside
// a specific project's editor. Invite people by ZetraMail, see
// who's been invited, and review drafts submitted back for this
// project.
// ============================================================

class MobileProjectCollaborationScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  const MobileProjectCollaborationScreen({
    required this.projectId,
    required this.projectName,
    Key? key,
  }) : super(key: key);

  @override
  State<MobileProjectCollaborationScreen> createState() => _MobileProjectCollaborationScreenState();
}

class _MobileProjectCollaborationScreenState extends State<MobileProjectCollaborationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final CollaborationService _service;
  final _zetramailController = TextEditingController();
  bool _isInviting = false;

  List<ProjectInvite> _invites = [];
  List<DraftInfo> _reviews = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _service = CollaborationService(supabase: Supabase.instance.client);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _zetramailController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final invites = await _service.listInvitesForProject(widget.projectId);
    final reviews = await _service.listPendingReviews(projectId: widget.projectId);
    if (!mounted) return;
    setState(() {
      _invites = invites;
      _reviews = reviews;
      _isLoading = false;
    });
  }

  Future<void> _sendInvite() async {
    final zetramail = _zetramailController.text.trim();
    if (zetramail.isEmpty) return;

    setState(() => _isInviting = true);
    try {
      await _service.inviteCollaborator(projectId: widget.projectId, zetramail: zetramail);
      _zetramailController.clear();
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invite sent')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _isInviting = false);
    }
  }

  Future<void> _openReview(DraftInfo draft) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MobileDraftReviewScreen(draftId: draft.id, projectId: widget.projectId),
      ),
    ).then((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collaborators — ${widget.projectName}'),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Invite & Manage'),
            Tab(text: 'Reviews'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [_buildInviteTab(), _buildReviewsTab()],
            ),
    );
  }

  Widget _buildInviteTab() {
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Invite by ZetraMail address', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _zetramailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'friend@zetramail...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _isInviting ? null : _sendInvite,
                child: _isInviting
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Invite'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('People invited to this project', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (_invites.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text('No one invited yet', style: TextStyle(color: Colors.grey[600])),
            )
          else
            ..._invites.map((invite) => Card(
                  child: ListTile(
                    leading: Icon(
                      invite.status == 'accepted'
                          ? Icons.check_circle
                          : invite.status == 'declined'
                              ? Icons.cancel
                              : Icons.hourglass_empty,
                      color: invite.status == 'accepted'
                          ? Colors.green
                          : invite.status == 'declined'
                              ? Colors.red
                              : Colors.orange,
                    ),
                    title: Text(invite.invitedZetramail),
                    subtitle: Text(invite.status),
                  ),
                )),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return RefreshIndicator(
      onRefresh: _load,
      child: _reviews.isEmpty
          ? ListView(
              children: [
                const SizedBox(height: 80),
                Center(child: Text('No submitted drafts yet', style: TextStyle(color: Colors.grey[600]))),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _reviews.length,
              itemBuilder: (context, i) {
                final draft = _reviews[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.rate_review_outlined),
                    title: const Text('Submitted for review'),
                    subtitle: Text('Updated ${_timeAgo(draft.updatedAt)}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _openReview(draft),
                  ),
                );
              },
            ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

// ============================================================
// DRAFT REVIEW SCREEN — shows what changed, lets the owner
// Merge (apply to the real project) or Reject.
// ============================================================

class MobileDraftReviewScreen extends StatefulWidget {
  final String draftId;
  final String projectId;

  const MobileDraftReviewScreen({required this.draftId, required this.projectId, Key? key}) : super(key: key);

  @override
  State<MobileDraftReviewScreen> createState() => _MobileDraftReviewScreenState();
}

class _MobileDraftReviewScreenState extends State<MobileDraftReviewScreen> {
  late final CollaborationService _service;
  List<FileDiffEntry>? _diff;
  bool _isLoading = true;
  bool _isActing = false;

  @override
  void initState() {
    super.initState();
    _service = CollaborationService(supabase: Supabase.instance.client);
    _load();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final repo = MobileProjectRepository();
    final original = await repo.loadProject(widget.projectId);
    final draft = await _service.loadDraft(widget.draftId);
    if (!mounted) return;

    if (original == null || draft == null) {
      setState(() {
        _diff = [];
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _diff = CollaborationService.diffProjects(original, draft);
      _isLoading = false;
    });
  }

  Future<void> _merge() async {
    setState(() => _isActing = true);
    try {
      await _service.mergeDraft(widget.draftId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Merged into the project')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Merge failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<void> _reject() async {
    setState(() => _isActing = true);
    try {
      await _service.rejectDraft(widget.draftId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Draft rejected')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reject failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Draft'), backgroundColor: Colors.deepPurple),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: (_diff == null || _diff!.isEmpty)
                      ? const Center(child: Text('No file differences found'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _diff!.length,
                          itemBuilder: (context, i) {
                            final entry = _diff![i];
                            final (icon, color) = switch (entry.type) {
                              FileDiffType.added => (Icons.add_circle_outline, Colors.green),
                              FileDiffType.removed => (Icons.remove_circle_outline, Colors.red),
                              FileDiffType.modified => (Icons.edit_outlined, Colors.orange),
                            };
                            return ListTile(
                              leading: Icon(icon, color: color),
                              title: Text(entry.path, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
                              subtitle: Text(entry.type.name),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isActing ? null : _reject,
                          icon: const Icon(Icons.close, color: Colors.red),
                          label: const Text('Reject', style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _isActing ? null : _merge,
                          icon: const Icon(Icons.merge),
                          label: const Text('Merge'),
                          style: FilledButton.styleFrom(backgroundColor: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// ============================================================
// COLLABORATION INBOX — global, opened from Mobile Lab home.
// Invites sent TO me, drafts I'm currently working on, and
// (as project owner) drafts submitted to me across ALL my
// projects.
// ============================================================

class MobileCollaborationInboxScreen extends StatefulWidget {
  final MobileProjectController projectController;

  const MobileCollaborationInboxScreen({required this.projectController, Key? key}) : super(key: key);

  @override
  State<MobileCollaborationInboxScreen> createState() => _MobileCollaborationInboxScreenState();
}

class _MobileCollaborationInboxScreenState extends State<MobileCollaborationInboxScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final CollaborationService _service;

  List<ProjectInvite> _invites = [];
  List<DraftInfo> _drafts = [];
  List<DraftInfo> _reviews = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _service = CollaborationService(supabase: Supabase.instance.client);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final invites = await _service.listMyPendingInvites();
    final drafts = await _service.listMyDrafts();
    final reviews = await _service.listPendingReviews();
    if (!mounted) return;
    setState(() {
      _invites = invites;
      _drafts = drafts;
      _reviews = reviews;
      _isLoading = false;
    });
  }

  Future<void> _acceptInvite(ProjectInvite invite) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final draftId = await _service.acceptInvite(invite.id);
      final success = await widget.projectController.openDraft(draftId);
      if (!success) {
        messenger.showSnackBar(const SnackBar(content: Text('Could not open the shared draft')));
        return;
      }
      navigator.push(MaterialPageRoute(
        builder: (_) => MobileEditorScreen(projectController: widget.projectController),
      ));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))));
    }
  }

  Future<void> _declineInvite(ProjectInvite invite) async {
    await _service.declineInvite(invite.id);
    await _load();
  }

  Future<void> _openDraft(DraftInfo draft) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final success = await widget.projectController.openDraft(draft.id);
    if (!success) {
      messenger.showSnackBar(const SnackBar(content: Text('Could not open this draft')));
      return;
    }
    navigator.push(MaterialPageRoute(
      builder: (_) => MobileEditorScreen(projectController: widget.projectController),
    ));
  }

  Future<void> _openReview(DraftInfo draft) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MobileDraftReviewScreen(draftId: draft.id, projectId: draft.projectId),
      ),
    ).then((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collaboration'),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Invites'),
            Tab(text: 'My Drafts'),
            Tab(text: 'Reviews'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [_buildInvitesTab(), _buildDraftsTab(), _buildReviewsTab()],
            ),
    );
  }

  Widget _buildInvitesTab() {
    return RefreshIndicator(
      onRefresh: _load,
      child: _invites.isEmpty
          ? ListView(
              children: [
                const SizedBox(height: 80),
                Center(child: Text('No pending invites', style: TextStyle(color: Colors.grey[600]))),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _invites.length,
              itemBuilder: (context, i) {
                final invite = _invites[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.mail_outline),
                    title: Text(invite.projectName ?? 'A project'),
                    subtitle: const Text('invited you to collaborate'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => _acceptInvite(invite),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => _declineInvite(invite),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildDraftsTab() {
    return RefreshIndicator(
      onRefresh: _load,
      child: _drafts.isEmpty
          ? ListView(
              children: [
                const SizedBox(height: 80),
                Center(child: Text('No shared drafts', style: TextStyle(color: Colors.grey[600]))),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _drafts.length,
              itemBuilder: (context, i) {
                final draft = _drafts[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.edit_note),
                    title: Text(draft.projectName ?? 'Shared project'),
                    subtitle: Text(draft.status == 'submitted' ? 'Submitted — awaiting review' : 'In progress'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _openDraft(draft),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildReviewsTab() {
    return RefreshIndicator(
      onRefresh: _load,
      child: _reviews.isEmpty
          ? ListView(
              children: [
                const SizedBox(height: 80),
                Center(child: Text('No drafts awaiting your review', style: TextStyle(color: Colors.grey[600]))),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _reviews.length,
              itemBuilder: (context, i) {
                final draft = _reviews[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.rate_review_outlined),
                    title: Text(draft.projectName ?? 'A project'),
                    subtitle: const Text('has a draft submitted for review'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _openReview(draft),
                  ),
                );
              },
            ),
    );
  }
}
