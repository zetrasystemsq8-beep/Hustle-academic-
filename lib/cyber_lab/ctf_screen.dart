import 'package:flutter/material.dart';
import 'cyber_models.dart';
import 'cyber_service.dart';

// ============================================================
// CTF LIST SCREEN
// ============================================================

class CtfListScreen extends StatefulWidget {
  final CyberService cyberService;

  const CtfListScreen({super.key, required this.cyberService});

  @override
  State<CtfListScreen> createState() => _CtfListScreenState();
}

class _CtfListScreenState extends State<CtfListScreen> {
  CtfCategory? _selectedCategory;
  final Map<String, bool> _solvedCache = {};
  bool _isLoadingSolved = true;

  @override
  void initState() {
    super.initState();
    _loadSolvedStatus();
  }

  Future<void> _loadSolvedStatus() async {
    setState(() => _isLoadingSolved = true);
    for (final challenge in CyberChallenges.all) {
      final solved = await widget.cyberService.isChallengeSolved(challenge.id);
      _solvedCache[challenge.id] = solved;
    }
    if (mounted) setState(() => _isLoadingSolved = false);
  }

  List<CtfChallenge> get _filtered {
    if (_selectedCategory == null) return CyberChallenges.all;
    return CyberChallenges.all.where((c) => c.category == _selectedCategory).toList();
  }

  Future<void> _openChallenge(CtfChallenge challenge) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CtfChallengeScreen(
          challenge: challenge,
          cyberService: widget.cyberService,
        ),
      ),
    );
    await _loadSolvedStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture The Flag'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: _isLoadingSolved
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filtered.length,
                    itemBuilder: (context, i) => _buildChallengeCard(_filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            _buildChip(null, 'All'),
            for (final cat in CtfCategory.values) _buildChip(cat, _labelFor(cat)),
          ],
        ),
      ),
    );
  }

  String _labelFor(CtfCategory cat) {
    switch (cat) {
      case CtfCategory.cryptography:
        return 'Cryptography';
      case CtfCategory.webSecurity:
        return 'Web Security';
      case CtfCategory.forensics:
        return 'Forensics';
      case CtfCategory.osint:
        return 'OSINT';
      case CtfCategory.networking:
        return 'Networking';
    }
  }

  Widget _buildChip(CtfCategory? cat, String label) {
    final isSelected = _selectedCategory == cat;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => setState(() => _selectedCategory = cat),
        selectedColor: Colors.deepOrange.shade100,
        checkmarkColor: Colors.deepOrange,
      ),
    );
  }

  Widget _buildChallengeCard(CtfChallenge challenge) {
    final solved = _solvedCache[challenge.id] ?? false;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: solved ? Colors.green.shade200 : Colors.grey.shade200),
      ),
      color: solved ? Colors.green.shade50 : Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          backgroundColor: challenge.difficultyColor.withOpacity(0.15),
          child: Icon(challenge.categoryIcon, color: challenge.difficultyColor),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(challenge.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            if (solved) const Icon(Icons.check_circle, color: Colors.green, size: 18),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              _buildTag(challenge.categoryLabel, Colors.grey.shade600),
              const SizedBox(width: 6),
              _buildTag(challenge.difficultyLabel, challenge.difficultyColor),
              const Spacer(),
              Text('${challenge.points} pts', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
        ),
        onTap: () => _openChallenge(challenge),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 11)),
    );
  }
}

// ============================================================
// CTF CHALLENGE DETAIL SCREEN
// ============================================================

class CtfChallengeScreen extends StatefulWidget {
  final CtfChallenge challenge;
  final CyberService cyberService;

  const CtfChallengeScreen({super.key, required this.challenge, required this.cyberService});

  @override
  State<CtfChallengeScreen> createState() => _CtfChallengeScreenState();
}

class _CtfChallengeScreenState extends State<CtfChallengeScreen> {
  final _flagController = TextEditingController();
  final Set<int> _revealedHints = {};
  bool _isSubmitting = false;
  bool? _lastResultCorrect;
  bool _alreadySolved = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkSolved();
  }

  Future<void> _checkSolved() async {
    final solved = await widget.cyberService.isChallengeSolved(widget.challenge.id);
    if (mounted) setState(() => _alreadySolved = solved);
  }

  @override
  void dispose() {
    _flagController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final guess = _flagController.text.trim();
    if (guess.isEmpty) {
      setState(() => _errorMessage = 'Enter a flag before submitting.');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
      _lastResultCorrect = null;
    });

    try {
      final correct = await widget.cyberService.submitFlag(
        challenge: widget.challenge,
        guess: guess,
      );

      if (!mounted) return;
      setState(() {
        _lastResultCorrect = correct;
        _isSubmitting = false;
        if (correct) _alreadySolved = true;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        // Friendly, specific messages instead of a raw stack trace —
        // students should understand what to do next, not see "Exception: ...".
        if (e.toString().contains('SocketException') || e.toString().contains('Network')) {
          _errorMessage = 'No internet connection. Check your network and try again.';
        } else if (e.toString().contains('PostgrestException') || e.toString().contains('duplicate')) {
          _errorMessage = 'Something went wrong saving your attempt. Please try again.';
        } else {
          _errorMessage = 'Could not submit right now. Please try again in a moment.';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final challenge = widget.challenge;

    return Scaffold(
      appBar: AppBar(
        title: Text(challenge.title),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Icon(challenge.categoryIcon, color: challenge.difficultyColor, size: 20),
              const SizedBox(width: 8),
              Text(challenge.categoryLabel, style: TextStyle(color: Colors.grey.shade700)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: challenge.difficultyColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${challenge.difficultyLabel} · ${challenge.points} pts',
                  style: TextStyle(color: challenge.difficultyColor, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_alreadySolved)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 10),
                  const Expanded(child: Text('You already solved this challenge. You can resubmit for practice.')),
                ],
              ),
            ),
          Text(challenge.briefing, style: const TextStyle(fontSize: 15, height: 1.5)),
          if (challenge.attachedData != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                challenge.attachedData!,
                style: const TextStyle(color: Color(0xFF9CDCFE), fontFamily: 'monospace', fontSize: 13),
              ),
            ),
          ],
          const SizedBox(height: 20),
          _buildHintsSection(challenge),
          const SizedBox(height: 24),
          const Text('Submit Flag', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          TextField(
            controller: _flagController,
            decoration: InputDecoration(
              hintText: 'FLAG{...}',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onSubmitted: (_) => _submit(),
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(_errorMessage!, style: TextStyle(color: Colors.red.shade900, fontSize: 13))),
                ],
              ),
            ),
          ],
          if (_lastResultCorrect != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _lastResultCorrect! ? Colors.green.shade50 : Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    _lastResultCorrect! ? Icons.check_circle : Icons.close,
                    color: _lastResultCorrect! ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _lastResultCorrect!
                          ? 'Correct! Points added to your score.'
                          : 'Not quite — check the hints and try again.',
                      style: TextStyle(
                        color: _lastResultCorrect! ? Colors.green.shade900 : Colors.orange.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: _isSubmitting
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHintsSection(CtfChallenge challenge) {
    if (challenge.hints.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hints', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 8),
        for (int i = 0; i < challenge.hints.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _revealedHints.contains(i)
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(challenge.hints[i], style: const TextStyle(fontSize: 13)),
                  )
                : OutlinedButton.icon(
                    onPressed: () => setState(() => _revealedHints.add(i)),
                    icon: const Icon(Icons.lightbulb_outline, size: 16),
                    label: Text('Reveal hint ${i + 1}'),
                  ),
          ),
      ],
    );
  }
}
