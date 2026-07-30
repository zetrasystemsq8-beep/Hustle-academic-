import 'package:flutter/material.dart';

/// Which language grammar to apply when tokenizing a file's content.
enum EditorLanguage { html, css, javascript, plain }

/// A single classified token produced by tokenizing source code, used to
/// build a styled [TextSpan] for the Code Editor.
class SyntaxToken {
  final String text;
  final SyntaxTokenType type;

  const SyntaxToken(this.text, this.type);
}

/// Semantic category of a token, mapped to a color by [SyntaxHighlighter].
enum SyntaxTokenType {
  plain,
  keyword,
  tag,
  attribute,
  string,
  number,
  comment,
  selector,
  property,
  punctuation,
  function,
}

/// Lightweight regex-based tokenizer and highlighter for HTML, CSS, and
/// JavaScript. Deliberately hand-rolled (no external highlighting
/// package) so it stays dependency-free and fast enough to run on every
/// keystroke for reasonably sized student files.
class SyntaxHighlighter {
  /// Infers which language to highlight based on a file's extension.
  static EditorLanguage languageForExtension(String extension) {
    switch (extension.toLowerCase()) {
      case 'html':
      case 'htm':
        return EditorLanguage.html;
      case 'css':
        return EditorLanguage.css;
      case 'js':
        return EditorLanguage.javascript;
      default:
        return EditorLanguage.plain;
    }
  }

  /// Builds a styled [TextSpan] tree for [source] according to
  /// [language], using [colors] for each token category.
  static TextSpan highlight(
    String source,
    EditorLanguage language,
    EditorColorScheme colors,
  ) {
    final tokens = _tokenize(source, language);
    return TextSpan(
      style: colors.baseStyle,
      children: tokens
          .map((t) => TextSpan(text: t.text, style: colors.styleFor(t.type)))
          .toList(),
    );
  }

  static List<SyntaxToken> _tokenize(String source, EditorLanguage language) {
    switch (language) {
      case EditorLanguage.html:
        return _tokenizeHtml(source);
      case EditorLanguage.css:
        return _tokenizeCss(source);
      case EditorLanguage.javascript:
        return _tokenizeJs(source);
      case EditorLanguage.plain:
        return [SyntaxToken(source, SyntaxTokenType.plain)];
    }
  }

  static final RegExp _htmlPattern = RegExp(
    r'(<!--[\s\S]*?-->)'
    r'|(</?[a-zA-Z][a-zA-Z0-9-]*)'
    r'|([a-zA-Z-]+(?=\s*=))'
    r'|("[^"]*"|' r"'[^']*')"
    r'|(/?>)',
  );

  static List<SyntaxToken> _tokenizeHtml(String source) {
    return _tokenizeWithMatcher(source, _htmlPattern, (match) {
      if (match.group(1) != null) return SyntaxTokenType.comment;
      if (match.group(2) != null) return SyntaxTokenType.tag;
      if (match.group(3) != null) return SyntaxTokenType.attribute;
      if (match.group(4) != null) return SyntaxTokenType.string;
      if (match.group(5) != null) return SyntaxTokenType.tag;
      return SyntaxTokenType.plain;
    });
  }

  static final RegExp _cssPattern = RegExp(
    r'(/\*[\s\S]*?\*/)'
    r'|([.#]?[a-zA-Z-][a-zA-Z0-9_-]*(?=\s*\{))'
    r'|([a-zA-Z-]+(?=\s*:))'
    r'|("[^"]*"|' r"'[^']*')"
    r'|(-?\d+\.?\d*(px|em|rem|%|vh|vw)?)'
    r'|([{}:;])',
  );

  static List<SyntaxToken> _tokenizeCss(String source) {
    return _tokenizeWithMatcher(source, _cssPattern, (match) {
      if (match.group(1) != null) return SyntaxTokenType.comment;
      if (match.group(2) != null) return SyntaxTokenType.selector;
      if (match.group(3) != null) return SyntaxTokenType.property;
      if (match.group(4) != null) return SyntaxTokenType.string;
      if (match.group(5) != null) return SyntaxTokenType.number;
      if (match.group(7) != null) return SyntaxTokenType.punctuation;
      return SyntaxTokenType.plain;
    });
  }

  static const Set<String> _jsKeywords = {
    'var', 'let', 'const', 'function', 'return', 'if', 'else', 'for',
    'while', 'do', 'break', 'continue', 'switch', 'case', 'default',
    'true', 'false', 'null', 'undefined', 'new', 'this', 'class',
    'extends', 'try', 'catch', 'finally', 'throw', 'typeof', 'instanceof',
    'in', 'of', 'async', 'await', 'import', 'export', 'from',
  };

