import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'build_service.dart';

// ============================================================
// BUILD HISTORY SCREEN — Full History with Actions
// ============================================================

class BuildHistoryScreen extends ConsumerStatefulWidget {
  final BuildService buildService;

  const BuildHistoryScreen({required this.buildService, Key? key})
      : super(key: key);

  @override
  ConsumerState<BuildHistoryScreen> createState() =>
      _BuildHistoryScreenState();
}

class _BuildHistoryScreenState extends ConsumerState<BuildHistoryScreen> {
  String _filterStatus = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BuildJob> _filterBuilds(List<BuildJob> builds) {
    var filtered = builds;

    if (_filterStatus != 'all') {
      filtered = filtered.where((b) {
        switch (_filterStatus) {
          case 'success':
            return b.status == BuildStatus.complete;
          case 'failed':
            return b.status == BuildStatus.failed;
          case 'cancelled':
            return b.status == BuildStatus.cancelled;
          case 'active':
            return b.status != BuildStatus.complete &&
                b.status != BuildStatus.failed &&
                b.status != BuildStatus.cancelled;
          default:
            return true;
        }
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((b) =>
              b.projectName.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build History'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          _buildSearchAndFilterBar(),
          Expanded(
            child: StreamBuilder<List<BuildJob>>(
              stream: widget.buildService.historyStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final builds = _filterBuilds(snapshot.data!);

                if (builds.isEmpty) {
                  return _buildEmptyState();
                }

                return _buildHistoryGrid(builds);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search builds by project name...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('all', 'All Builds'),
                const SizedBox(width: 8),
                _buildFilterChip('active', 'Active'),
                const SizedBox(width: 8),
                _buildFilterChip('success', 'Success'),
                const SizedBox(width: 8),
                _buildFilterChip('failed', 'Failed'),
                const SizedBox(width: 8),
                _buildFilterChip('cancelled', 'Cancelled'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _filterStatus == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _filterStatus = value);
      },
      selectedColor: Colors.deepPurple[100],
      checkmarkColor: Colors.deepPurple,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No builds found',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryGrid(List<BuildJob> builds) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: builds.length,
      itemBuilder: (context, index) {
        return _buildDetailedHistoryCard(builds[index]);
      },
    );
  }

  Widget _buildDetailedHistoryCard(BuildJob build) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        build.projectName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Build #${build.id.substring(0, 8)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(build.status),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(Icons.calendar_today, 'Date',
                _formatDateTime(build.createdAt)),
            const SizedBox(height: 8),
            if (build.buildTimeSeconds > 0)
              _buildInfoRow(Icons.timer, 'Build Time',
                  '${build.buildTimeSeconds}s'),
            if (build.apkSize != null) ...[
              const SizedBox(height: 8),
              _buildInfoRow(Icons.storage, 'APK Size', build.apkSize!),
            ],
            if (build.flutterVersion != null) ...[
              const SizedBox(height: 8),
              _buildInfoRow(
                  Icons.flutter_dash, 'Flutter Version', build.flutterVersion!),
            ],
            const SizedBox(height: 16),
            _buildActionButtons(build),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildStatus status) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case BuildStatus.complete:
        color = Colors.green;
        label = 'Success';
        icon = Icons.check_circle;
        break;
      case BuildStatus.failed:
        color = Colors.red;
        label = 'Failed';
        icon = Icons.error;
        break;
      case BuildStatus.cancelled:
        color = Colors.grey;
        label = 'Cancelled';
        icon = Icons.cancel;
        break;
      default:
        color = Colors.orange;
        label = 'Building';
        icon = Icons.hourglass_empty;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildJob build) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (build.status == BuildStatus.complete)
          _buildActionButton(
            icon: Icons.download,
            label: 'Download',
            color: Colors.green,
            onPressed: () => _downloadApk(build),
          ),
        if (build.status == BuildStatus.complete)
          _buildActionButton(
            icon: Icons.install_mobile,
            label: 'Install',
            color: Colors.blue,
            onPressed: () => _installApk(build),
          ),
        _buildActionButton(
          icon: Icons.description,
          label: 'View Logs',
          color: Colors.grey[700]!,
          onPressed: () => _viewLogs(build),
        ),
        _buildActionButton(
          icon: Icons.refresh,
          label: 'Rebuild',
          color: Colors.orange,
          onPressed: () => _rebuild(build),
        ),
        _buildActionButton(
          icon: Icons.delete,
          label: 'Delete',
          color: Colors.red,
          onPressed: () => _deleteBuild(build),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16, color: color),
      label: Text(label, style: TextStyle(color: color, fontSize: 12)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }

  /// Opens the APK's signed download URL in the system browser/download
  /// manager. This is a real download — Android handles it and shows
  /// progress in its notification shade, unlike the previous stub
  /// which only displayed a SnackBar and did nothing else.
  Future<void> _downloadApk(BuildJob build) async {
    final url = await widget.buildService.downloadApk(build.id);
    if (url == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No download URL available for this build')),
        );
      }
      return;
    }

    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            launched
                ? 'Downloading APK — check your notifications or Downloads folder'
                : 'Could not open the download link',
          ),
        ),
      );
    }
  }

  /// There is no true one-tap in-app APK installer without a native
  /// platform channel or a plugin like open_filex + a configured
  /// FileProvider. This hands the signed URL to the system, which
  /// downloads the file and lets the user tap it (or the download
  /// notification) to install — Android will prompt for the
  /// "install unknown apps" permission the first time.
  Future<void> _installApk(BuildJob build) async {
    final url = await widget.buildService.downloadApk(build.id);
    if (url == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No APK available for this build')),
        );
      }
      return;
    }

    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            launched
                ? 'Downloading — Android will prompt to install once the file is ready. You may need to allow "install unknown apps" for this browser.'
                : 'Could not start the install',
          ),
        ),
      );
    }
  }

  /// Fetches and shows the exact raw log file the GitHub Actions
  /// runner produced for this build — real command output, not the
  /// short cached build.buildLogs summary.
  void _viewLogs(BuildJob build) {
    showDialog(
      context: context,
      builder: (context) => _LogDialog(buildService: widget.buildService, build: build),
    );
  }

  Future<void> _rebuild(BuildJob build) async {
    try {
      final zipBytes = await widget.buildService.supabase.storage
          .from('project-zips')
          .download('${build.userId}/${build.id}.zip');

      await widget.buildService.createBuild(
        projectId: build.projectId,
        projectName: build.projectName,
        projectZipBytes: zipBytes,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rebuild started')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rebuild failed: $e')),
        );
      }
    }
  }

  Future<void> _deleteBuild(BuildJob build) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Build?'),
        content: Text(
            'This will permanently delete this build record for ${build.projectName}.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await widget.buildService.supabase
            .from('build_jobs')
            .delete()
            .eq('id', build.id);
        await widget.buildService.loadBuildHistory();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete: $e')),
          );
        }
      }
    }
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

/// Fetches and displays the exact raw log file produced by the
/// GitHub Actions runner for this build.
class _LogDialog extends StatefulWidget {
  final BuildService buildService;
  final BuildJob build;

  const _LogDialog({required this.buildService, required this.build});

  @override
  State<_LogDialog> createState() => _LogDialogState();
}

class _LogDialogState extends State<_LogDialog> {
  String? _log;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final log = await widget.buildService.fetchFullBuildLog(widget.build.id);
    if (!mounted) return;
    setState(() {
      _log = log;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Logs — ${widget.build.projectName}'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(12),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: SelectableText(
                    _log ?? widget.build.buildLogs ?? widget.build.errorLogs ?? 'No logs available',
                    style: TextStyle(
                      color: widget.build.status == BuildStatus.failed ? Colors.red[300] : Colors.green[400],
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }
}
