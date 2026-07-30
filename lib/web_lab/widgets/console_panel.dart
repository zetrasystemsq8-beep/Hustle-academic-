import 'package:flutter/material.dart';
import '../controllers/console_controller.dart';
import '../models/console_log_model.dart';

/// Displays the running list of console output, warnings, and errors
/// produced while a project's preview executes. Purely a rendering
/// surface over [ConsoleController] — no logic of its own beyond
/// formatting and filtering.
class ConsolePanel extends StatefulWidget {
  final ConsoleController consoleController;

  const ConsolePanel({super.key, required this.consoleController});

  @override
  State<ConsolePanel> createState() => _ConsolePanelState();
}

class _ConsolePanelState extends State<ConsolePanel> {
  ConsoleLogLevel? _filter;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.consoleController,
      builder: (context, _) {
        final entries = widget.consoleController.entries
            .where((e) => _filter == null || e.level == _filter)
            .toList()
            .reversed
            .toList();

        return Column(
          children: [
            _buildHeader(),
            Expanded(
              child: entries.isEmpty
                  ? Center(
                      child: Text(
                        'Console output will appear here',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (context, index) => _ConsoleEntryTile(entry: entries[index]),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.terminal, size: 16),
          const SizedBox(width: 6),
          const Text('Console', style: TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          _FilterChip(
            label: 'All',
            selected: _filter == null,
            onTap: () => setState(() => _filter = null),
          ),
          _FilterChip(
            label: 'Errors',
            selected: _filter == ConsoleLogLevel.error,
            onTap: () => setState(() => _filter = ConsoleLogLevel.error),
            color: Colors.redAccent,
          ),
          _FilterChip(
            label: 'Warnings',
            selected: _filter == ConsoleLogLevel.warning,
            onTap: () => setState(() => _filter = ConsoleLogLevel.warning),
            color: Colors.amber,
          ),
          IconButton(
            tooltip: 'Clear console',
            icon: const Icon(Icons.delete_outline, size: 18),
            onPressed: widget.consoleController.clear,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ChoiceChip(
        label: Text(label, style: const TextStyle(fontSize: 11)),
        selected: selected,
        onSelected: (_) => onTap(),
        visualDensity: VisualDensity.compact,
        labelStyle: TextStyle(color: selected ? (color ?? theme.colorScheme.primary) : null),
      ),
    );
  }
}

class _ConsoleEntryTile extends StatelessWidget {
  final ConsoleLogEntry entry;

  const _ConsoleEntryTile({required this.entry});

  Color _colorFor(BuildContext context) {
    switch (entry.level) {
      case ConsoleLogLevel.error:
        return Colors.redAccent;
      case ConsoleLogLevel.warning:
        return Colors.amber;
      case ConsoleLogLevel.log:
        return Theme.of(context).colorScheme.onSurface;
    }
  }

  IconData get _iconFor {
    switch (entry.level) {
      case ConsoleLogLevel.error:
        return Icons.error_outline;
      case ConsoleLogLevel.warning:
        return Icons.warning_amber_outlined;
      case ConsoleLogLevel.log:
        return Icons.chevron_right;
    }
  }

  String get _sourceLabel {
    switch (entry.source) {
      case ConsoleSource.javascript:
        return 'JS';
      case ConsoleSource.html:
        return 'HTML';
      case ConsoleSource.css:
        return 'CSS';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.15))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_iconFor, size: 14, color: color),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(_sourceLabel, style: TextStyle(fontSize: 9, color: color)),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              entry.line != null ? '${entry.message} (line ${entry.line})' : entry.message,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: entry.level == ConsoleLogLevel.log ? null : color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
