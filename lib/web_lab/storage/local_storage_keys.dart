/// Centralized registry of all keys used when persisting Web Lab data to
/// local storage (SharedPreferences / Hive / file-based, depending on the
/// concrete StorageService implementation).
///
/// Keeping every key in one place avoids typo bugs like saving under
/// "project_list" in one place and reading "projectList" in another.
class LocalStorageKeys {
  LocalStorageKeys._();

  /// Stores the JSON-encoded list of all project summaries (id, name,
  /// lastOpenedAt) used to render the Home dashboard quickly without
  /// loading every project's full file tree.
  static const String projectIndex = 'web_lab.project_index';

  /// Prefix for a single project's full serialized JSON. The complete key
  /// is `web_lab.project.<projectId>`.
  static const String projectPrefix = 'web_lab.project.';

  /// Stores the JSON-encoded list of recently opened project IDs, most
  /// recent first, capped to a fixed length by the repository.
  static const String recentProjects = 'web_lab.recent_projects';

  /// Stores the JSON-encoded list of completed challenge IDs across all
  /// projects, used to render progress on the Challenges screen.
  static const String completedChallenges = 'web_lab.completed_challenges';

  /// Stores user preference for which templates have been unlocked.
  static const String unlockedTemplates = 'web_lab.unlocked_templates';

  /// Builds the full storage key for a specific project's JSON blob.
  static String projectKey(String projectId) => '$projectPrefix$projectId';
}
