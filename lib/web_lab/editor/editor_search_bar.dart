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
/// Presents match count and next/previous navigation, matching the
/// "search / replace" requirement without needing any external package.
class EditorSearchBar extends StatefulWidget {
  final String content;
  final ValueChanged<int> onMatchIndexChanged;
  final ValueChanged<String> onReplaceOne;
  final ValueChanged<String> onReplaceAll;
  final VoidCallback onClose;

  const EditorSearchBar({
    super.key,
    required this.content,
    required this.onMatchIndexChanged,
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
  List<SearchMatch> _matches = [];
  int _currentIndex = 0;
  bool _showReplace = false;

  @override
  void dispose() {
    _searchController.dispose();
    _replaceController.dispose();
    super.dispose();
  }

  void _runSearch(String query) {
    setState(() {
      _matches = EditorSearchEngine.findAll(widget.content, query);
      _currentIndex = _matches.isEmpty ? 0 : _currentIndex % _matches.length;
    });
    if (_matches.isNotEmpty) {
      widget.onMatchIndexChanged(_currentIndex);
    }
  }

  void _next() {
    if (_matches.isEmpty) return;
    setState(() => _currentIndex = (_currentIndex + 1) % _matches.length);
    widget.onMatchIndexChanged(_currentIndex);
  }

  void _previous() {
    if (_matches.isEmpty) return;
    setState(() => _currentIndex = (_currentIndex - 1 + _matches.length) % _matches.length);
    widget.onMatchIndexChanged(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    onChanged: _runSearch,
                  ),
                ),
                const SizedBox(width: 8),
                Text('${_matches.isEmpty ? 0 : _currentIndex + 1}/${_matches.length}'),
                IconButton(icon: const Icon(Icons.keyboard_arrow_up), onPressed: _previous),
                IconButton(icon: const Icon(Icons.keyboard_arrow_down), onPressed: _next),
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
                    onPressed: _matches.isEmpty
                        ? null
                        : () => widget.onReplaceOne(_replaceController.text),
                    child: const Text('Replace'),
                  ),
                  TextButton(
                    onPressed: _matches.isEmpty
                        ? null
                        : () => widget.onReplaceAll(_replaceController.text),
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
