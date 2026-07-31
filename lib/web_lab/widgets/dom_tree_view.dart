import 'package:flutter/material.dart';
import '../devtools/dom_models.dart';

/// Renders a live DOM snapshot as an indented, expandable tree — the
/// DevTools Suite's equivalent of a browser's Elements panel. Tapping a
/// node selects it (surfacing its computed styles in a sibling panel).
class DomTreeView extends StatefulWidget {
  final DomNode? root;
  final String? selectedNodeId;
  final ValueChanged<DomNode> onNodeSelected;

  const DomTreeView({
    super.key,
    required this.root,
    required this.selectedNodeId,
    required this.onNodeSelected,
  });

  @override
  State<DomTreeView> createState() => _DomTreeViewState();
}

class _DomTreeViewState extends State<DomTreeView> {
  final Set<String> _collapsed = {};

  @override
  Widget build(BuildContext context) {
    final root = widget.root;
    if (root == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Waiting for the preview to load...', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: _buildRows(root, depth: 0),
    );
  }

  List<Widget> _buildRows(DomNode node, {required int depth}) {
    final widgets = <Widget>[
      _DomNodeRow(
        node: node,
        depth: depth,
        isSelected: node.weblabId == widget.selectedNodeId,
        isCollapsed: _collapsed.contains(node.weblabId),
        hasChildren: node.children.isNotEmpty,
        onTap: () => widget.onNodeSelected(node),
        onToggleCollapse: () => setState(() {
          if (_collapsed.contains(node.weblabId)) {
            _collapsed.remove(node.weblabId);
          } else {
            _collapsed.add(node.weblabId);
          }
        }),
      ),
    ];

    if (!_collapsed.contains(node.weblabId)) {
      for (final child in node.children) {
        widgets.addAll(_buildRows(child, depth: depth + 1));
      }
    }

    return widgets;
  }
}

class _DomNodeRow extends StatelessWidget {
  final DomNode node;
  final int depth;
  final bool isSelected;
  final bool isCollapsed;
  final bool hasChildren;
  final VoidCallback onTap;
  final VoidCallback onToggleCollapse;

  const _DomNodeRow({
    required this.node,
    required this.depth,
    required this.isSelected,
    required this.isCollapsed,
    required this.hasChildren,
    required this.onTap,
    required this.onToggleCollapse,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.blue.withOpacity(0.15) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(left: 8.0 + depth * 16, right: 8, top: 6, bottom: 6),
          child: Row(
            children: [
              if (hasChildren)
                GestureDetector(
                  onTap: onToggleCollapse,
                  child: Icon(
                    isCollapsed ? Icons.chevron_right : Icons.expand_more,
                    size: 16,
                    color: Colors.grey,
                  ),
                )
              else
                const SizedBox(width: 16),
              const SizedBox(width: 4),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                    children: [
                      TextSpan(text: '<${node.tag}', style: const TextStyle(color: Color(0xFF4EC9B0))),
                      if (node.id.isNotEmpty)
                        TextSpan(text: ' id="${node.id}"', style: const TextStyle(color: Color(0xFF9CDCFE))),
                      if (node.className.isNotEmpty)
                        TextSpan(text: ' class="${node.className}"', style: const TextStyle(color: Color(0xFFCE9178))),
                      const TextSpan(text: '>', style: TextStyle(color: Color(0xFF4EC9B0))),
                      if (node.textPreview.isNotEmpty)
                        TextSpan(text: ' ${node.textPreview}', style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
