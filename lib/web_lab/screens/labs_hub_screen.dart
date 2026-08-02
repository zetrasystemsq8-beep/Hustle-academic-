import 'package:flutter/material.dart';
import '../controllers/project_controller.dart';
import 'animation_lab_screen.dart';
import 'automation_engine_screen.dart';
import 'community_templates_screen.dart';
import 'component_workshop_screen.dart';
import 'design_lab_screen.dart';
import 'frontier_labs_screen.dart';
import 'invention_timeline_screen.dart';
import 'js_playground_screen.dart';
import 'language_factory_screen.dart';
import 'legacy_screen.dart';
import 'package_manager_screen.dart';
import 'sandbox_screen.dart';
import 'svg_studio_screen.dart';
import 'testing_lab_screen.dart';
import 'web_universe_screen.dart';

/// Central directory of every standalone lab tool in Web Lab — the full
/// set, from the original build through every institute-style system
/// added since.
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
          _SectionHeader('Build & Design'),
          _LabTile(
            icon: Icons.palette_outlined,
            color: Colors.orange,
            title: 'Design Lab',
            subtitle: 'Color, gradients, shadows, radius, spacing, and typography tools.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DesignLabScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.widgets_outlined,
            color: Colors.teal,
            title: 'Component Workshop',
            subtitle: 'Build reusable buttons, cards, forms, and more — save your own library.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ComponentWorkshopScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.gesture,
            color: Colors.deepPurple,
            title: 'SVG Studio',
            subtitle: 'Build icons, logos, and illustrations with real SVG shapes.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SvgStudioScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.animation,
            color: Colors.pink,
            title: 'Animation Lab',
            subtitle: 'Design CSS keyframe animations with a live, accurate preview.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnimationLabScreen(projectController: projectController))),
          ),

          const SizedBox(height: 24),
          _SectionHeader('Code & Test'),
          _LabTile(
            icon: Icons.code,
            color: Colors.indigo,
            title: 'JS Playground',
            subtitle: 'Scratch space to test snippets, inspect variables, and benchmark code.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JsPlaygroundScreen())),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.inventory_2_outlined,
            color: Colors.brown,
            title: 'Package Manager',
            subtitle: 'Import Bootstrap, Tailwind, Alpine.js, Chart.js, Three.js, or GSAP via CDN.',
            onTap: projectController.currentProject == null
                ? () => _showOpenProjectFirst(context)
                : () => Navigator.push(context, MaterialPageRoute(builder: (_) => PackageManagerScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.fact_check_outlined,
            color: Colors.green,
            title: 'Testing Lab',
            subtitle: 'Check your HTML, CSS, JS, and accessibility for common mistakes.',
            onTap: projectController.currentProject == null
                ? () => _showOpenProjectFirst(context)
                : () => Navigator.push(context, MaterialPageRoute(builder: (_) => TestingLabScreen(project: projectController.currentProject!))),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.science_outlined,
            color: Colors.cyan,
            title: 'Sandbox',
            subtitle: 'No project needed — instant HTML/CSS/JS scratch space.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SandboxScreen(projectController: projectController))),
          ),

          const SizedBox(height: 24),
          _SectionHeader('Invent'),
          _LabTile(
            icon: Icons.translate,
            color: Colors.blueGrey,
            title: 'Language Factory',
            subtitle: 'Invent your own mini programming language and compile it to real JavaScript.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageFactoryListScreen())),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.public,
            color: Colors.blue,
            title: 'Web Universe',
            subtitle: 'Link your projects and mock APIs into a simulated internet — with real fetch() calls.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WebUniverseListScreen())),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.bolt_outlined,
            color: Colors.amber,
            title: 'Automation Engine',
            subtitle: 'Chain triggers, conditions, and actions — no AI — that compile to real JavaScript.',
            onTap: projectController.currentProject == null
                ? () => _showOpenProjectFirst(context)
                : () => Navigator.push(context, MaterialPageRoute(builder: (_) => AutomationListScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.dashboard_customize_outlined,
            color: Colors.deepOrangeAccent,
            title: 'Layout Sandbox',
            subtitle: 'Write your own layout algorithm and watch it position real boxes.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LayoutSandboxScreen())),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.tab_unselected,
            color: Colors.purpleAccent,
            title: 'Browser Constructor',
            subtitle: 'Invent custom HTML tags and CSS properties, backed by a real compiler.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BrowserConstructorListScreen())),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.rocket_launch_outlined,
            color: Colors.redAccent,
            title: 'Future Web Sandbox',
            subtitle: '3D scenes, gesture-first interfaces, and voice — real browser APIs, not fantasy.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FutureWebSandboxScreen(projectController: projectController))),
          ),

          const SizedBox(height: 24),
          _SectionHeader('Share & Remember'),
          _LabTile(
            icon: Icons.history,
            color: Colors.lightBlue,
            title: 'Invention Timeline',
            subtitle: 'Save checkpoints, rewind, branch, and compare any two versions of your project.',
            onTap: projectController.currentProject == null
                ? () => _showOpenProjectFirst(context)
                : () => Navigator.push(context, MaterialPageRoute(builder: (_) => InventionTimelineScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.people_outline,
            color: Colors.deepOrange,
            title: 'Community Templates',
            subtitle: 'Free templates shared by other students — browse, use, or share your own.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityTemplatesScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _LabTile(
            icon: Icons.hub_outlined,
            color: Colors.indigoAccent,
            title: 'Citation Chain',
            subtitle: 'See which shared templates became the seed for other students\' work.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CitationChainScreen())),
          ),
        ],
      ),
    );
  }

  void _showOpenProjectFirst(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Open a project first to use this tool.')),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey.shade600, letterSpacing: 0.5),
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

  const _LabTile({required this.icon, required this.color, required this.title, required this.subtitle, required this.onTap});

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
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.white)),
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
