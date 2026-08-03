import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ============================================================
// MODELS
// ============================================================

class InventorIdentity {
  final String handle;
  final String displayName;
  final String bio;

  const InventorIdentity({required this.handle, required this.displayName, this.bio = ''});
}

class PublishedSiteSummary {
  final String slug;
  final String projectName;
  final DateTime publishedAt;

  const PublishedSiteSummary({required this.slug, required this.projectName, required this.publishedAt});

  factory PublishedSiteSummary.fromRow(Map<String, dynamic> row) {
    return PublishedSiteSummary(
      slug: row['slug'] as String,
      projectName: row['project_name'] as String,
      publishedAt: DateTime.tryParse(row['published_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

class PublishedTemplateSummary {
  final String title;
  final String category;
  final DateTime createdAt;

  const PublishedTemplateSummary({required this.title, required this.category, required this.createdAt});

  factory PublishedTemplateSummary.fromRow(Map<String, dynamic> row) {
    return PublishedTemplateSummary(
      title: row['title'] as String,
      category: row['category'] as String? ?? 'General',
      createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

class PublishedPluginSummary {
  final String name;
  final String pluginType;
  final DateTime createdAt;

  const PublishedPluginSummary({required this.name, required this.pluginType, required this.createdAt});

  factory PublishedPluginSummary.fromRow(Map<String, dynamic> row) {
    return PublishedPluginSummary(
      name: row['name'] as String,
      pluginType: row['plugin_type'] as String,
      createdAt: DateTime.tryParse(row['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

/// Everything gathered about one inventor, aggregated across the app's
/// existing publish surfaces — this profile invents no new content of
/// its own, it only reflects what's genuinely real elsewhere.
class InventorProfileData {
  final InventorIdentity identity;
  final List<PublishedSiteSummary> sites;
  final List<PublishedTemplateSummary> templates;
  final List<PublishedPluginSummary> plugins;
  final int citationsReceived;

  const InventorProfileData({
    required this.identity,
    required this.sites,
    required this.templates,
    required this.plugins,
    required this.citationsReceived,
  });
}

// ============================================================
// REPOSITORY
// ============================================================

class InventorRepository {
  static const String _localHandleKey = 'web_lab.my_inventor_handle';
  static const String _bucketName = 'web-lab-published-sites';

  final SupabaseClient _client = Supabase.instance.client;

  /// The handle this device has claimed, if any. There's no login
  /// system yet, so this is device-local — the same pattern the rest of
  /// Web Lab uses for "who is using this app right now."
  Future<String?> loadMyHandle() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localHandleKey);
  }

  Future<void> _saveMyHandle(String handle) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localHandleKey, handle);
  }

  /// Attempts to claim [handle]. Fails honestly (returns false) if it's
  /// already taken — the database's own uniqueness constraint is what
  /// actually enforces this, not a client-side guess.
  Future<bool> claimHandle({required String handle, required String displayName, required String bio}) async {
    try {
      await _client.from('web_lab_inventors').insert({'handle': handle, 'display_name': displayName, 'bio': bio});
      await _saveMyHandle(handle);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateBio(String handle, String displayName, String bio) async {
    await _client.from('web_lab_inventors').update({'display_name': displayName, 'bio': bio}).eq('handle', handle);
  }

  Future<InventorIdentity?> fetchIdentity(String handle) async {
    final rows = await _client.from('web_lab_inventors').select().eq('handle', handle).limit(1);
    final list = rows as List;
    if (list.isEmpty) return null;
    final row = list.first as Map<String, dynamic>;
    return InventorIdentity(handle: row['handle'] as String, displayName: row['display_name'] as String, bio: row['bio'] as String? ?? '');
  }

  Future<InventorProfileData?> loadProfile(String handle) async {
    final identity = await fetchIdentity(handle);
    if (identity == null) return null;

    final sitesRows = await _client.from('web_lab_published_projects').select().eq('author_handle', handle).order('published_at', ascending: false);
    final templatesRows = await _client.from('web_lab_community_templates').select().eq('author_handle', handle).order('created_at', ascending: false);
    final pluginsRows = await _client.from('web_lab_plugins').select().eq('author_handle', handle).order('created_at', ascending: false);

    final templateIdsRows = await _client.from('web_lab_community_templates').select('id').eq('author_handle', handle);
    final templateIds = (templateIdsRows as List).map((r) => (r as Map<String, dynamic>)['id'] as String).toList();

    var citationsReceived = 0;
    if (templateIds.isNotEmpty) {
      final citationRows = await _client.from('web_lab_citations').select('id').inFilter('template_id', templateIds);
      citationsReceived = (citationRows as List).length;
    }

    return InventorProfileData(
      identity: identity,
      sites: (sitesRows as List).map((r) => PublishedSiteSummary.fromRow(r as Map<String, dynamic>)).toList(),
      templates: (templatesRows as List).map((r) => PublishedTemplateSummary.fromRow(r as Map<String, dynamic>)).toList(),
      plugins: (pluginsRows as List).map((r) => PublishedPluginSummary.fromRow(r as Map<String, dynamic>)).toList(),
      citationsReceived: citationsReceived,
    );
  }

  String publicUrlForSlug(String slug) => _client.storage.from(_bucketName).getPublicUrl('$slug/index.html');

  /// Uploads a real, standalone HTML page for this inventor to the same
  /// storage bucket Publish already uses — no new hosting
  /// infrastructure, just a new path (`profiles/<handle>/index.html`)
  /// within it.
  Future<String> publishProfilePage(InventorProfileData data) async {
    final document = InventorProfilePageBuilder.build(data);
    final bytes = Uint8List.fromList(utf8.encode(document));
    final path = 'profiles/${data.identity.handle}/index.html';

    await _client.storage.from(_bucketName).uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(contentType: 'text/html', upsert: true),
        );

    return _client.storage.from(_bucketName).getPublicUrl(path);
  }
}

// ============================================================
// PUBLIC PAGE BUILDER — the real, standalone HTML served to anyone
// who opens the profile link, no app install required.
// ============================================================

class InventorProfilePageBuilder {
  InventorProfilePageBuilder._();

  static String build(InventorProfileData data) {
    final identity = data.identity;

    final sitesHtml = data.sites.isEmpty
        ? '<p class="empty">No published websites yet.</p>'
        : data.sites.map((s) => '<li><a href="https://${_hostForSlug(s.slug)}" target="_blank">${_escape(s.projectName)}</a> <span class="date">${_formatDate(s.publishedAt)}</span></li>').join();

    final templatesHtml = data.templates.isEmpty
        ? '<p class="empty">No shared community templates yet.</p>'
        : data.templates.map((t) => '<li>${_escape(t.title)} <span class="tag">${_escape(t.category)}</span></li>').join();

    final pluginsHtml = data.plugins.isEmpty
        ? '<p class="empty">No published plugins yet.</p>'
        : data.plugins.map((p) => '<li>${_escape(p.name)} <span class="tag">${_escape(p.pluginType)}</span></li>').join();

    return '''<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${_escape(identity.displayName)} — Hustle Academy Inventor Profile</title>
<style>
  body { font-family: -apple-system, sans-serif; background: #0F1115; color: #E5E7EB; margin: 0; padding: 24px; }
  .container { max-width: 640px; margin: 0 auto; }
  h1 { font-size: 28px; margin-bottom: 4px; }
  .handle { color: #9CA3AF; font-size: 14px; margin-bottom: 20px; }
  .bio { line-height: 1.6; margin-bottom: 32px; }
  .stats { display: flex; gap: 16px; margin-bottom: 32px; flex-wrap: wrap; }
  .stat { background: #1A1D24; border-radius: 12px; padding: 14px 18px; }
  .stat-value { font-size: 22px; font-weight: bold; color: #818CF8; }
  .stat-label { font-size: 12px; color: #9CA3AF; }
  h2 { font-size: 16px; border-bottom: 1px solid #2A2E38; padding-bottom: 8px; margin-top: 28px; }
  ul { list-style: none; padding: 0; }
  li { padding: 8px 0; border-bottom: 1px solid #1A1D24; }
  a { color: #818CF8; text-decoration: none; }
  .tag { background: #2A2E38; border-radius: 999px; padding: 2px 8px; font-size: 11px; margin-left: 8px; }
  .date { color: #6B7280; font-size: 12px; margin-left: 8px; }
  .empty { color: #6B7280; font-size: 13px; }
  .footer { margin-top: 40px; color: #6B7280; font-size: 12px; text-align: center; }
</style>
</head>
<body>
<div class="container">
  <h1>${_escape(identity.displayName)}</h1>
  <div class="handle">@${_escape(identity.handle)}</div>
  <div class="bio">${_escape(identity.bio)}</div>

  <div class="stats">
    <div class="stat"><div class="stat-value">${data.sites.length}</div><div class="stat-label">Published Sites</div></div>
    <div class="stat"><div class="stat-value">${data.templates.length}</div><div class="stat-label">Templates Shared</div></div>
    <div class="stat"><div class="stat-value">${data.plugins.length}</div><div class="stat-label">Plugins Published</div></div>
    <div class="stat"><div class="stat-value">${data.citationsReceived}</div><div class="stat-label">Times Built On</div></div>
  </div>

  <h2>Published Websites</h2>
  <ul>$sitesHtml</ul>

  <h2>Shared Templates</h2>
  <ul>$templatesHtml</ul>

  <h2>Published Plugins</h2>
  <ul>$pluginsHtml</ul>

  <div class="footer">An inventor at Hustle Academy — hustleacademy.dev</div>
</div>
</body>
</html>
''';
  }

  static String _hostForSlug(String slug) => 'REPLACE_WITH_YOUR_SUPABASE_STORAGE_HOST/storage/v1/object/public/web-lab-published-sites/$slug/index.html';

  static String _escape(String input) => input.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;');

  static String _formatDate(DateTime date) => '${date.month}/${date.day}/${date.year}';
}

// ============================================================
// CONTROLLER
// ============================================================

class InventorProfileController extends ChangeNotifier {
  final InventorRepository _repository = InventorRepository();

  String? _myHandle;
  InventorProfileData? _myProfile;
  bool _isLoading = false;
  String? _publicPageUrl;

  String? get myHandle => _myHandle;
  InventorProfileData? get myProfile => _myProfile;
  bool get isLoading => _isLoading;
  String? get publicPageUrl => _publicPageUrl;

  Future<void> loadMine() async {
    _isLoading = true;
    notifyListeners();
    _myHandle = await _repository.loadMyHandle();
    if (_myHandle != null) {
      _myProfile = await _repository.loadProfile(_myHandle!);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<String?> claimHandle(String handle, String displayName, String bio) async {
    final cleaned = handle.trim().toLowerCase();
    final success = await _repository.claimHandle(handle: cleaned, displayName: displayName.trim(), bio: bio.trim());
    if (!success) return 'That handle is already taken — try another.';
    _myHandle = cleaned;
    _myProfile = await _repository.loadProfile(cleaned);
    notifyListeners();
    return null;
  }

  Future<void> updateBio(String displayName, String bio) async {
    if (_myHandle == null) return;
    await _repository.updateBio(_myHandle!, displayName, bio);
    _myProfile = await _repository.loadProfile(_myHandle!);
    notifyListeners();
  }

  Future<void> refresh() async {
    if (_myHandle == null) return;
    _myProfile = await _repository.loadProfile(_myHandle!);
    notifyListeners();
  }

  Future<void> publishProfilePage() async {
    if (_myProfile == null) return;
    _publicPageUrl = await _repository.publishProfilePage(_myProfile!);
    notifyListeners();
  }
}

// ============================================================
// SCREENS
// ============================================================

class InventorProfileScreen extends StatefulWidget {
  const InventorProfileScreen({super.key});

  @override
  State<InventorProfileScreen> createState() => _InventorProfileScreenState();
}

class _InventorProfileScreenState extends State<InventorProfileScreen> {
  late final InventorProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = InventorProfileController();
    _controller.loadMine();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventor Profile')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
          if (_controller.myHandle == null) {
            return ClaimHandleView(controller: _controller);
          }
          return ProfileView(controller: _controller);
        },
      ),
    );
  }
}

class ClaimHandleView extends StatefulWidget {
  final InventorProfileController controller;

  const ClaimHandleView({super.key, required this.controller});

  @override
  State<ClaimHandleView> createState() => _ClaimHandleViewState();
}

class _ClaimHandleViewState extends State<ClaimHandleView> {
  final _handleController = TextEditingController();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  String? _error;
  bool _isSubmitting = false;

  Future<void> _submit() async {
    final handle = _handleController.text.trim();
    if (!RegExp(r'^[a-z0-9_-]{3,20}$').hasMatch(handle)) {
      setState(() => _error = 'Handle must be 3-20 characters: lowercase letters, numbers, - or _ only.');
      return;
    }
    if (_nameController.text.trim().isEmpty) {
      setState(() => _error = 'Enter a display name.');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    final error = await widget.controller.claimHandle(handle, _nameController.text, _bioController.text);

    setState(() {
      _isSubmitting = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Icon(Icons.badge_outlined, size: 48, color: Colors.indigo),
          const SizedBox(height: 12),
          const Text('Claim your Inventor Handle', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'A public, permanent identity for everything you publish — websites, templates, and plugins — on one page anyone on the internet can visit.',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 20),
          TextField(controller: _handleController, decoration: const InputDecoration(labelText: 'Handle', prefixText: '@', border: OutlineInputBorder(), hintText: 'e.g. chidi-builds')),
          const SizedBox(height: 12),
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Display name', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _bioController, maxLines: 3, decoration: const InputDecoration(labelText: 'Short bio (optional)', border: OutlineInputBorder())),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: const TextStyle(color: Colors.red)),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Claim Handle'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileView extends StatefulWidget {
  final InventorProfileController controller;

  const ProfileView({super.key, required this.controller});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isPublishing = false;

  Future<void> _editBio() async {
    final profile = widget.controller.myProfile;
    if (profile == null) return;
    final nameController = TextEditingController(text: profile.identity.displayName);
    final bioController = TextEditingController(text: profile.identity.bio);

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Display name')),
            TextField(controller: bioController, maxLines: 3, decoration: const InputDecoration(labelText: 'Bio')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );
    if (saved != true) return;
    await widget.controller.updateBio(nameController.text, bioController.text);
  }

  Future<void> _publish() async {
    setState(() => _isPublishing = true);
    await widget.controller.publishProfilePage();
    setState(() => _isPublishing = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your public profile page is live')));
  }

  void _copyLink() {
    final url = widget.controller.publicPageUrl;
    if (url == null) return;
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied')));
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.controller.myProfile;
    if (profile == null) return const Center(child: Text('Could not load your profile.'));

    final identity = profile.identity;
    final publicUrl = widget.controller.publicPageUrl;

    return RefreshIndicator(
      onRefresh: widget.controller.refresh,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              CircleAvatar(radius: 28, backgroundColor: Colors.indigo, child: Text(identity.displayName.isNotEmpty ? identity.displayName[0].toUpperCase() : '?', style: const TextStyle(color: Colors.white, fontSize: 22))),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(identity.displayName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('@${identity.handle}', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.edit_outlined), onPressed: _editBio),
            ],
          ),
          if (identity.bio.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(identity.bio, style: const TextStyle(fontSize: 14)),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              _StatChip(label: 'Sites', value: profile.sites.length),
              const SizedBox(width: 8),
              _StatChip(label: 'Templates', value: profile.templates.length),
              const SizedBox(width: 8),
              _StatChip(label: 'Plugins', value: profile.plugins.length),
              const SizedBox(width: 8),
              _StatChip(label: 'Cited', value: profile.citationsReceived),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: const Icon(Icons.public),
              label: Text(_isPublishing ? 'Publishing...' : 'Publish / Update Public Page'),
              onPressed: _isPublishing ? null : _publish,
            ),
          ),
          if (publicUrl != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.indigo.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(child: Text(publicUrl, style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
                  IconButton(icon: const Icon(Icons.copy, size: 18), onPressed: _copyLink),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.open_in_new), label: const Text('Open'), onPressed: () => launchUrl(Uri.parse(publicUrl), mode: LaunchMode.externalApplication))),
                const SizedBox(width: 8),
                Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.share), label: const Text('Share'), onPressed: () => Share.share(publicUrl))),
              ],
            ),
          ],
          const SizedBox(height: 28),
          _Section(title: 'Published Websites', items: profile.sites.map((s) => s.projectName).toList()),
          _Section(title: 'Shared Templates', items: profile.templates.map((t) => t.title).toList()),
          _Section(title: 'Published Plugins', items: profile.plugins.map((p) => p.name).toList()),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text('$value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
            Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<String> items;

  const _Section({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          if (items.isEmpty)
            Text('Nothing here yet.', style: TextStyle(color: Colors.grey.shade500, fontSize: 13))
          else
            ...items.map((item) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text('• $item'))),
        ],
      ),
    );
  }
}
