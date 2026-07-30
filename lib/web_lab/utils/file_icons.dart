import 'package:flutter/material.dart';
import '../models/file_node_model.dart';

/// Maps a [FileNode] to the icon and color shown for it in the Project
/// Explorer and editor tabs, based on file extension or folder state.
///
/// Centralized here so every widget that renders a file/folder icon
/// (file tree, tab bar, breadcrumbs) stays visually consistent.
class FileIcons {
  FileIcons._();

  static IconData iconFor(FileNode node) {
    if (node.isFolder) {
      return node.isExpanded ? Icons.folder_open : Icons.folder;
    }

    switch (node.extension) {
      case 'html':
      case 'htm':
        return Icons.html_outlined;
      case 'css':
        return Icons.css_outlined;
      case 'js':
        return Icons.javascript_outlined;
      case 'json':
        return Icons.data_object;
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'gif':
      case 'svg':
      case 'webp':
        return Icons.image_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  static Color colorFor(FileNode node) {
    if (node.isFolder) return const Color(0xFFDCB67A);

    switch (node.extension) {
      case 'html':
      case 'htm':
        return const Color(0xFFE44D26);
      case 'css':
        return const Color(0xFF264DE4);
      case 'js':
        return const Color(0xFFF0DB4F);
      case 'json':
        return const Color(0xFF8BC34A);
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'gif':
      case 'svg':
      case 'webp':
        return const Color(0xFF9C27B0);
      default:
        return const Color(0xFFB0B0B0);
    }
  }
}