  static final RegExp _jsPattern = RegExp(
    r'(//.*$)'
    r'|(/\*[\s\S]*?\*/)'
    r'|("[^"]*"|' r"'[^']*'" r'|`[^`]*`)'
    r'|(\b\d+\.?\d*\b)'
    r'|(\b[a-zA-Z_$][a-zA-Z0-9_$]*\b(?=\s*\())'
    r'|(\b[a-zA-Z_$][a-zA-Z0-9_$]*\b)',
    multiLine: true,
  );

  static List<SyntaxToken> _tokenizeJs(String source) {
    return _tokenizeWithMatcher(source, _jsPattern, (match) {
      if (match.group(1) != null || match.group(2) != null) {
        return SyntaxTokenType.comment;
      }
      if (match.group(3) != null) return SyntaxTokenType.string;
      if (match.group(4) != null) return SyntaxTokenType.number;
      if (match.group(5) != null) return SyntaxTokenType.function;
      if (match.group(6) != null) {
        final word = match.group(6)!;
        return _jsKeywords.contains(word)
            ? SyntaxTokenType.keyword
            : SyntaxTokenType.plain;
      }
      return SyntaxTokenType.plain;
    });
  }

  /// Shared driver that walks all regex matches in [source], emitting a
  /// plain-text token for any gap between matches and a classified token
  /// for each match (via [classify]).
  static List<SyntaxToken> _tokenizeWithMatcher(
    String source,
    RegExp pattern,
    SyntaxTokenType Function(RegExpMatch match) classify,
  ) {
    final tokens = <SyntaxToken>[];
    int lastEnd = 0;

    for (final match in pattern.allMatches(source)) {
      if (match.start > lastEnd) {
        tokens.add(SyntaxToken(source.substring(lastEnd, match.start), SyntaxTokenType.plain));
      }
      tokens.add(SyntaxToken(match.group(0)!, classify(match)));
      lastEnd = match.end;
    }

    if (lastEnd < source.length) {
      tokens.add(SyntaxToken(source.substring(lastEnd), SyntaxTokenType.plain));
    }

    return tokens;
  }
}

/// Color palette applied to each [SyntaxTokenType], resolved once per
/// theme so the highlighter doesn't hardcode colors.
class EditorColorScheme {
  final TextStyle baseStyle;
  final Color keyword;
  final Color tag;
  final Color attribute;
  final Color string;
  final Color number;
  final Color comment;
  final Color selector;
  final Color property;
  final Color punctuation;
  final Color function;

  const EditorColorScheme({
    required this.baseStyle,
    required this.keyword,
    required this.tag,
    required this.attribute,
    required this.string,
    required this.number,
    required this.comment,
    required this.selector,
    required this.property,
    required this.punctuation,
    required this.function,
  });

  /// A dark "developer tool" palette resembling popular editor themes,
  /// tuned for readability on mobile screens.
  factory EditorColorScheme.dark() {
    return const EditorColorScheme(
      baseStyle: TextStyle(
        color: Color(0xFFD4D4D4),
        fontFamily: 'monospace',
        fontSize: 14,
        height: 1.5,
      ),
      keyword: Color(0xFF569CD6),
      tag: Color(0xFF4EC9B0),
      attribute: Color(0xFF9CDCFE),
      string: Color(0xFFCE9178),
      number: Color(0xFFB5CEA8),
      comment: Color(0xFF6A9955),
      selector: Color(0xFFD7BA7D),
      property: Color(0xFF9CDCFE),
      punctuation: Color(0xFFD4D4D4),
      function: Color(0xFFDCDCAA),
    );
  }

  TextStyle styleFor(SyntaxTokenType type) {
    final color = switch (type) {
      SyntaxTokenType.plain => baseStyle.color,
      SyntaxTokenType.keyword => keyword,
      SyntaxTokenType.tag => tag,
      SyntaxTokenType.attribute => attribute,
      SyntaxTokenType.string => string,
      SyntaxTokenType.number => number,
      SyntaxTokenType.comment => comment,
      SyntaxTokenType.selector => selector,
      SyntaxTokenType.property => property,
      SyntaxTokenType.punctuation => punctuation,
      SyntaxTokenType.function => function,
    };
    final fontStyle = type == SyntaxTokenType.comment ? FontStyle.italic : FontStyle.normal;
    return baseStyle.copyWith(color: color, fontStyle: fontStyle);
  }
}
