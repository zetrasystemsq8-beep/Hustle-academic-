import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'build_service.dart';

// ============================================================
// BUILD CENTER SCREEN — Main Build Interface
// ============================================================

class BuildCenterScreen extends ConsumerStatefulWidget {
  final String projectId;
  final String projectName;
  final BuildService buildService;

  const BuildCenterScreen({
    required this.projectId,
    required this.projectName,
    required this.buildService,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BuildCenterScreen> createState() => _BuildCenterScreenState();
}

class _BuildCenterScreenState extends ConsumerState<BuildCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late BuildService _buildService;
  bool _isBuilding = false;
  String? _activeBuildId;
  StreamSubscription<String>? _logSubscription;
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Reuse the BuildService the caller already created/started a build
    // on — do NOT construct a second one here, or this screen will be
    // watching a different service instance than the one running the build.
    _buildService = widget.buildService;
    _logSubscription = _buildService.logStream.listen((log) {
      if (mounted) setState(() => _logs.add(log));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _logSubscription?.cancel();
    // Don't dispose _buildService here — its owner (MobileEditorScreen)
    // is responsible for disposing it.
    super.dispose();
  }

  Future<void> _startBuild() async {
    // This screen doesn't have the project's zip bytes — builds are
    // started from the project editor's "Generate APK" button, which
    // zips the project and calls BuildService.createBuild before
    // navigating here. Retry/rebuild should be triggered from there too.
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Go back to the project editor and tap "Generate APK" to start a new build.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Build Center - ${widget.projectName}'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active Build', icon: Icon(Icons.build)),
            Tab(text: 'History', icon: Icon(Icons.history)),
            Tab(text: 'Logs', icon: Icon(Icons.description)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveBuildTab(),
          _buildHistoryTab(),
          _buildLogsTab(),
        ],
      ),
      floatingActionButton: !_isBuilding
          ? FloatingActionButton.extended(
              onPressed: _startBuild,
              label: const Text('Generate APK'),
              icon: const Icon(Icons.download),
              backgroundColor: Colors.deepPurple,
            )
          : null,
    );
  }

  Widget _buildActiveBuildTab() {
    return StreamBuilder<BuildJob>(
      stream: _buildService.buildJobStream,
      // Seeds the StreamBuilder with the last known build so switching
      // tabs and coming back doesn't show "No active builds" — without
      // this, the StreamBuilder has nothing to show until a NEW event
      // fires after the widget rebuilds.
      initialData: _buildService.latestBuildJob,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.build, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No active builds',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Start a new build to see progress here',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        }

        final build = snapshot.data!;
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
          // Build Header
          _buildBuildHeader(build),
          const SizedBox(height: 24),

          // Progress Bar
          _buildProgressIndicator(build),
          const SizedBox(height: 24),

          // Build Stages
          Text(
            'Build Stages',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _buildStagesList(build),
          const SizedBox(height: 24),

          // Current Message
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
                  child: Text(
                    build.currentMessage,
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Action Buttons
          if (build.status == BuildStatus.uploading ||
              build.status == BuildStatus.queued ||
              build.status == BuildStatus.preparingEnvironment ||
              build.status == BuildStatus.installingFlutter ||
              build.status == BuildStatus.installingDependencies ||
              build.status == BuildStatus.runningPubGet ||
              build.status == BuildStatus.analyzingProject ||
              build.status == BuildStatus.compilingReleaseApk ||
              build.status == BuildStatus.optimizingApk ||
              build.status == BuildStatus.signingApk ||
              build.status == BuildStatus.uploadingApk)
            ElevatedButton.icon(
              onPressed: () => _buildService.cancelBuild(build.id),
              label: const Text('Cancel Build'),
              icon: const Icon(Icons.cancel),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            )
          else if (build.status == BuildStatus.complete)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _downloadAndInstall(build),
                    label: const Text('Download APK'),
                    icon: const Icon(Icons.download),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _startBuild(),
                    label: const Text('Rebuild'),
                    icon: const Icon(Icons.refresh),
                  ),
                ),
              ],
            )
          else if (build.status == BuildStatus.failed)
            ElevatedButton.icon(
              onPressed: () => _startBuild(),
              label: const Text('Retry Build'),
              icon: const Icon(Icons.refresh),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
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
                      'Build #${build.id.substring(0, 8)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTime(build.createdAt),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Chip(
                label: Text(
                  build.status.name.replaceAll('_', ' ').toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: _getStatusColor(build.status),
              ),
            ],
          ),
          if (build.completedAt != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Build time: ${build.buildTimeSeconds}s',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
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
            Text(
              'Progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${build.progressPercentage.toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: build.progressPercentage / 100,
            minHeight: 12,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              _getStatusColor(build.status),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStagesList(BuildJob build) {
    return Column(
      children: build.stages.map((stage) {
        return _buildStageItem(stage);
      }).toList(),
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue[700]!,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.grey[400],
                        ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage.displayName,
                  style: TextStyle(
                    fontWeight: stage.isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (stage.completedAt != null)
                  Text(
                    _formatTime(stage.completedAt!),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
              ],
            ),
          ),
          Text(
            stage.icon,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return StreamBuilder<List<BuildJob>>(
      stream: _buildService.historyStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No build history',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        final builds = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: builds.length,
          itemBuilder: (context, index) {
            return _buildHistoryItem(builds[index]);
          },
        );
      },
    );
  }

  Widget _buildHistoryItem(BuildJob build) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text('Build #${build.id.substring(0, 8)}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(_formatTime(build.createdAt)),
            if (build.buildTimeSeconds > 0)
              Text('Time: ${build.buildTimeSeconds}s'),
          ],
        ),
        trailing: Chip(
          label: Text(build.status.name.replaceAll('_', ' ')),
          backgroundColor: _getStatusColor(build.status),
          labelStyle: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          setState(() => _activeBuildId = build.id);
          _tabController.animateTo(0);
        },
      ),
    );
  }

  Widget _buildLogsTab() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Build Console',
            style: TextStyle(
              color: Colors.green[400],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    _logs.join('\n'),
                    style: TextStyle(
                      color: Colors.green[400],
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadAndInstall(BuildJob build) async {
    // TODO: Implement download and install logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download and install feature coming soon')),
    );
  }

  Color _getStatusColor(BuildStatus status) {
    switch (status) {
      case BuildStatus.uploading:
      case BuildStatus.queued:
        return Colors.blue;
      case BuildStatus.preparingEnvironment:
      case BuildStatus.installingFlutter:
      case BuildStatus.installingDependencies:
      case BuildStatus.runningPubGet:
      case BuildStatus.analyzingProject:
      case BuildStatus.compilingReleaseApk:
      case BuildStatus.optimizingApk:
      case BuildStatus.signingApk:
      case BuildStatus.uploadingApk:
        return Colors.orange;
      case BuildStatus.complete:
        return Colors.green;
      case BuildStatus.failed:
        return Colors.red;
      case BuildStatus.cancelled:
        return Colors.grey;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
