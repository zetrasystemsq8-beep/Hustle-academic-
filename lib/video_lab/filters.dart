import 'package:flutter/material.dart';

class FilterPreset {
  final String id;
  final String label;
  final ColorFilter colorFilter;

  const FilterPreset({required this.id, required this.label, required this.colorFilter});
}

final List<FilterPreset> kFilterPresets = [
  const FilterPreset(id: 'none', label: 'None', colorFilter: ColorFilter.matrix([
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ])),
  const FilterPreset(id: 'warm', label: 'Warm', colorFilter: ColorFilter.matrix([
    1.15, 0, 0, 0, 10,
    0, 1.0, 0, 0, 5,
    0, 0, 0.85, 0, 0,
    0, 0, 0, 1, 0,
  ])),
  const FilterPreset(id: 'cool', label: 'Cool', colorFilter: ColorFilter.matrix([
    0.85, 0, 0, 0, 0,
    0, 1.0, 0, 0, 0,
    0, 0, 1.2, 0, 10,
    0, 0, 0, 1, 0,
  ])),
  const FilterPreset(id: 'bw', label: 'B&W', colorFilter: ColorFilter.matrix([
    0.33, 0.59, 0.11, 0, 0,
    0.33, 0.59, 0.11, 0, 0,
    0.33, 0.59, 0.11, 0, 0,
    0, 0, 0, 1, 0,
  ])),
  const FilterPreset(id: 'vintage', label: 'Vintage', colorFilter: ColorFilter.matrix([
    0.6, 0.35, 0.15, 0, 15,
    0.2, 0.55, 0.15, 0, 10,
    0.2, 0.3, 0.4, 0, 0,
    0, 0, 0, 1, 0,
  ])),
  const FilterPreset(id: 'vivid', label: 'Vivid', colorFilter: ColorFilter.matrix([
    1.3, -0.1, -0.1, 0, 0,
    -0.1, 1.3, -0.1, 0, 0,
    -0.1, -0.1, 1.3, 0, 0,
    0, 0, 0, 1, 0,
  ])),
];

FilterPreset filterPresetFor(String id) =>
    kFilterPresets.firstWhere((f) => f.id == id, orElse: () => kFilterPresets.first);
