/// A single node in a serialized snapshot of the live preview's DOM tree,
/// as reported by the DevTools instrumentation script running inside the
/// WebView. This mirrors the real, currently-rendered DOM — including
/// any elements created or changed at runtime by the student's own
/// JavaScript — not just the static index.html source.
class DomNode {
  /// Internal id assigned by the instrumentation script (via a
  /// data-weblab-id attribute), used to re-query this exact element for
  /// computed styles later. Not present in the student's original HTML.
  final String weblabId;

  final String tag;
  final Map<String, String> attributes;

  /// A short text preview of this node's direct text content, empty for
  /// elements that only contain other elements.
  final String textPreview;

  final List<DomNode> children;

  const DomNode({
    required this.weblabId,
    required this.tag,
    required this.attributes,
    required this.textPreview,
    required this.children,
  });

  String get id => attributes['id'] ?? '';
  String get className => attributes['class'] ?? '';

  factory DomNode.fromJson(Map<String, dynamic> json) {
    return DomNode(
      weblabId: json['weblabId'] as String? ?? '',
      tag: json['tag'] as String? ?? 'unknown',
      attributes: (json['attrs'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, value.toString())),
      textPreview: json['text'] as String? ?? '',
      children: (json['children'] as List<dynamic>? ?? [])
          .map((c) => DomNode.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }
}
