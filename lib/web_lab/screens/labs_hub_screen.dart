import 'package:flutter/material.dart';
import '../controllers/project_controller.dart';
import 'animation_lab_screen.dart';
import 'svg_studio_screen.dart';

/// Central directory of every standalone lab tool in Web Lab — the
/// entry point this list is designed to keep growing from (Design Lab,
/// JS Playground, Testing Lab, and more land here as they're built).
class LabsHubScreen extends StatelessWidget {
  final ProjectController projectController;

  const LabsHubScreen({super.key, required this.projectController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Labs')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _LabTile(
            icon: Icons.gesture,
            color: Colors.deepPurple,
            title: 'SVG Studio',
            subtitle: 'Build icons, logos, and illustrations with real SVG shapes.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SvgStudioScreen(projectController: projectController)),
            ),
          ),
          const SizedBox(height: 12),
          _LabTile(
            icon: Icons.animation,
            color: Colors.pink,
            title: 'Animation Lab',
            subtitle: 'Design CSS keyframe animations with a live, accurate preview.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AnimationLabScreen(projectController: projectController)),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LabTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
