import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cyber_models.dart';
import 'cyber_service.dart';
import 'ctf_screen.dart';
import 'sandbox_screen.dart';

// ============================================================
// CYBER LAB HOME SCREEN — entry point and module picker
// ============================================================

class CyberLabHomeScreen extends StatefulWidget {
  const CyberLabHomeScreen({super.key});

  @override
  State<CyberLabHomeScreen> createState() => _CyberLabHomeScreenState();
}

class _CyberLabHomeScreenState extends State<CyberLabHomeScreen> {
  late final CyberService _cyberService;
  bool _isLoading = true;
  int _totalScore = 0;
  int _solvedCount = 0;
  final int _totalChallenges = CyberChallenges.all.length;

  @override
  void initState() {
    super.initState();
    _cyberService = CyberService(
      supabase: Supabase.instance.client,
      userId: Supabase.instance.client.auth.currentUser!.id,
    );
    _init();
  }

  Future<void> _init() async {
    await _cyberService.initialize();
    await _refreshScore();
  }

  Future<void> _refreshScore() async {
    setState(() => _isLoading = true);
    final score = await _cyberService.getTotalScore();

    int solved = 0;
    for (final challenge in CyberChallenges.all) {
      if (await _cyberService.isChallengeSolved(challenge.id)) {
        solved++;
      }
    }

    if (!mounted) return;
    setState(() {
      _totalScore = score;
      _solvedCount = solved;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _cyberService.dispose();
    super.dispose();
  }

  Future<void> _openCtf() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CtfListScreen(cyberService: _cyberService),
      ),
    );
    // Score may have changed while the student was solving challenges.
    await _refreshScore();
  }

  void _openSandbox() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SandboxScreen(cyberService: _cyberService),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cybersecurity Lab'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshScore,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildScoreCard(),
            const SizedBox(height: 20),
            _buildModuleCard(
              icon: Icons.flag_outlined,
              iconColor: Colors.deepOrange,
              title: 'Capture The Flag',
              subtitle: '$_solvedCount / $_totalChallenges challenges solved — cryptography, web security, forensics, OSINT, networking',
              onTap: _openCtf,
            ),
            const SizedBox(height: 12),
            _buildModuleCard(
              icon: Icons.dns_outlined,
              iconColor: Colors.indigo,
              title: 'Vulnerable App Sandbox',
              subtitle: 'Practice real attack techniques against a safe, isolated target — SQL injection, XSS, and more',
              onTap: _openSandbox,
            ),
            const SizedBox(height: 12),
            _buildModuleCard(
              icon: Icons.router_outlined,
              iconColor: Colors.teal,
              title: 'Packet Analysis',
              subtitle: 'Inspect a real captured network trace and spot the attack pattern',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SandboxScreen(
                      cyberService: _cyberService,
                      initialTabIndex: 2,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            _buildSafetyNote(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C2D12), Color(0xFFC2410C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, color: Colors.white, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Score',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 4),
                _isLoading
                    ? const SizedBox(
                        height: 28,
                        width: 28,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text(
                        '$_totalScore points',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSafetyNote() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Every exercise here runs in an isolated sandbox created just for you. '
              'The skills you practice are for defending real systems — never use them '
              'outside this lab without explicit authorization.',
              style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
            ),
          ),
        ],
      ),
    );
  }
}
