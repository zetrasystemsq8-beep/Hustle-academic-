import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/file_node_model.dart';
import 'syntax_highlighter.dart';
import 'editor_search_bar.dart';

/// A professional multi-line code editor for a single file: syntax
/// highlighting, line numbers, auto-indentation, bracket matching, and
/// an overlaid find/replace bar. Undo/redo are driven externally by
/// [EditorController] and exposed here via [onUndo]/[onRedo] callbacks
/// so history stays in one place (business logic, not the widget tree).
class CodeEditorWidget extends StatefulWidget {
  final FileNode file;
  final ValueChanged<String> onChanged;
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final bool canUndo;
  final bool canRedo;

  const CodeEditorWidget({
    super.key,
    required this.file,
    required this.onChanged,
    this.onUndo,
    this.onRedo,
    this.canUndo = false,
    this.canRedo = false,
  });

  @override
  State<CodeEditorWidget> createState() => _CodeEditorWidgetState();
}

class _CodeEditorWidgetState extends State<CodeEditorWidget> {
  late TextEditingController _controller;
  final ScrollController _codeScrollController = ScrollController();
  final ScrollController _lineNumberScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  bool _showSearch = false;
  String _searchQuery = '';
  List<SearchMatch> _matches = [];
  int _currentMatchIndex = 0;

