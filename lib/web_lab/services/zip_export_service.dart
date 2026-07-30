import 'dart:typed_data';
import 'package:archive/archive.dart';
import '../models/file_node_model.dart';
import '../models/project_model.dart';

/// Exports a [ProjectModel]'s file tree as a downloadable ZIP archive, so
/// students can take their work outside the app (e.g. to host it, or
/// submit it elsewhere).
///
/// Depends on the `archive` package (v4.x) for ZIP encoding. Uses
/// `ArchiveFile.typedData`, the current constructor for storing raw
/// bytes in an archive entry — the older positional `ArchiveFile(name,
/// size, data)` constructor from archive 3.x is legacy in 4.x and best
/// avoided.
class ZipExportService {
  /// Builds a ZIP archive of [project]'s entire file tree and returns the
  /// raw bytes, ready to be written to disk or shared via a file picker.
  Uint8List exportProject(ProjectModel project) {
    final archive = Archive();
    _addNodeToArchive(archive, project.root, '');
    final bytes = ZipEncoder().encode(archive);
    return Uint8List.fromList(bytes);
  }

  /// Recursively walks [node], adding every file to [archive] with a path
  /// relative to the project root. Folders are not added as explicit
  /// entries — ZIP infers folder structure from file paths.
  void _addNodeToArchive(Archive archive, FileNode node, String currentPath) {
    if (node.isFile) {
      final data = Uint8List.fromList(node.content.codeUnits);
      archive.addFile(ArchiveFile.typedData(currentPath, data));
      return;
    }
    for (final child in node.children) {
      final childPath = currentPath.isEmpty
          ? child.name
          : '$currentPath/${child.name}';
      _addNodeToArchive(archive, child, childPath);
    }
  }

  /// Suggests a filesystem-safe filename for the exported ZIP, based on
  /// the project's name.
  String suggestedFileName(ProjectModel project) {
    final safe = project.name
        .trim()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '_');
    return '${safe.isEmpty ? 'web_lab_project' : safe}.zip';
  }
}
