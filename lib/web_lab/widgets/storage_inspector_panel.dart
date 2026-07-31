import 'package:flutter/material.dart';
import '../devtools/storage_models.dart';

/// Displays localStorage, sessionStorage, and cookies for the live
/// preview in three tabs — the DevTools Suite's equivalent of a
/// browser's Application/Storage panel.
class StorageInspectorPanel extends StatefulWidget {
  final StorageSnapshot snapshot;
  final VoidCallback onRefresh;

  const StorageInspectorPanel({
    super.key,
    required this.snapshot,
    required this.onRefresh,
  });

  @override
  State<StorageInspectorPanel> createState() => _StorageInspectorPanelState();
}

class _StorageInspectorPanelState extends State<StorageInspectorPanel> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).colorScheme.primary,
                tabs: const [
                  Tab(text: 'Local'),
                  Tab(text: 'Session'),
                  Tab(text: 'Cookies'),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Refresh',
              icon: const Icon(Icons.refresh, size: 20),
              onPressed: widget.onRefresh,
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildList(widget.snapshot.forKind(StorageKind.local)),
              _buildList(widget.snapshot.forKind(StorageKind.session)),
              _buildList(widget.snapshot.forKind(StorageKind.cookie)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<StorageEntry> entries) {
    if (entries.isEmpty) {
      return const Center(child: Text('Empty', style: TextStyle(color: Colors.grey)));
    }
    return ListView.separated(
      itemCount: entries.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.key, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              Text(entry.value, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.black54)),
            ],
          ),
        );
      },
    );
  }
}