  static const Map<String, String> _bracketPairs = {
    '(': ')',
    '[': ']',
    '{': '}',
  };

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.file.content);
    _codeScrollController.addListener(_syncLineNumberScroll);
  }

  @override
  void didUpdateWidget(covariant CodeEditorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file.id != widget.file.id ||
        _controller.text != widget.file.content) {
      final selection = _controller.selection;
      _controller.text = widget.file.content;
      if (selection.start <= widget.file.content.length) {
        _controller.selection = selection;
      }
      if (oldWidget.file.id != widget.file.id) {
        // Switching files clears any in-progress search state.
        _showSearch = false;
        _searchQuery = '';
        _matches = [];
        _currentMatchIndex = 0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _codeScrollController.dispose();
    _lineNumberScrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _syncLineNumberScroll() {
    if (_lineNumberScrollController.hasClients) {
      _lineNumberScrollController.jumpTo(_codeScrollController.offset);
    }
  }

  int get _lineCount => '\n'.allMatches(_controller.text).length + 1;

  void _handleChanged(String newText) {
    widget.onChanged(newText);
    if (_searchQuery.isNotEmpty) {
      _recomputeMatches();
    }
  }

  void _handleBracketAutoClose(String typed) {
    if (!_bracketPairs.containsKey(typed)) return;
    final closing = _bracketPairs[typed]!;
    final selection = _controller.selection;
    final text = _controller.text;
    final newText = text.replaceRange(selection.start, selection.start, closing);
    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.start),
    );
  }

  void _handleNewLine() {
    final selection = _controller.selection;
    final text = _controller.text;
    final beforeCursor = text.substring(0, selection.start);
    final lastNewline = beforeCursor.lastIndexOf('\n');
    final currentLine = beforeCursor.substring(lastNewline + 1);
    final leadingWhitespace = RegExp(r'^[ \t]*').stringMatch(currentLine) ?? '';

    final extraIndent = currentLine.trimRight().endsWith('{') ||
            currentLine.trimRight().endsWith('(') ||
            currentLine.trimRight().endsWith('[')
        ? '  '
        : '';

    final insertion = '\n$leadingWhitespace$extraIndent';
    final newText = text.replaceRange(selection.start, selection.start, insertion);
    final newOffset = selection.start + insertion.length;

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
    widget.onChanged(newText);
  }

  // ---------------------------------------------------------------
  // Search / Replace
  // ---------------------------------------------------------------

  void _recomputeMatches() {
    setState(() {
      _matches = EditorSearchEngine.findAll(_controller.text, _searchQuery);
      if (_matches.isEmpty) {
        _currentMatchIndex = 0;
      } else if (_currentMatchIndex >= _matches.length) {
        _currentMatchIndex = 0;
      }
    });
    if (_matches.isNotEmpty) {
      _selectMatch(_matches[_currentMatchIndex]);
    }
  }

  void _selectMatch(SearchMatch match) {
    _controller.selection = TextSelection(baseOffset: match.start, extentOffset: match.end);
  }

  void _onSearchQueryChanged(String query) {
    _searchQuery = query;
    _recomputeMatches();
  }

  void _goToNextMatch() {
    if (_matches.isEmpty) return;
    setState(() => _currentMatchIndex = (_currentMatchIndex + 1) % _matches.length);
    _selectMatch(_matches[_currentMatchIndex]);
  }

  void _goToPreviousMatch() {
    if (_matches.isEmpty) return;
    setState(() => _currentMatchIndex = (_currentMatchIndex - 1 + _matches.length) % _matches.length);
    _selectMatch(_matches[_currentMatchIndex]);
  }

  void _replaceCurrentMatch(String replacement) {
    if (_matches.isEmpty) return;
    final match = _matches[_currentMatchIndex];
    final newText = EditorSearchEngine.replaceOne(_controller.text, match, replacement);
    final newOffset = match.start + replacement.length;

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
    widget.onChanged(newText);
    _recomputeMatches();
  }

  void _replaceAllMatches(String replacement) {
    if (_searchQuery.isEmpty) return;
    final newText = EditorSearchEngine.replaceAll(_controller.text, _searchQuery, replacement);
    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
    widget.onChanged(newText);
    _recomputeMatches();
  }

  @override
  Widget build(BuildContext context) {
    final colors = EditorColorScheme.dark();
    final language = SyntaxHighlighter.languageForExtension(widget.file.extension);

    return Container(
      color: const Color(0xFF1E1E1E),
      child: Stack(
        children: [
          Column(
            children: [
              _buildToolbar(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLineNumbers(colors),
                    Expanded(child: _buildCodeField(colors, language)),
                  ],
                ),
              ),
            ],
          ),
          if (_showSearch)
            Positioned(
              top: 48,
              left: 8,
              right: 8,
              child: EditorSearchBar(
                matchCount: _matches.length,
                currentIndex: _currentMatchIndex,
                onQueryChanged: _onSearchQueryChanged,
                onNext: _goToNextMatch,
                onPrevious: _goToPreviousMatch,
                onReplaceOne: _replaceCurrentMatch,
                onReplaceAll: _replaceAllMatches,
                onClose: () => setState(() {
                  _showSearch = false;
                  _searchQuery = '';
                  _matches = [];
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      height: 40,
      color: const Color(0xFF252526),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(
            widget.file.name,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Undo',
            icon: const Icon(Icons.undo, size: 18, color: Colors.white70),
            onPressed: widget.canUndo ? widget.onUndo : null,
          ),
          IconButton(
            tooltip: 'Redo',
            icon: const Icon(Icons.redo, size: 18, color: Colors.white70),
            onPressed: widget.canRedo ? widget.onRedo : null,
          ),
          IconButton(
            tooltip: 'Find & Replace',
            icon: const Icon(Icons.search, size: 18, color: Colors.white70),
            onPressed: () => setState(() => _showSearch = !_showSearch),
          ),
        ],
      ),
    );
  }

  Widget _buildLineNumbers(EditorColorScheme colors) {
    return Container(
      width: 44,
      color: const Color(0xFF1E1E1E),
      child: SingleChildScrollView(
        controller: _lineNumberScrollController,
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(_lineCount, (i) {
              return Text(
                '${i + 1}',
                style: colors.baseStyle.copyWith(
                  color: Colors.white24,
                  fontSize: 13,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeField(EditorColorScheme colors, EditorLanguage language) {
    return SingleChildScrollView(
      controller: _codeScrollController,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          maxLines: null,
          minLines: 20,
          cursorColor: Colors.white,
          style: colors.baseStyle,
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
          ),
          onChanged: (text) {
            final selectionOffset = _controller.selection.baseOffset;
            _handleChanged(text);
            if (text.length > widget.file.content.length && selectionOffset > 0) {
              final added = text[selectionOffset - 1];
              if (added == '\n') {
                _handleNewLine();
              } else if (_bracketPairs.containsKey(added)) {
                _handleBracketAutoClose(added);
              }
            }
          },
          buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
        ),
      ),
    );
  }
}
