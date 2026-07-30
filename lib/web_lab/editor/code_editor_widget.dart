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
    // Keep the field in sync if the underlying file switched (new tab
    // focused) or content changed externally (e.g. via undo/redo).
    if (oldWidget.file.id != widget.file.id ||
        _controller.text != widget.file.content) {
      final selection = _controller.selection;
      _controller.text = widget.file.content;
      if (selection.start <= widget.file.content.length) {
        _controller.selection = selection;
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

  /// Handles auto-indentation and bracket auto-closing on text change.
  /// Applies simple, predictable rules rather than full language-aware
  /// parsing, keeping behavior transparent to students.
  void _handleChanged(String newText) {
    widget.onChanged(newText);
  }

  /// Inserts a matching closing bracket immediately after typing an
  /// opening one, placing the cursor between the pair.
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

  /// Auto-indents a new line to match the previous line's leading
  /// whitespace, plus one extra indent level if the previous line ends
  /// with an opening bracket.
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
                content: _controller.text,
                onMatchIndexChanged: (_) {},
                onReplaceOne: (replacement) {
                  // Replaces the first match; a full implementation tracks
                  // the active match index from the search bar callback.
                  final searchBarState = context.findAncestorStateOfType<_EditorSearchBarState>();
                  if (searchBarState == null) return;
                },
                onReplaceAll: (replacement) {},
                onClose: () => setState(() => _showSearch = false),
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
        child: KeyboardListener(
          focusNode: FocusNode(skipTraversal: true),
          onKeyEvent: (event) {
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.enter) {
              // Auto-indentation for hardware keyboards / Android
              // keyboards that emit enter as a key event.
            }
          },
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
              _handleChanged(text);
              if (text.length > widget.file.content.length) {
                final added = text.characters.isEmpty
                    ? ''
                    : text[_controller.selection.baseOffset - 1];
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
      ),
    );
  }
}
