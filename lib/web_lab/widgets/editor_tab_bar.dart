import 'package:flutter/material.dart';
import '../controllers/editor_controller.dart';
import '../utils/file_icons.dart';

/// Horizontal row of open-file tabs above the [CodeEditorWidget],
/// supporting multi-file editing: tap to switch, close button per tab,
/// and a dirty-state dot for unsaved edits.
class EditorTabBar extends StatelessWidget {
  final List<EditorTab> tabs;
  final String? activeFileId;
  final ValueChanged<EditorTab> onTabSelected;
  final ValueChanged<EditorTab> onTabClosed;

  const EditorTabBar({
    super.key,
    required this.tabs,
    required this.activeFileId,
    required this.onTabSelected,
    required this.onTabClosed,
  });

  @override
  Widget build(BuildContext context) {
    if (tabs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 40,
      color: const Color(0xFF252526),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isActive = tab.file.id == activeFileId;
          return _TabChip(
            tab: tab,
            isActive: isActive,
            onTap: () => onTabSelected(tab),
            onClose: () => onTabClosed(tab),
          );
        },
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final EditorTab tab;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onClose;

  const _TabChip({
    required this.tab,
    required this.isActive,
    required this.onTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1E1E1E) : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.lightBlueAccent : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FileIcons.iconFor(tab.file), size: 14, color: FileIcons.colorFor(tab.file)),
            const SizedBox(width: 6),
            Text(
              tab.file.name,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.white : Colors.white60,
              ),
            ),
            const SizedBox(width: 6),
            if (tab.isDirty)
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: CircleAvatar(radius: 3, backgroundColor: Colors.white70),
              ),
            InkWell(
              onTap: onClose,
              child: const Icon(Icons.close, size: 14, color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
