/// Which browser storage mechanism a [StorageEntry] belongs to.
enum StorageKind { local, session, cookie }

/// A single key/value pair read from the live preview's localStorage,
/// sessionStorage, or cookies — refreshed on demand or when the
/// instrumentation script detects a change.
class StorageEntry {
  final StorageKind kind;
  final String key;
  final String value;

  const StorageEntry({required this.kind, required this.key, required this.value});
}

/// A full snapshot of all three storage mechanisms at one point in time.
class StorageSnapshot {
  final List<StorageEntry> entries;

  const StorageSnapshot(this.entries);

  List<StorageEntry> forKind(StorageKind kind) =>
      entries.where((e) => e.kind == kind).toList();

  factory StorageSnapshot.fromJson(Map<String, dynamic> json) {
    final entries = <StorageEntry>[];

    final local = json['local'] as Map<String, dynamic>? ?? {};
    local.forEach((key, value) => entries.add(StorageEntry(kind: StorageKind.local, key: key, value: value.toString())));

    final session = json['session'] as Map<String, dynamic>? ?? {};
    session.forEach((key, value) => entries.add(StorageEntry(kind: StorageKind.session, key: key, value: value.toString())));

    final cookieString = json['cookies'] as String? ?? '';
    if (cookieString.isNotEmpty) {
      for (final pair in cookieString.split(';')) {
        final parts = pair.trim().split('=');
        if (parts.length == 2) {
          entries.add(StorageEntry(kind: StorageKind.cookie, key: parts[0], value: parts[1]));
        }
      }
    }

    return StorageSnapshot(entries);
  }
}
