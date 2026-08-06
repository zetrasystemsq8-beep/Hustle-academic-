import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'build_service.dart';

// ============================================================
// BUILD CONSOLE WIDGET — Live streaming terminal-style logs
// ============================================================

enum LogLevel { info, success, warning, error, command }

class LogEntry {
  final String message;
  final LogLevel level;
  final DateTime timestamp;

  LogEntry({
    required this.message,
    required this.level,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  static LogLevel _detectLevel(String message) {
    final lower = message.toLowerCase();
    if (lower.contains('❌') || lower.contains('error') || lower.contains('failed')) {
      return LogLevel.error;
    }
    if (lower.contains('⚠️') || lower.contains('warning')) {
      return LogLevel.warning;
    }
    if (lower.contains('✅') || lower.contains('success') || lower.contains('complete')) {
      return LogLevel.success;
    }
    if (lower.startsWith('\$') || lower.startsWith('>')) {
      return LogLevel.command;
    }
    return LogLevel.info;
  }

  factory LogEntry.fromMessage(String message) {
    return LogEntry(message: message, level: _detectLevel(message));
  }
}

class BuildConsoleWidget extends StatefulWidget {
  final BuildService buildService;
  final String? buildId;
  final bool autoScroll;
  final bool showTimestamps;

  const BuildConsoleWidget({
    required this.buildService,
    this.buildId,
    this.autoScroll = true,
    this.showTimestamps = true,
    Key? key,
  }) : super(key: key);

  @override
  State<BuildConsoleWidget> createState() => _BuildConsoleWidgetState();
}

class _BuildConsoleWidgetState extends State<BuildConsoleWidget> {
  final List<LogEntry> _logs = [];
  final ScrollController _scrollController = ScrollController();
  StreamSubscription<String>? _logSubscription;
  bool _isPaused = false;
  bool _wordWrap = true;
  double _fontSize = 12;
  final List<LogEntry> _pausedBuffer = [];

  @override
  void initState() {
    super.initState();
    _subscribeToLogs();
  }

  void _subscribeToLogs() {
    _logSubscription = widget.buildService.logStream.listen((message) {
      final entry = LogEntry.fromMessage(message);
      if (_isPaused) {
        _pausedBuffer.add(entry);
      } else {
        setState(() => _logs.add(entry));
        if (widget.autoScroll) {
          _scrollToBottom();
        }
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (!_isPaused) {
        _logs.addAll(_pausedBuffer);
        _pausedBuffer.clear();
        _scrollToBottom();
      }
    });
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
      _pausedBuffer.clear();
    });
  }

  Future<void> _copyLogs() async {
    final text = _logs.map((l) => _formatLogLine(l)).join('\n');
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logs copied to clipboard')),
      );
    }
  }

  String _formatLogLine(LogEntry entry) {
    final timestamp = widget.showTimestamps
        ? '[${_formatTimestamp(entry.timestamp)}] '
        : '';
    return '$timestamp${entry.message}';
  }

  String _formatTimestamp(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }

  Color _getLogColor(LogLevel level) {
    switch (level) {
      case LogLevel.error:
        return Colors.red[400]!;
      case LogLevel.warning:
        return Colors.orange[400]!;
      case LogLevel.success:
        return Colors.green[400]!;
      case LogLevel.command:
        return Colors.cyan[300]!;
      case LogLevel.info:
        return Colors.grey[300]!;
    }
  }

  IconData? _getLogIcon(LogLevel level) {
    switch (level) {
      case LogLevel.error:
        return Icons.error_outline;
      case LogLevel.warning:
        return Icons.warning_amber;
      case LogLevel.success:
        return Icons.check_circle_outline;
      case LogLevel.command:
        return Icons.chevron_right;
      case LogLevel.info:
        return null;
    }
  }

  @override
  void dispose() {
    _logSubscription?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        children: [
          _buildConsoleToolbar(),
          const Divider(height: 1, color: Colors.grey),
          Expanded(child: _buildLogArea()),
          _buildConsoleFooter(),
        ],
      ),
    );
  }

  Widget _buildConsoleToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(right: 6),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const Text(
            'Build Console',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              _isPaused ? Icons.play_arrow : Icons.pause,
              color: Colors.grey[400],
              size: 18,
            ),
            tooltip: _isPaused ? 'Resume' : 'Pause',
            onPressed: _togglePause,
          ),
          IconButton(
            icon: Icon(Icons.copy, color: Colors.grey[400], size: 18),
            tooltip: 'Copy logs',
            onPressed: _copyLogs,
          ),
          IconButton(
            icon: Icon(Icons.wrap_text, 
              color: _wordWrap ? Colors.blue[300] : Colors.grey[400], 
              size: 18),
            tooltip: 'Toggle word wrap',
            onPressed: () => setState(() => _wordWrap = !_wordWrap),
          ),
          IconButton(
            icon: Icon(Icons.clear_all, color: Colors.grey[400], size: 18),
            tooltip: 'Clear logs',
            onPressed: _clearLogs,
          ),
        ],
      ),
    );
  }

  Widget _buildLogArea() {
    if (_logs.isEmpty) {
      return Center(
        child: Text(
          _isPaused ? 'Console paused...' : 'Waiting for build output...',
          style: TextStyle(color: Colors.grey[600], fontSize: 13),
        ),
      );
    }

    return Scrollbar(
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          final entry = _logs[index];
          return _buildLogLine(entry, index);
        },
      ),
    );
  }

  Widget _buildLogLine(LogEntry entry, int index) {
    final icon = _getLogIcon(entry.level);
    final color = _getLogColor(entry.level);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: _fontSize - 2,
                fontFamily: 'monospace',
              ),
            ),
          ),
          if (widget.showTimestamps) ...[
            Text(
              _formatTimestamp(entry.timestamp),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: _fontSize - 2,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (icon != null) ...[
            Icon(icon, size: _fontSize + 2, color: color),
            const SizedBox(width: 4),
          ],
          Expanded(
            child: SelectableText(
              entry.message,
              maxLines: _wordWrap ? null : 1,
              overflow: _wordWrap ? null : TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: _fontSize,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsoleFooter() {
    final errorCount = _logs.where((l) => l.level == LogLevel.error).length;
    final warningCount = _logs.where((l) => l.level == LogLevel.warning).length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Row(
        children: [
          Text(
            '${_logs.length} lines',
            style: TextStyle(color: Colors.grey[500], fontSize: 11),
          ),
          const SizedBox(width: 16),
          if (errorCount > 0) ...[
            Icon(Icons.error, size: 12, color: Colors.red[400]),
            const SizedBox(width: 4),
            Text('$errorCount', style: TextStyle(color: Colors.red[400], fontSize: 11)),
            const SizedBox(width: 16),
          ],
          if (warningCount > 0) ...[
            Icon(Icons.warning, size: 12, color: Colors.orange[400]),
            const SizedBox(width: 4),
            Text('$warningCount', style: TextStyle(color: Colors.orange[400], fontSize: 11)),
          ],
          const Spacer(),
          if (_isPaused)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange[900],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'PAUSED (${_pausedBuffer.length} buffered)',
                style: TextStyle(color: Colors.orange[200], fontSize: 10),
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================
// FULL-SCREEN LOG VIEWER (for failed build error inspection)
// ============================================================

class FullScreenLogViewer extends StatelessWidget {
  final String title;
  final String logs;
  final bool isError;

  const FullScreenLogViewer({
    required this.title,
    required this.logs,
    this.isError = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF161B22),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: logs));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SelectableText(
          logs,
          style: TextStyle(
            color: isError ? Colors.red[300] : Colors.green[300],
            fontFamily: 'monospace',
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
