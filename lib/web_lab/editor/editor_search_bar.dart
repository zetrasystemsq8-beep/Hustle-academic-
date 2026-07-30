import 'package:flutter/material.dart';

/// Result of a find/replace query against editor content: the byte
/// offsets of every match, used both for highlighting and for
/// navigating "next/previous" results.
class SearchMatch {
  final int start;
  final int end;

  const SearchMatch(this.start, this.end);
}

/// Pure search/replace logic used by the Code Editor, kept separate from
/// the search bar's UI so it can be tested independently.
class EditorSearchEngine {
  /// Finds all occurrences of [query] in [source]. Case-insensitive.
  /// Returns an empty list if [query] is empty.
  static List<SearchMatch> findAll(String source, String query) {
    if (query.isEmpty) return [];
    final matches = <SearchMatch>[];
    final lowerSource = source.toLowerCase();
    final lowerQuery = query.toLowerCase();

    int start = 0;
    while (true) {
      final index = lowerSource.indexOf(lowerQuery, start);
      if (index == -1) break;
      matches.add(SearchMatch(index, index + query.length));
      start = index + query.length;
    }
    return matches;
  }

  /// Replaces the single match at [match] with [replacement] and returns
  /// the updated string.
  static String replaceOne(String source, SearchMatch match, String replacement) {
    return source.replaceRange(match.start, match.end, replacement);
  }

  /// Replaces every occurrence of [query] in [source] with [replacement].
  static String replaceAll(String source, String query, String replacement) {
    if (query.isEmpty) return source;
    final pattern = RegExp(RegExp.escape(query), caseSensitive: false);
    return source.replaceAll(pattern, replacement);
  }
}

/// Floating find/replace bar overlaid on top of the [CodeEditorWidget].
///
/// This widget is fully controlled: it holds no search state of its own
/// (no match list, no current index) — that lives in the parent
/// [CodeEditorWidget], which is the only place with access to the actual
/// text controller a replace needs to mutate. This widget only renders
/// what it's told and reports user intent upward via callbacks.
class EditorSearchBar extends StatefulWidget {
  final int matchCount;
  final int currentIndex;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final ValueChanged<String> onReplaceOne;
  final ValueChanged<String> onReplaceAll;
  final VoidCallback onClose;

  const EditorSearchBar({
    super.key,
    required this.matchCount,
    required this.currentIndex,
    required this.onQueryChanged,
    required this.onNext,
    required this.onPrevious,
    required this.onReplaceOne,
    required this.onReplaceAll,
    required this.onClose,
  });

  @override
  State<EditorSearchBar> createState() => _EditorSearchBarState();
}

class _EditorSearchBarState extends State<EditorSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _replaceController = TextEditingController();
  bool _showReplace = false;

  @override
  void dispose() {
    _searchController.dispose();
    _replaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasMatches = widget.matchCount > 0;

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      color: theme.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Find',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: widget.onQueryChanged,
                  ),
                ),
                const SizedBox(width: 8),
                Text('${hasMatches ? widget.currentIndex + 1 : 0}/${widget.matchCount}'),
                IconButton(icon: const Icon(Icons.keyboard_arrow_up), onPressed: hasMatches ? widget.onPrevious : null),
                IconButton(icon: const Icon(Icons.keyboard_arrow_down), onPressed: hasMatches ? widget.onNext : null),
                IconButton(
                  icon: Icon(_showReplace ? Icons.expand_less : Icons.expand_more),
                  onPressed: () => setState(() => _showReplace = !_showReplace),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: widget.onClose),
              ],
            ),
            if (_showReplace) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _replaceController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Replace',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: hasMatches ? () => widget.onReplaceOne(_replaceController.text) : null,
                    child: const Text('Replace'),
                  ),
                  TextButton(
                    onPressed: hasMatches ? () => widget.onReplaceAll(_replaceController.text) : null,
                    child: const Text('All'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
