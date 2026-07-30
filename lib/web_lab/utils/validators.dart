/// Small, dependency-free validation helpers shared across the Web Lab
/// module — naming rules for files/folders/projects, kept in one place
/// so the same rules apply everywhere they're entered (dialogs, rename
/// flows, project creation).
class Validators {
  Validators._();

  /// Characters that are unsafe across common filesystems and ZIP export.
  static final RegExp _unsafeFileNameChars = RegExp(r'[\\/:*?"<>|]');

  /// Validates a proposed file or folder name. Returns an error message
  /// if invalid, or null if the name is acceptable.
  static String? validateFileName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'Name cannot be empty.';
    if (trimmed == '.' || trimmed == '..') return 'That name is reserved.';
    if (_unsafeFileNameChars.hasMatch(trimmed)) {
      return 'Name cannot contain \\ / : * ? " < > |';
    }
    if (trimmed.length > 128) return 'Name is too long.';
    return null;
  }

  /// Validates a proposed project name — slightly more permissive than
  /// file names since it never touches the filesystem directly, but
  /// still guards against empty or excessively long input.
  static String? validateProjectName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'Project name cannot be empty.';
    if (trimmed.length > 80) return 'Project name is too long.';
    return null;
  }

  /// True if [name] looks like an HTML file, used by services that need
  /// to special-case the entry-point file.
  static bool isHtmlFile(String name) =>
      name.toLowerCase().endsWith('.html') || name.toLowerCase().endsWith('.htm');

  /// True if [name] looks like a CSS file.
  static bool isCssFile(String name) => name.toLowerCase().endsWith('.css');

  /// True if [name] looks like a JavaScript file.
  static bool isJsFile(String name) => name.toLowerCase().endsWith('.js');
}
