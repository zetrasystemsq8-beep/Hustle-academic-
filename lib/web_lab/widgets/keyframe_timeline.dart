import 'package:flutter/material.dart';
import '../animation_lab/keyframe_model.dart';
import '../controllers/animation_lab_controller.dart';
import 'color_picker_field.dart';

/// Editable list of keyframe steps for Animation Lab: each step's
/// percentage and every active property's value at that point.
class KeyframeTimeline extends StatelessWidget {
  final AnimationLabController controller;

  const KeyframeTimeline({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Text('Keyframes', style: Theme.of(context).textTheme.titleSmall),
                  const Spacer(),
                  PopupMenuButton<AnimatableProperty>(
                    tooltip: 'Add property',
                    icon: const Icon(Icons.add_circle_outline, size: 20),
                    onSelected: controller.addPropertyToAllSteps,
                    itemBuilder: (context) => AnimatableProperty.values
                        .where((p) => !controller.activeProperties.contains(p))
                        .map((p) => PopupMenuItem(value: p, child: Text(p.label)))
                        .toList(),
                  ),
                  IconButton(
                    tooltip: 'Add keyframe step',
                    icon: const Icon(Icons.add, size: 20),
                    onPressed: () {
                      final steps = controller.steps;
                      final lastPercent = steps.isEmpty ? 0.0 : steps.last.percent;
                      final newPercent = lastPercent >= 100 ? 50.0 : ((lastPercent + 100) / 2).clamp(0, 100).toDouble();
                      controller.addStep(newPercent);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: controller.steps.map((step) => _StepCard(step: step, controller: controller)).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StepCard extends StatelessWidget {
  final KeyframeStep step;
  final AnimationLabController controller;

  const _StepCard({required this.step, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${step.percent.toStringAsFixed(0)}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: Slider(
                    value: step.percent.clamp(0, 100),
                    min: 0,
                    max: 100,
                    onChanged: (v) => controller.updatePercent(step, v),
                  ),
                ),
                if (controller.steps.length > 2)
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => controller.removeStep(step),
                  ),
              ],
            ),
            ...step.values.entries.map((entry) => _propertyRow(entry.key, entry.value)),
          ],
        ),
      ),
    );
  }

  Widget _propertyRow(AnimatableProperty property, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(property.label, style: const TextStyle(fontSize: 12))),
          Expanded(
            child: property.isColor
                ? ColorPickerField(
                    label: property.label,
                    hexValue: value,
                    onChanged: (v) => controller.updateStepValue(step, property, v),
                  )
                : TextFormField(
                    initialValue: value,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    style: const TextStyle(fontSize: 12),
                    decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
                    onChanged: (v) => controller.updateStepValue(step, property, v),
                  ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, size: 16),
            onPressed: () => controller.removePropertyFromAllSteps(property),
          ),
        ],
      ),
    );
  }
}
