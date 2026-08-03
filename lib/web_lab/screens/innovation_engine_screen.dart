import 'package:flutter/material.dart';
import '../controllers/project_controller.dart';
import 'animation_lab_screen.dart';
import 'automation_engine_screen.dart';
import 'community_templates_screen.dart';
import 'comparator_screen.dart';
import 'component_workshop_screen.dart';
import 'design_lab_screen.dart';
import 'experiment_runner_screen.dart';
import 'frontier_labs_screen.dart';
import 'invention_timeline_screen.dart';
import 'js_playground_screen.dart';
import 'language_factory_screen.dart';
import 'legacy_screen.dart';
import 'package_manager_screen.dart';
import 'plugin_system_screen.dart';
import 'research_notebook_screen.dart';
import 'rfc_screen.dart';
import 'sandbox_screen.dart';
import 'simulation_center_screen.dart';
import 'svg_studio_screen.dart';
import 'system_builder_screen.dart';
import 'testing_lab_screen.dart';
import 'tool_builder_screen.dart';
import 'visualization_center_screen.dart';
import 'web_universe_screen.dart';

/// Innovation Engine: the top-level research layer of Hustle Academy,
/// sitting alongside — never replacing — Web Lab. Every existing Web
/// Lab feature is reachable from here exactly as it always was; nothing
/// underneath was rewritten to build this screen. This is purely an
/// organizing layer matching the requested architecture: Research
/// Center, Theory Center, Simulation Center, Language Factory, Compiler
/// Factory, Protocol Factory, Browser Engine Lab, Rendering Lab,
/// Automation Factory, Tool Builder, Visualization Center, Experiment
/// Center, Publication Center, Knowledge Graph, Version Evolution,
/// Plugin System, and — newest — Cognition Lab: System Builder and its
/// Comparator, for assembling and testing real cognitive architectures.
class InnovationEngineScreen extends StatelessWidget {
  final ProjectController projectController;

  const InnovationEngineScreen({super.key, required this.projectController});

