import 'package:flutter/material.dart';
import 'cyber_models.dart';
import 'cyber_service.dart';
import 'terminal_panel.dart';

// ============================================================
// SANDBOX SCREEN — 4 tabs: live sandbox session, HTTP attack
// tool, terminal (curl/nmap/nikto), and packet capture viewer.
// ============================================================

class SandboxScreen extends StatefulWidget {
  final CyberService cyberService;
  final int initialTabIndex;

  const SandboxScreen({super.key, required this.cyberService, this.initialTabIndex = 0});

  @override
  State<SandboxScreen> createState() => _SandboxScreenState();
}

class _SandboxScreenState extends State<SandboxScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isProvisioning = false;
  String? _provisionError;

  // HTTP tool state
  String _method = 'GET';
  final _pathController = TextEditingController(text: '/');
  final _bodyController = TextEditingController();
  HttpToolResponse? _lastResponse;
  bool _isSending = false;
  String? _sendError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialTabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pathController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

Future<void> _provisionSandbox() async {
    setState(() {
      _isProvisioning = true;
      _provisionError = null;
    });
    try {
      await widget.cyberService.provisionSandbox();
    } catch (e) {
      if (mounted) {
        final msg = e.toString();
        setState(() {
          _provisionError = msg.contains('already have an active sandbox')
              ? 'You already have a sandbox running. Check back in a few minutes, or it will expire on its own.'
              : 'Could not start the sandbox. Please try again in a moment.';
        });
      }
    } finally {
      if (mounted) setState(() => _isProvisioning = false);
    }
  }

  Future<void> _stopSandbox(String sessionId) async {
    try {
      await widget.cyberService.stopSandbox(sessionId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not stop the sandbox — it will expire automatically.')),
        );
      }
    }
  }

  Future<void> _sendRequest() async {
    setState(() {
      _isSending = true;
      _sendError = null;
      _lastResponse = null;
    });

    try {
      final response = await widget.cyberService.sendSandboxRequest(
        HttpToolRequest(
          method: _method,
          path: _pathController.text.trim().isEmpty ? '/' : _pathController.text.trim(),
          headers: const {'Content-Type': 'application/json'},
          body: _bodyController.text.isEmpty ? null : _bodyController.text,
        ),
      );
      if (mounted) setState(() => _lastResponse = response);
    } catch (e) {
      if (mounted) {
        setState(() {
          if (e.toString().contains('No active sandbox')) {
            _sendError = 'No sandbox is running. Start one from the Sandbox tab first.';
          } else if (e.toString().contains('SocketException')) {
            _sendError = 'Could not reach the sandbox. It may have expired — try starting a new one.';
          } else {
            _sendError = 'Request failed. Please try again.';
          }
        });
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vulnerable App Sandbox'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Sandbox', icon: Icon(Icons.dns_outlined)),
            Tab(text: 'Attack Tool', icon: Icon(Icons.send)),
            Tab(text: 'Terminal', icon: Icon(Icons.terminal)),
            Tab(text: 'Packet Analysis', icon: Icon(Icons.router_outlined)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSandboxTab(),
          _buildAttackToolTab(),
          _buildTerminalTab(),
          _buildPacketAnalysisTab(),
        ],
      ),
    );
  }

  // ---------------- SANDBOX TAB ----------------

  Widget _buildSandboxTab() {
    return StreamBuilder<SandboxSession>(
      stream: widget.cyberService.sandboxStream,
      initialData: widget.cyberService.currentSandbox,
      builder: (context, snapshot) {
        final session = snapshot.data;

        if (session == null || !session.isActive) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dns_outlined, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text('No active sandbox', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    'Starts a real, isolated vulnerable web app just for you. It automatically expires after 15 minutes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),
                  if (_provisionError != null) ...[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                      child: Text(_provisionError!, style: TextStyle(color: Colors.red.shade900)),
                    ),
                    const SizedBox(height: 12),
                  ],
                  ElevatedButton.icon(
                    onPressed: _isProvisioning ? null : _provisionSandbox,
                    icon: _isProvisioning
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.play_arrow),
                    label: Text(_isProvisioning ? 'Starting sandbox...' : 'Start Sandbox'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }

        final minutesLeft = session.timeRemaining.inMinutes;
        final secondsLeft = session.timeRemaining.inSeconds % 60;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle, color: Colors.green, size: 12),
                        const SizedBox(width: 8),
                        const Text('Sandbox Running', style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text(
                          '${minutesLeft}m ${secondsLeft}s left',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Target URL', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    SelectableText(
                      session.targetUrl,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade700, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Use the Attack Tool or Terminal tabs to interact with this sandbox. Both are locked to this URL only.',
                        style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _stopSandbox(session.id),
                  icon: const Icon(Icons.stop_circle_outlined, color: Colors.red),
                  label: const Text('Stop Sandbox', style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------- ATTACK TOOL TAB ----------------

  Widget _buildAttackToolTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DropdownButton<String>(
                value: _method,
                items: const [
                  DropdownMenuItem(value: 'GET', child: Text('GET')),
                  DropdownMenuItem(value: 'POST', child: Text('POST')),
                  DropdownMenuItem(value: 'PUT', child: Text('PUT')),
                  DropdownMenuItem(value: 'DELETE', child: Text('DELETE')),
                ],
                onChanged: (v) => setState(() => _method = v ?? 'GET'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _pathController,
                  decoration: const InputDecoration(
                    hintText: '/path',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                ),
              ),
            ],
          ),
          if (_method == 'POST' || _method == 'PUT') ...[
            const SizedBox(height: 10),
            TextField(
              controller: _bodyController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Request body (JSON or form data)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isSending ? null : _sendRequest,
              icon: _isSending
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.send),
              label: Text(_isSending ? 'Sending...' : 'Send Request'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
            ),
          ),
          if (_sendError != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
              child: Text(_sendError!, style: TextStyle(color: Colors.red.shade900, fontSize: 13)),
            ),
          ],
          if (_lastResponse != null) ...[
            const SizedBox(height: 16),
            const Text('Response', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status: ${_lastResponse!.statusCode}  ·  ${_lastResponse!.duration.inMilliseconds}ms',
                    style: TextStyle(
                      color: _lastResponse!.statusCode < 400 ? Colors.greenAccent : Colors.redAccent,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  const Divider(color: Colors.white24),
                  SelectableText(
                    _lastResponse!.body,
                    style: const TextStyle(color: Colors.white70, fontFamily: 'monospace', fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------- TERMINAL TAB ----------------

  Widget _buildTerminalTab() {
    return TerminalPanel(cyberService: widget.cyberService);
  }

  // ---------------- PACKET ANALYSIS TAB ----------------

  Widget _buildPacketAnalysisTab() {
    final capture = widget.cyberService.getPracticeCapture();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          color: Colors.teal.shade50,
          child: Text(
            capture.title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade900),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: capture.packets.length,
            itemBuilder: (context, i) {
              final p = capture.packets[i];
              return ListTile(
                dense: true,
                leading: Text('#${p.number}', style: const TextStyle(fontFamily: 'monospace')),
                title: Text('${p.sourceIp} → ${p.destIp}', style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
                subtitle: Text(p.info, style: const TextStyle(fontSize: 12)),
                trailing: Text('${p.protocol} · ${p.length}B', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              );
            },
          ),
        ),
      ],
    );
  }
}
