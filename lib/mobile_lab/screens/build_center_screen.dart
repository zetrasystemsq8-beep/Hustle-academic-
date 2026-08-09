import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'build_service.dart';

class BuildCenterScreen extends StatefulWidget {
  final BuildService buildService;
  final String projectId;
  final String projectName;

  const BuildCenterScreen({
    required this.buildService,
    required this.projectId,
    required this.projectName,
    Key? key,
  }) : super(key: key);

  @override
  State<BuildCenterScreen> createState() => _BuildCenterScreenState();
}

class _BuildCenterScreenState extends State<BuildCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _liveStageFeed = [];

  String? _fullLog;
  bool _isLoadingFullLog = false;
  String? _fullLogFetchedForBuildId;
  BuildStatus? _lastKnownStatus;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    widget.buildService.logStream.listen((line) {
      if (!mounted) return;
      setState(() => _liveStageFeed.add(line));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _isTerminal(BuildStatus status) =>
      status == BuildStatus.complete || status == BuildStatus.failed || status == BuildStatus.cancelled;

  Future<void> _maybeAutoFetchFullLog(BuildJob build) async {
    final justFinished = _isTerminal(build.status) &&
        (_lastKnownStatus == null || !_isTerminal(_lastKnownStatus!));
    _lastKnownStatus = build.status;

    if (justFinished && _fullLogFetchedForBuildId != build.id) {
      await _fetchFullLog(build.id);
    }
  }

  Future<void> _fetchFullLog(String buildId) async {
    setState(() => _isLoadingFullLog = true);
    final log = await widget.buildService.fetchFullBuildLog(buildId);
    if (!mounted) return;
    setState(() {
      _fullLog = log;
      _fullLogFetchedForBuildId = buildId;
      _isLoadingFullLog = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Build Center — ${widget.projectName}'),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Progress', icon: Icon(Icons.build)),
            Tab(text: 'Console', icon: Icon(Icons.terminal)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProgressTab(),
          _buildConsoleTab(),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return StreamBuilder<BuildJob>(
      stream: widget.buildService.buildJobStream
          .where((job) => job.projectId == widget.projectId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text('Waiting for build to start...',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          );
        }

        final build = snapshot.data!;
        _maybeAutoFetchFullLog(build);
        return _buildActiveBuildWidget(build);
      },
    );
  }

  Widget _buildActiveBuildWidget(BuildJob build) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBuildHeader(build),
          const SizedBox(height: 24),
          _buildProgressIndicator(build),
          const SizedBox(height: 24),
          Text('Build Stages', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...build.stages.map(_buildStageItem),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              border: Border.all(color: Colors.blue[200]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue[700]),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(build.currentMessage,
                      style: TextStyle(color: Colors.blue[900])),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButtons(build),
        ],
      ),
    );
  }

  Widget _buildBuildHeader(BuildJob build) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getStatusColor(build.status).withOpacity(0.1),
        border: Border.all(color: _getStatusColor(build.status)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Build #${build.id.substring(0, 8)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(_formatTime(build.createdAt),
                    style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          Chip(
            label: Text(build.status.name.toUpperCase(),
                style: const TextStyle(color: Colors.white)),
            backgroundColor: _getStatusColor(build.status),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BuildJob build) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Progress', style: Theme.of(context).textTheme.titleMedium),
            Text('${build.progressPercentage.toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.deepPurple)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: build.progressPercentage / 100,
            minHeight: 12,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(build.status)),
          ),
        ),
      ],
    );
  }

  Widget _buildStageItem(BuildStageInfo stage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: stage.isCompleted
            ? Colors.green[50]
            : stage.isActive
                ? Colors.blue[50]
                : Colors.grey[50],
        border: Border.all(
          color: stage.isCompleted
              ? Colors.green[300]!
              : stage.isActive
                  ? Colors.blue[300]!
                  : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: stage.isCompleted
                  ? Icon(Icons.check_circle, color: Colors.green[700])
                  : stage.isActive
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                          ),
                        )
                      : Icon(Icons.radio_button_unchecked, color: Colors.grey[400]),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              stage.displayName,
              style: TextStyle(fontWeight: stage.isActive ? FontWeight.bold : FontWeight.normal),
            ),
          ),
          Text(stage.icon, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildJob build) {
    final isRunning = !_isTerminal(build.status);

    if (isRunning) {
      return ElevatedButton.icon(
        onPressed: () => widget.buildService.cancelBuild(build.id),
        label: const Text('Cancel Build'),
        icon: const Icon(Icons.cancel),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      );
    }

    if (build.status == BuildStatus.complete) {
      return ElevatedButton.icon(
        onPressed: () => _downloadApk(build),
        label: const Text('Download APK'),
        icon: const Icon(Icons.download),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      );
    }

    return const SizedBox.shrink();
  }

  Future<void> _downloadApk(BuildJob build) async {
    final url = await widget.buildService.downloadApk(build.id);
    if (url == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not get a download link. Try again.')),
        );
      }
      return;
    }

    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the download. Check that a browser is available.')),
      );
    }
  }

  Widget _buildConsoleTab() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF161B22),
            child: Row(
              children: [
                Text(
                  _fullLog != null ? 'Full build log' : 'Live stage feed',
                  style: TextStyle(color: Colors.green[400], fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const Spacer(),
                if (_isLoadingFullLog)
                  const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                else
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white70, size: 18),
                    tooltip: 'Fetch full log',
                    onPressed: () {
                      final id = _fullLogFetchedForBuildId ?? _liveStageFeed.isNotEmpty
                          ? _fullLogFetchedForBuildId
                          : null;
                      // Use the most recent build id we've seen via progress stream.
                      widget.buildService.buildJobStream
                          .where((j) => j.projectId == widget.projectId)
                          .first
                          .then((job) => _fetchFullLog(job.id));
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              reverse: _fullLog == null,
              padding: const EdgeInsets.all(16),
              child: SelectableText(
                _fullLog ?? (_liveStageFeed.isEmpty
                    ? 'Waiting for build output...'
                    : _liveStageFeed.join('\n')),
                style: TextStyle(
                  color: _fullLog != null ? Colors.grey[300] : Colors.green[400],
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(BuildStatus status) {
    switch (status) {
      case BuildStatus.uploading:
      case BuildStatus.queued:
        return Colors.blue;
      case BuildStatus.complete:
        return Colors.green;
      case BuildStatus.failed:
        return Colors.red;
      case BuildStatus.cancelled:
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  String _formatTime(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
