import 'package:flutter/material.dart';
import '../controllers/preview_controller.dart';
import '../models/project_model.dart';

/// Toolbar shown above the live preview, exposing Refresh, Reload, and
/// portrait/landscape orientation toggles. Contains no rendering logic
/// itself — it only reads/mutates [PreviewController] state.
class PreviewToolbar extends StatelessWidget implements PreferredSizeWidget {
  final PreviewController previewController;

  const PreviewToolbar({super.key, required this.previewController});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: previewController,
      builder: (context, _) {
        final isPortrait =
            previewController.orientation == PreviewOrientation.portrait;

        return Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            children: [
              IconButton(
                tooltip: 'Refresh preview',
                icon: const Icon(Icons.refresh),
                onPressed: previewController.refresh,
              ),
              const Spacer(),
              _OrientationToggleButton(
                icon: Icons.stay_current_portrait,
                label: 'Portrait',
                selected: isPortrait,
                onTap: () => previewController.setOrientation(PreviewOrientation.portrait),
              ),
              const SizedBox(width: 4),
              _OrientationToggleButton(
                icon: Icons.stay_current_landscape,
                label: 'Landscape',
                selected: !isPortrait,
                onTap: () => previewController.setOrientation(PreviewOrientation.landscape),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Compact segmented-style toggle button used for the two orientation
/// options. Kept private to this file since it has no reuse outside the
/// Preview toolbar.
class _OrientationToggleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OrientationToggleButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? scheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
