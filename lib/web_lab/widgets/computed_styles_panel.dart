import 'package:flutter/material.dart';
import '../devtools/dom_models.dart';

/// Displays the computed CSS values for a selected DOM node — the
/// DevTools Suite's equivalent of a browser's Styles pane. Read-only:
/// this reflects what's actually applied after cascade and inheritance,
/// which is exactly the value of a real computed-styles panel — seeing
/// what won, not just what was written.
class ComputedStylesPanel extends StatelessWidget {
  final DomNode? selectedNode;
  final Map<String, String> computedStyles;

  const ComputedStylesPanel({
    super.key,
    required this.selectedNode,
    required this.computedStyles,
  });

  @override
  Widget build(BuildContext context) {
    final node = selectedNode;
    if (node == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Select an element to inspect its styles.', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: Colors.grey.shade100,
          child: Text(
            '<${node.tag}${node.id.isNotEmpty ? ' id="${node.id}"' : ''}${node.className.isNotEmpty ? ' class="${node.className}"' : ''}>',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: computedStyles.isEmpty
              ? const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('Loading styles...')))
              : ListView(
                  children: computedStyles.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 130,
                            child: Text(
                              entry.key,
                              style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFF9CDCFE)),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry.value.isEmpty ? '(none)' : entry.value,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: entry.value.isEmpty ? Colors.grey : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}
