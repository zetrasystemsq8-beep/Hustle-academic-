import 'package:flutter/material.dart';
import '../controllers/animation_lab_controller.dart';

/// Timing controls for Animation Lab: name, duration, easing, iteration
/// count, and direction — the fields that become `animation-*` CSS
/// properties in the generated output.
class AnimationControlsPanel extends StatelessWidget {
  final AnimationLabController controller;

  const AnimationControlsPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                initialValue: controller.animationName,
                decoration: const InputDecoration(labelText: 'Animation name', isDense: true, border: OutlineInputBorder()),
                onChanged: controller.setAnimationName,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Duration', style: TextStyle(fontSize: 13)),
                  Expanded(
                    child: Slider(
                      value: controller.durationMs.toDouble().clamp(100, 5000),
                      min: 100,
                      max: 5000,
                      divisions: 49,
                      label: '${controller.durationMs}ms',
                      onChanged: (v) => controller.setDuration(v.round()),
                    ),
                  ),
                  Text('${controller.durationMs}ms', style: const TextStyle(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 60, child: Text('Easing', style: TextStyle(fontSize: 13))),
                  Expanded(
                    child: DropdownButton<EasingPreset>(
                      isExpanded: true,
                      value: controller.easing,
                      items: EasingPreset.values.map((preset) {
                        return DropdownMenuItem(value: preset, child: Text(preset.name));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) controller.setEasing(value);
                      },
                    ),
                  ),
                ],
              ),
              if (controller.easing == EasingPreset.custom)
                TextFormField(
                  initialValue: controller.customEasingValue,
                  decoration: const InputDecoration(labelText: 'cubic-bezier(...)', isDense: true, border: OutlineInputBorder()),
                  onChanged: controller.setCustomEasing,
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: controller.iterationCount,
                      decoration: const InputDecoration(labelText: 'Iterations', isDense: true, border: OutlineInputBorder()),
                      onChanged: controller.setIterationCount,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButton<AnimationDirection>(
                      isExpanded: true,
                      value: controller.direction,
                      items: AnimationDirection.values.map((d) {
                        return DropdownMenuItem(value: d, child: Text(d.cssValue));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) controller.setDirection(value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
