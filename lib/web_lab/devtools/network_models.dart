/// A single network call (fetch or XMLHttpRequest) made by the student's
/// JavaScript while the preview runs, captured by the DevTools
/// instrumentation script so it can be inspected like a browser's
/// Network tab.
class NetworkRequestEntry {
  final String method;
  final String url;
  final int? statusCode;
  final int durationMs;
  final String requestType;
  final bool failed;
  final DateTime timestamp;

  const NetworkRequestEntry({
    required this.method,
    required this.url,
    required this.statusCode,
    required this.durationMs,
    required this.requestType,
    required this.failed,
    required this.timestamp,
  });

  factory NetworkRequestEntry.fromJson(Map<String, dynamic> json) {
    return NetworkRequestEntry(
      method: json['method'] as String? ?? 'GET',
      url: json['url'] as String? ?? '',
      statusCode: json['status'] as int?,
      durationMs: (json['durationMs'] as num?)?.toInt() ?? 0,
      requestType: json['requestType'] as String? ?? 'fetch',
      failed: json['failed'] as bool? ?? false,
      timestamp: DateTime.now(),
    );
  }
}
