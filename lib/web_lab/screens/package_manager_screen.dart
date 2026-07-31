import 'package:flutter/material.dart';
import '../controllers/project_controller.dart';
import '../package_manager/cdn_package_registry.dart';

/// Lets a student import well-known libraries (Bootstrap, Tailwind,
/// Alpine.js, Chart.js, Three.js, GSAP) into their currently open
/// project via CDN, without writing any AI-generated code — Web Lab
/// only injects the library itself; every line using it is still the
/// student's own.
class PackageManagerScreen extends StatelessWidget {
  final ProjectController projectController;

  const PackageManagerScreen({super.key, required this.projectController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: projectController,
      builder: (context, _) {
        final project = projectController.currentProject;
        if (project == null) {
          return const Scaffold(body: Center(child: Text('No project open.')));
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Package Manager')),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: CdnPackageRegistry.all.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final package = CdnPackageRegistry.all[index];
              final enabled = projectController.isPackageEnabled(package.id);

              return Card(
                child: SwitchListTile(
                  title: Text(package.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(package.description),
                  value: enabled,
                  onChanged: (_) => projectController.togglePackage(package.id),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
