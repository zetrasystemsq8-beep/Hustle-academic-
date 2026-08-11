import 'package:flutter/material.dart';
import 'cyber_models.dart';
import 'cyber_service.dart';

// ============================================================
// TERMINAL PANEL — real command submission (curl, nmap, nikto)
// against the active sandbox only, with live status/output via
// realtime subscription to sandbox_commands.
// ============================================================

class TerminalPanel extends StatefulWidget {
  final CyberService cyberService;

  const TerminalPanel({super.key, required this.cyberService});

  @override
  State<TerminalPanel> createState() => _TerminalPanelState();
}

class _TerminalPanelState extends State<TerminalPanel> {
  String _tool = 'nmap';
  final _argsController = TextEditingController();
  bool _isSubmitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final session = widget.cyberService.currentSandbox;
    if (session != null) {
      widget.cyberService.subscribeToCommands(session.id);
    }
  }

  @override
  void dispose() {
    _argsController.dispose();
    super.dispose();
  }

  String _defaultArgsFor(String tool, String targetUrl) {
    final host = Uri.tryParse(targetUrl)?.host ?? '';
    switch (tool) {
      case 'nmap':
        return '-sV $host';
      case 'nikto':
        return '-h $targetUrl';
      case 'curl':
        return '-I $targetUrl';
      default:
        return '';
    }
  }

  Future<void> _submit() async {
    final session = widget.cyberService.currentSandbox;
    if (session == null || !session.isActive) {
      setState(() => _error = 'No active sandbox. Start one from the Sandbox tab first.');
      return;
    }

    var args = _argsController.text.trim();
    if (args.isEmpty) {
      args = _defaultArgsFor(_tool, session.targetUrl);
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      await widget.cyberService.submitTerminalCommand(tool: _tool, args: args);
      widget.cyberService.subscribeToCommands(session.id);
      _argsController.clear();
    } catch (e) {
      if (mounted) {
        setState(() {
          final msg = e.toString().replaceFirst('Exception: ', '');
          if (msg.contains('may only target')) {
            _error = 'That command targets something other than your sandbox. Only your sandbox\'s own address is allowed.';
          } else if (msg.contains('disallowed characters')) {
            _error = 'That command contains characters that aren\'t allowed for safety reasons.';
          } else {
            _error = msg;
          }
        });
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.cyberService.currentSandbox;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DropdownButton<String>(
                    value: _tool,
                    items: kAllowedTerminalTools
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (v) => setState(() => _tool = v ?? 'nmap'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _argsController,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                      decoration: InputDecoration(
                        hintText: session != null
                            ? _defaultArgsFor(_tool, session.targetUrl)
                            : 'Start a sandbox first',
                        border: const OutlineInputBorder(),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _submit,
                  icon: _isSubmitting
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.play_arrow),
                  label: Text(_isSubmitting ? 'Running...' : 'Run'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black87, foregroundColor: Colors.white),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                  child: Text(_error!, style: TextStyle(color: Colors.red.shade900, fontSize: 12)),
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<TerminalCommand>>(
            stream: widget.cyberService.commandsStream,
            builder: (context, snapshot) {
              final commands = snapshot.data ?? [];
              if (commands.isEmpty) {
                return Center(
                  child: Text(
                    'Command output will appear here.\nCommands run inside your isolated sandbox session.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: commands.length,
                itemBuilder: (context, i) => _buildCommandCard(commands[commands.length - 1 - i]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCommandCard(TerminalCommand cmd) {
    Color statusColor;
    IconData statusIcon;
    switch (cmd.status) {
      case CommandStatus.pending:
        statusColor = Colors.grey;
        statusIcon = Icons.hourglass_empty;
        break;
      case CommandStatus.running:
        statusColor = Colors.blue;
        statusIcon = Icons.play_circle_outline;
        break;
      case CommandStatus.complete:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case CommandStatus.failed:
      case CommandStatus.rejected:
        statusColor = Colors.red;
        statusIcon = Icons.error_outline;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(statusIcon, color: statusColor, size: 16),
              const SizedBox(width: 6),
              Text(
                '${cmd.tool} ${cmd.args}',
                style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (cmd.status == CommandStatus.pending || cmd.status == CommandStatus.running) ...[
            const SizedBox(height: 6),
            Text(
              cmd.status == CommandStatus.pending ? 'Queued...' : 'Running in sandbox...',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontStyle: FontStyle.italic),
            ),
          ],
          if (cmd.output != null) ...[
            const Divider(color: Colors.white24, height: 16),
            SelectableText(
              cmd.output!,
              style: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}
