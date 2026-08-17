import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'competition_models.dart';
import 'competition_service.dart';
import 'cyber_service.dart';
import 'duel_screen.dart';

// ============================================================
// DUEL LOBBY SCREEN — create a new duel (get a code to share)
// or join an existing one by entering a code.
// ============================================================

class DuelLobbyScreen extends StatefulWidget {
  final CyberService cyberService;

  const DuelLobbyScreen({super.key, required this.cyberService});

  @override
  State<DuelLobbyScreen> createState() => _DuelLobbyScreenState();
}

class _DuelLobbyScreenState extends State<DuelLobbyScreen> {
  late final CompetitionService _competitionService;
  final _codeController = TextEditingController();
  bool _isCreating = false;
  bool _isJoining = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _competitionService = CompetitionService(
      supabase: Supabase.instance.client,
      userId: Supabase.instance.client.auth.currentUser!.id,
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _createDuel() async {
    setState(() {
      _isCreating = true;
      _error = null;
    });
    try {
      final competition = await _competitionService.createDuel();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DuelScreen(competitionId: competition.id, cyberService: widget.cyberService),
        ),
      );
    } catch (e) {
      if (mounted) setState(() => _error = 'Could not create a duel. Please try again.');
    } finally {
      if (mounted) setState(() => _isCreating = false);
    }
  }

  Future<void> _joinDuel() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      setState(() => _error = 'Enter a duel code first.');
      return;
    }

    setState(() {
      _isJoining = true;
      _error = null;
    });

    try {
      final competition = await _competitionService.getCompetition(code);
      if (competition == null) {
        setState(() => _error = 'No duel found with that code.');
        return;
      }

      await _competitionService.joinCompetition(code);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DuelScreen(competitionId: code, cyberService: widget.cyberService),
        ),
      );
    } catch (e) {
      if (mounted) setState(() => _error = 'Could not join. Check the code and try again.');
    } finally {
      if (mounted) setState(() => _isJoining = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cyber Duel'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.bolt, color: Colors.deepOrange, size: 48),
            const SizedBox(height: 12),
            const Text('Challenge Another Student', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'You\'ll both get the same set of challenges. Whoever solves the most correctly wins.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _isCreating ? null : _createDuel,
                icon: _isCreating
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.add),
                label: Text(_isCreating ? 'Creating...' : 'Create a New Duel'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text('Or Join an Existing Duel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                hintText: 'Enter duel code',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(_error!, style: TextStyle(color: Colors.red.shade700, fontSize: 13)),
            ],
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: _isJoining ? null : _joinDuel,
                child: _isJoining
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Join Duel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
