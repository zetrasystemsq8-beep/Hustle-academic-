import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/design_lab_controller.dart';
import '../controllers/project_controller.dart';
import '../widgets/color_picker_field.dart';

/// Design Lab: six visual tools — Color, Gradient, Shadow, Border
/// Radius, Spacing, Typography — each generating real, ready-to-use CSS
/// from live-adjustable controls, with Copy and (when a project is
/// open) direct insertion into style.css.
class DesignLabScreen extends StatefulWidget {
  final ProjectController? projectController;

  const DesignLabScreen({super.key, this.projectController});

  @override
  State<DesignLabScreen> createState() => _DesignLabScreenState();
}

class _DesignLabScreenState extends State<DesignLabScreen> with SingleTickerProviderStateMixin {
  late final DesignLabController _controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = DesignLabController();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _copy(String css) {
    Clipboard.setData(ClipboardData(text: css));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('CSS copied')));
  }

  Future<void> _insert(String css) async {
    final projectController = widget.projectController;
    final project = projectController?.currentProject;
    final styleFile = project?.styleCss;
    if (projectController == null || styleFile == null) return;

    styleFile.content = '${styleFile.content}\n\n$css';
    projectController.notifyProjectChanged();
    await projectController.saveCurrentProject();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to style.css')));
  }

  @override
  Widget build(BuildContext context) {
    final hasProject = widget.projectController?.currentProject != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Lab'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Color'),
            Tab(text: 'Gradient'),
            Tab(text: 'Shadow'),
            Tab(text: 'Radius'),
            Tab(text: 'Spacing'),
            Tab(text: 'Typography'),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return TabBarView(
            controller: _tabController,
            children: [
              _colorTab(hasProject),
              _gradientTab(hasProject),
              _shadowTab(hasProject),
              _radiusTab(hasProject),
              _spacingTab(hasProject),
              _typographyTab(hasProject),
            ],
          );
        },
      ),
    );
  }

  Widget _wrapWithPreviewAndCode({required Widget preview, required Widget controls, required String css, required bool hasProject}) {
    return Column(
      children: [
        Container(height: 160, alignment: Alignment.center, color: Colors.grey.shade100, child: preview),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: controls)),
        Container(
          width: double.infinity,
          color: const Color(0xFF1E1E1E),
          padding: const EdgeInsets.all(12),
          child: Text(css, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFD4D4D4))),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.copy), label: const Text('Copy'), onPressed: () => _copy(css))),
              if (hasProject) ...[
                const SizedBox(width: 12),
                Expanded(child: FilledButton.icon(icon: const Icon(Icons.save_outlined), label: const Text('Insert'), onPressed: () => _insert(css))),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _colorTab(bool hasProject) {
    final ratio = _controller.contrastRatio;
    final passesAA = ratio >= 4.5;
    return _wrapWithPreviewAndCode(
      hasProject: hasProject,
      css: _controller.colorCss,
      preview: Container(
        width: 160,
        height: 80,
        color: Color(int.parse(_controller.backgroundHex.substring(1), radix: 16) + 0xFF000000),
        alignment: Alignment.center,
        child: Text('Aa Sample', style: TextStyle(color: Color(int.parse(_controller.foregroundHex.substring(1), radix: 16) + 0xFF000000), fontSize: 18)),
      ),
      controls: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const SizedBox(width: 100, child: Text('Text color')), ColorPickerField(label: 'Text color', hexValue: _controller.foregroundHex, onChanged: _controller.setForeground)]),
          const SizedBox(height: 12),
          Row(children: [const SizedBox(width: 100, child: Text('Background')), ColorPickerField(label: 'Background', hexValue: _controller.backgroundHex, onChanged: _controller.setBackground)]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: (passesAA ? Colors.green : Colors.orange).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Text(
              'Contrast ratio: ${ratio.toStringAsFixed(2)}:1 — ${passesAA ? "passes WCAG AA for normal text" : "fails WCAG AA (needs 4.5:1+)"}',
              style: TextStyle(fontSize: 12, color: passesAA ? Colors.green.shade800 : Colors.orange.shade800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientTab(bool hasProject) {
    return _wrapWithPreviewAndCode(
      hasProject: hasProject,
      css: _controller.gradientCss,
      preview: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: _controller.gradientStops.map((s) => Color(int.parse(s.hex.substring(1), radix: 16) + 0xFF000000)).toList(),
          ),
        ),
      ),
      controls: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Type'),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: _controller.gradientType,
                items: const [DropdownMenuItem(value: 'linear', child: Text('Linear')), DropdownMenuItem(value: 'radial', child: Text('Radial'))],
                onChanged: (v) => v != null ? _controller.setGradientType(v) : null,
              ),
            ],
          ),
          if (_controller.gradientType == 'linear')
            Row(children: [const Text('Angle'), Expanded(child: Slider(value: _controller.gradientAngle, min: 0, max: 360, onChanged: _controller.setGradientAngle))]),
          ...List.generate(_controller.gradientStops.length, (i) {
            final stop = _controller.gradientStops[i];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  ColorPickerField(label: 'Stop ${i + 1}', hexValue: stop.hex, onChanged: (v) => _controller.updateGradientStopColor(i, v)),
                  Expanded(child: Slider(value: stop.position.clamp(0, 100), min: 0, max: 100, onChanged: (v) => _controller.updateGradientStopPosition(i, v))),
                  IconButton(icon: const Icon(Icons.remove_circle_outline, size: 18), onPressed: () => _controller.removeGradientStop(i)),
                ],
              ),
            );
          }),
          TextButton.icon(icon: const Icon(Icons.add), label: const Text('Add stop'), onPressed: _controller.addGradientStop),
        ],
      ),
    );
  }

  Widget _shadowTab(bool hasProject) {
    return _wrapWithPreviewAndCode(
      hasProject: hasProject,
      css: _controller.shadowCss,
      preview: Container(
        width: 120,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(int.parse(_controller.shadowColorHex.substring(1), radix: 16) + 0xFF000000).withOpacity(_controller.shadowOpacity),
              offset: Offset(_controller.shadowOffsetX, _controller.shadowOffsetY),
              blurRadius: _controller.shadowBlur,
              spreadRadius: _controller.shadowSpread,
            ),
          ],
        ),
      ),
      controls: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const SizedBox(width: 90, child: Text('Offset X')), Expanded(child: Slider(value: _controller.shadowOffsetX, min: -40, max: 40, onChanged: (v) => _controller.updateShadow(offsetX: v)))]),
          Row(children: [const SizedBox(width: 90, child: Text('Offset Y')), Expanded(child: Slider(value: _controller.shadowOffsetY, min: -40, max: 40, onChanged: (v) => _controller.updateShadow(offsetY: v)))]),
          Row(children: [const SizedBox(width: 90, child: Text('Blur')), Expanded(child: Slider(value: _controller.shadowBlur, min: 0, max: 80, onChanged: (v) => _controller.updateShadow(blur: v)))]),
          Row(children: [const SizedBox(width: 90, child: Text('Spread')), Expanded(child: Slider(value: _controller.shadowSpread, min: -20, max: 40, onChanged: (v) => _controller.updateShadow(spread: v)))]),
          Row(children: [const SizedBox(width: 90, child: Text('Opacity')), Expanded(child: Slider(value: _controller.shadowOpacity, min: 0, max: 1, onChanged: (v) => _controller.updateShadow(opacity: v)))]),
          Row(children: [const SizedBox(width: 90, child: Text('Color')), ColorPickerField(label: 'Shadow color', hexValue: _controller.shadowColorHex, onChanged: (v) => _controller.updateShadow(colorHex: v))]),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Inset'),
            value: _controller.shadowInset,
            onChanged: (v) => _controller.updateShadow(inset: v),
          ),
        ],
      ),
    );
  }

  Widget _radiusTab(bool hasProject) {
    final radius = _controller.radiusUniform
        ? BorderRadius.circular(_controller.radiusAll)
        : BorderRadius.only(
            topLeft: Radius.circular(_controller.radiusTopLeft),
            topRight: Radius.circular(_controller.radiusTopRight),
            bottomRight: Radius.circular(_controller.radiusBottomRight),
            bottomLeft: Radius.circular(_controller.radiusBottomLeft),
          );

    return _wrapWithPreviewAndCode(
      hasProject: hasProject,
      css: _controller.radiusCss,
      preview: Container(width: 120, height: 80, decoration: BoxDecoration(color: Colors.blue.shade300, borderRadius: radius)),
      controls: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Uniform (all corners)'),
            value: _controller.radiusUniform,
            onChanged: _controller.setRadiusUniform,
          ),
          if (_controller.radiusUniform)
            Row(children: [const Text('Radius'), Expanded(child: Slider(value: _controller.radiusAll, min: 0, max: 100, onChanged: _controller.setRadiusAll))])
          else ...[
            Row(children: [const SizedBox(width: 100, child: Text('Top-left')), Expanded(child: Slider(value: _controller.radiusTopLeft, min: 0, max: 100, onChanged: (v) => _controller.setRadiusCorner(topLeft: v)))]),
            Row(children: [const SizedBox(width: 100, child: Text('Top-right')), Expanded(child: Slider(value: _controller.radiusTopRight, min: 0, max: 100, onChanged: (v) => _controller.setRadiusCorner(topRight: v)))]),
            Row(children: [const SizedBox(width: 100, child: Text('Bottom-right')), Expanded(child: Slider(value: _controller.radiusBottomRight, min: 0, max: 100, onChanged: (v) => _controller.setRadiusCorner(bottomRight: v)))]),
            Row(children: [const SizedBox(width: 100, child: Text('Bottom-left')), Expanded(child: Slider(value: _controller.radiusBottomLeft, min: 0, max: 100, onChanged: (v) => _controller.setRadiusCorner(bottomLeft: v)))]),
          ],
        ],
      ),
    );
  }

  Widget _spacingTab(bool hasProject) {
    return _wrapWithPreviewAndCode(
      hasProject: hasProject,
      css: _controller.spacingCss,
      preview: Wrap(
        spacing: 6,
        children: List.generate(_controller.spacingSteps, (i) {
          final size = _controller.spacingBaseUnit * (i + 1);
          return Container(width: size.clamp(4, 60), height: size.clamp(4, 60), color: Colors.blue.shade200);
        }),
      ),
      controls: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const SizedBox(width: 100, child: Text('Base unit')), Expanded(child: Slider(value: _controller.spacingBaseUnit, min: 2, max: 16, onChanged: _controller.setSpacingBaseUnit))]),
          Row(children: [const SizedBox(width: 100, child: Text('Steps')), Expanded(child: Slider(value: _controller.spacingSteps.toDouble(), min: 2, max: 16, divisions: 14, onChanged: (v) => _controller.setSpacingSteps(v.round())))]),
        ],
      ),
    );
  }

  Widget _typographyTab(bool hasProject) {
    return _wrapWithPreviewAndCode(
      hasProject: hasProject,
      css: _controller.typographyCss,
      preview: Text(
        'The quick brown fox',
        style: TextStyle(
          fontSize: _controller.fontSize,
          fontWeight: FontWeight.values[(int.parse(_controller.fontWeight) ~/ 100) - 1],
          letterSpacing: _controller.letterSpacing,
          height: _controller.lineHeight,
        ),
      ),
      controls: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            isExpanded: true,
            value: _controller.fontFamily,
            items: DesignLabController.fontFamilyOptions.map((f) => DropdownMenuItem(value: f, child: Text(f, overflow: TextOverflow.ellipsis))).toList(),
            onChanged: (v) => v != null ? _controller.setFontFamily(v) : null,
          ),
          Row(children: [const SizedBox(width: 100, child: Text('Font size')), Expanded(child: Slider(value: _controller.fontSize, min: 10, max: 64, onChanged: _controller.setFontSize))]),
          Row(
            children: [
              const SizedBox(width: 100, child: Text('Weight')),
              DropdownButton<String>(
                value: _controller.fontWeight,
                items: DesignLabController.fontWeightOptions.map((w) => DropdownMenuItem(value: w, child: Text(w))).toList(),
                onChanged: (v) => v != null ? _controller.setFontWeight(v) : null,
              ),
            ],
          ),
          Row(children: [const SizedBox(width: 100, child: Text('Line height')), Expanded(child: Slider(value: _controller.lineHeight, min: 0.8, max: 3, onChanged: _controller.setLineHeight))]),
          Row(children: [const SizedBox(width: 100, child: Text('Letter spacing')), Expanded(child: Slider(value: _controller.letterSpacing, min: -2, max: 10, onChanged: _controller.setLetterSpacing))]),
        ],
      ),
    );
  }
}
