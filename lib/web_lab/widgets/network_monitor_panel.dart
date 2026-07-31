import 'package:flutter/material.dart';
import '../devtools/network_models.dart';

/// Displays every `fetch`/`XMLHttpRequest` call made by the student's
/// JavaScript while the preview runs — the DevTools Suite's equivalent
/// of a browser's Network panel.
class NetworkMonitorPanel extends StatelessWidget {
  final List<NetworkRequestEntry> requests;
  final VoidCallback onClear;

  const NetworkMonitorPanel({
    super.key,
    required this.requests,
    required this.onClear,
  });

  Color _statusColor(NetworkRequestEntry entry) {
    if (entry.failed || entry.statusCode == null) return Colors.red;
    if (entry.statusCode! >= 400) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            children: [
              const Icon(Icons.swap_vert, size: 16),
              const SizedBox(width: 6),
              Text('${requests.length} request${requests.length == 1 ? '' : 's'}'),
              const Spacer(),
              IconButton(
                tooltip: 'Clear',
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: onClear,
              ),
            ],
          ),
        ),
        Expanded(
          child: requests.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Network calls made by your script.js will appear here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: requests.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final entry = requests[index];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 6,
                        backgroundColor: _statusColor(entry),
                      ),
                      title: Text(
                        entry.url,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                      ),
                      subtitle: Text(
                        '${entry.method} · ${entry.statusCode ?? 'failed'} · ${entry.durationMs}ms · ${entry.requestType}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