  void _requireProject(BuildContext context, VoidCallback action) {
    if (projectController.currentProject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Open a project first to use this center.')),
      );
      return;
    }
    action();
  }

  @override
  Widget build(BuildContext context) {
    final project = projectController.currentProject;

    return Scaffold(
      appBar: AppBar(title: const Text('Innovation Engine')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF4338CA), Color(0xFF7C3AED)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Research. Design. Simulate. Invent.', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('A research layer above Web Lab — for programming languages, browser engines, protocols, and computing models.', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),

          _SectionHeader('Research Center'),
          _EngineTile(
            icon: Icons.menu_book_outlined,
            color: Colors.purple,
            title: 'Research Notebook',
            subtitle: 'Hypothesis → Method → Result → Conclusion, per project.',
            onTap: () => _requireProject(context, () => Navigator.push(context, MaterialPageRoute(builder: (_) => ResearchNotebookScreen(projectId: project!.id, projectName: project.name)))),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Theory Center'),
          _EngineTile(
            icon: Icons.description_outlined,
            color: Colors.blue,
            title: 'RFC System',
            subtitle: 'Formal proposals: Motivation, Design, Alternatives, Open Questions.',
            onTap: () => _requireProject(context, () => Navigator.push(context, MaterialPageRoute(builder: (_) => RfcListScreen(filterProjectId: project!.id, filterProjectName: project.name)))),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Cognition Lab'),
          _EngineTile(
            icon: Icons.psychology_outlined,
            color: Colors.deepPurple,
            title: 'System Builder',
            subtitle: 'Assemble Memory, Reasoning, Learning, Planning, Perception, and Action into a real working system.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SystemBuilderListScreen())),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.compare_arrows,
            color: Colors.deepPurpleAccent,
            title: 'Comparator',
            subtitle: 'Pit two systems — or your system vs. a real Groq LLM — against the same task.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ComparatorScreen())),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Simulation Center'),
          _EngineTile(
            icon: Icons.memory,
            color: Colors.blueGrey,
            title: 'Simulation Center',
            subtitle: 'Build finite state machines and stack-based virtual machines — step through real execution.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SimulationCenterScreen())),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Language Factory & Compiler Factory'),
          _EngineTile(
            icon: Icons.translate,
            color: Colors.indigo,
            title: 'Language Factory',
            subtitle: 'Invent syntax and compile it to real JavaScript — the same mechanism as a real compiler.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageFactoryListScreen())),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Protocol Factory'),
          _EngineTile(
            icon: Icons.public,
            color: Colors.blue,
            title: 'Web Universe',
            subtitle: 'Design mock APIs and simulated networks — real, intercepted fetch() calls.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WebUniverseListScreen())),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Browser Engine Lab & Rendering Lab'),
          _EngineTile(
            icon: Icons.tab_unselected,
            color: Colors.purpleAccent,
            title: 'Browser Constructor',
            subtitle: 'Invent custom HTML tags and CSS properties, backed by a real compiler.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BrowserConstructorListScreen())),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.dashboard_customize_outlined,
            color: Colors.deepOrangeAccent,
            title: 'Layout Sandbox',
            subtitle: 'Write your own layout algorithm and watch it position real boxes.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LayoutSandboxScreen())),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.gesture,
            color: Colors.deepPurple,
            title: 'SVG Studio',
            subtitle: 'Build icons, logos, and illustrations with real SVG shapes.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SvgStudioScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.animation,
            color: Colors.pink,
            title: 'Animation Lab',
            subtitle: 'Design CSS keyframe animations with a live, accurate preview.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnimationLabScreen(projectController: projectController))),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Automation Factory'),
          _EngineTile(
            icon: Icons.bolt_outlined,
            color: Colors.amber,
            title: 'Automation Engine',
            subtitle: 'Chain triggers, conditions, and actions — no AI — into real JavaScript.',
            onTap: () => _requireProject(context, () => Navigator.push(context, MaterialPageRoute(builder: (_) => AutomationListScreen(projectController: projectController)))),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Tool Builder'),
          _EngineTile(
            icon: Icons.build_outlined,
            color: Colors.brown,
            title: 'Tool Builder',
            subtitle: 'Build your own linter — real pattern-matching rules producing diagnostics.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ToolBuilderListScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.fact_check_outlined,
            color: Colors.green,
            title: 'Testing Lab',
            subtitle: 'Built-in HTML, CSS, JS, and accessibility checks.',
            onTap: () => _requireProject(context, () => Navigator.push(context, MaterialPageRoute(builder: (_) => TestingLabScreen(project: project!)))),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Visualization Center'),
          _EngineTile(
            icon: Icons.bar_chart,
            color: Colors.teal,
            title: 'Visualization Center',
            subtitle: 'Real bar, line, scatter, and pie charts from your own data.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VisualizationCenterScreen())),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Experiment Center'),
          _EngineTile(
            icon: Icons.science_outlined,
            color: Colors.cyan,
            title: 'Experiment Runner',
            subtitle: 'Compare code variants with real, timed, repeated measurements.',
            onTap: () => _requireProject(context, () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExperimentListScreen(projectId: project!.id, projectName: project.name)))),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.code,
            color: Colors.indigo,
            title: 'JS Playground',
            subtitle: 'Scratch runner with variable inspection and benchmarking.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JsPlaygroundScreen())),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.rocket_launch_outlined,
            color: Colors.redAccent,
            title: 'Future Web Sandbox',
            subtitle: '3D scenes, gesture-first interfaces, and voice — real browser APIs.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FutureWebSandboxScreen(projectController: projectController))),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Publication Center'),
          _EngineTile(
            icon: Icons.people_outline,
            color: Colors.deepOrange,
            title: 'Community Templates',
            subtitle: 'Free templates shared by other students.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityTemplatesScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.widgets_outlined,
            color: Colors.teal,
            title: 'Component Workshop',
            subtitle: 'Reusable buttons, cards, forms — your saved personal library.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ComponentWorkshopScreen(projectController: projectController))),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.inventory_2_outlined,
            color: Colors.brown,
            title: 'Package Manager',
            subtitle: 'Import Bootstrap, Tailwind, Alpine.js, Chart.js, Three.js, or GSAP via CDN.',
            onTap: () => _requireProject(context, () => Navigator.push(context, MaterialPageRoute(builder: (_) => PackageManagerScreen(projectController: projectController)))),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.palette_outlined,
            color: Colors.orange,
            title: 'Design Lab',
            subtitle: 'Color, gradients, shadows, radius, spacing, typography.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DesignLabScreen(projectController: projectController))),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Knowledge Graph & Citation Chain'),
          _EngineTile(
            icon: Icons.hub_outlined,
            color: Colors.indigoAccent,
            title: 'Knowledge Graph',
            subtitle: 'Per-project view: Notebook, RFCs, Experiments, Publication status.',
            onTap: () => _requireProject(context, () => Navigator.push(context, MaterialPageRoute(builder: (_) => KnowledgeGraphScreen(project: project!)))),
          ),
          const SizedBox(height: 10),
          _EngineTile(
            icon: Icons.link,
            color: Colors.indigoAccent,
            title: 'Citation Chain',
            subtitle: 'Which shared templates became the seed for other students\' work.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CitationChainScreen())),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Version Evolution'),
          _EngineTile(
            icon: Icons.history,
            color: Colors.lightBlue,
            title: 'Invention Timeline',
            subtitle: 'Checkpoints, rewind, branch, and real line-by-line diffs.',
            onTap: () => _requireProject(context, () => Navigator.push(context, MaterialPageRoute(builder: (_) => InventionTimelineScreen(projectController: projectController)))),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Plugin System'),
          _EngineTile(
            icon: Icons.extension_outlined,
            color: Colors.green,
            title: 'Plugin System',
            subtitle: 'Publish and install languages, workflows, and tools others invented.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PluginSystemScreen())),
          ),

          const SizedBox(height: 20),
          _SectionHeader('Open Experimentation'),
          _EngineTile(
            icon: Icons.science_outlined,
            color: Colors.cyan,
            title: 'Sandbox',
            subtitle: 'No project needed — instant HTML/CSS/JS scratch space.',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SandboxScreen(projectController: projectController))),
          ),
        ],
      ),
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
      child: Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey.shade600, letterSpacing: 0.5)),
    );
  }
}

class _EngineTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _EngineTile({required this.icon, required this.color, required this.title, required this.subtitle, required this.onTap});

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
