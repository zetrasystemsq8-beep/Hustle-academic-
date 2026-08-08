import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String TABLE_PROFILES = 'profiles';
final SupabaseClient supabase = Supabase.instance.client;

// ---------- MODEL ----------

class UserProfile {
  final String id;
  final String zetramail;
  final String username;
  final bool verified;
  final DateTime createdAt;

  UserProfile({
    required this.id,
    required this.zetramail,
    required this.username,
    required this.verified,
    required this.createdAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      zetramail: json['zetramail'] as String,
      username: json['username'] as String,
      verified: json['verified'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

// ---------- SERVICE ----------

class AuthService {
  String? get lastInternalEmail => supabase.auth.currentUser?.email;

  /// A session exists (password was correct) — but OTP may still
  /// be unverified. Use [isFullyVerified] to gate app access.
  bool get isLoggedIn => supabase.auth.currentUser != null;

  /// True only once the OTP step has actually been completed for
  /// this session. This is what gates entry into MainScreen.
  bool get isFullyVerified {
    final user = supabase.auth.currentUser;
    if (user == null) return false;
    return user.userMetadata?['hustle_otp_verified'] == true;
  }

  Future<UserProfile> signIn({
    required String zetramail,
    required String password,
  }) async {
    try {
      final resolveResult = await supabase.rpc('resolve_login_email', params: {
        'p_identifier': zetramail,
      });

      if (resolveResult == null) {
        throw Exception('ZetraMail not found');
      }

      final internalEmail = resolveResult as String;

      final authResponse = await supabase.auth.signInWithPassword(
        email: internalEmail,
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Login failed');
      }

      await _requestOtp();

      final profileData = await supabase
          .from(TABLE_PROFILES)
          .select()
          .eq('id', authResponse.user!.id)
          .single();

      return UserProfile.fromJson(profileData);
    } on AuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      throw Exception('Sign in error: $e');
    }
  }

  Future<void> _requestOtp() async {
    try {
      await supabase.rpc('request_otp', params: {'p_app_name': 'hustle_academy'});
    } catch (e) {
      throw Exception('OTP request failed: $e');
    }
  }

  Future<void> resendOtp() async {
    if (lastInternalEmail == null) {
      throw Exception('No active session. Please sign in again.');
    }
    await _requestOtp();
  }

  Future<bool> verifyOtp({
    required String internalEmail,
    required String otpCode,
  }) async {
    try {
      final result = await supabase.rpc('verify_otp', params: {
        'p_email': internalEmail,
        'p_otp': otpCode,
      });

      if (result == true) {
        final user = supabase.auth.currentUser;
        if (user != null) {
          await supabase.auth.updateUser(
            UserAttributes(data: {'hustle_otp_verified': true}),
          );
        }
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('OTP verification failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  Future<UserProfile?> getCurrentUser() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return null;

      final profileData = await supabase
          .from(TABLE_PROFILES)
          .select()
          .eq('id', user.id)
          .single();

      return UserProfile.fromJson(profileData);
    } catch (e) {
      return null;
    }
  }
}

final authService = AuthService();

// ---------- LOGIN SCREEN ----------

class LoginScreen extends StatefulWidget {
  final Widget Function() onLoggedIn;

  const LoginScreen({required this.onLoggedIn, Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _zetramailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorText;

  @override
  void dispose() {
    _zetramailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final zetramail = _zetramailController.text.trim();
    final password = _passwordController.text;

    if (zetramail.isEmpty || password.isEmpty) {
      setState(() => _errorText = 'Enter your ZetraMail address and password');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      await authService.signIn(zetramail: zetramail, password: password);
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(
            internalEmail: authService.lastInternalEmail!,
            onVerified: widget.onLoggedIn,
          ),
        ),
      );
    } catch (e) {
      setState(() => _errorText = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1520),
      body: Stack(
        children: [
          Positioned(top: -80, right: -60, child: _blurCircle(220)),
          Positioned(bottom: -100, left: -80, child: _blurCircle(260)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF34D399), Color(0xFF10B981)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF10B981).withOpacity(0.4), blurRadius: 30, spreadRadius: 2),
                      ],
                    ),
                    child: const Icon(Icons.mail_outline, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 32),
                  const Text('Welcome back', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Sign in with your ZetraMail address', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141C29),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      children: [
                        _buildField(
                          controller: _zetramailController,
                          hint: 'ZetraMail address',
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        Divider(color: Colors.white.withOpacity(0.06), height: 1),
                        _buildField(
                          controller: _passwordController,
                          hint: 'Password',
                          icon: Icons.lock_outline,
                          obscure: _obscurePassword,
                          suffix: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.grey[500],
                              size: 20,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_errorText != null) ...[
                    const SizedBox(height: 16),
                    Text(_errorText!, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 13), textAlign: TextAlign.center),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shield_outlined, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text('Secured by your Zetra ID', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 110),
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Log In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[500], size: 20),
        suffixIcon: suffix,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
    );
  }

  Widget _blurCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF10B981).withOpacity(0.15)),
    );
  }
}

// ---------- OTP SCREEN ----------

class OtpScreen extends StatefulWidget {
  final String internalEmail;
  final Widget Function() onVerified;

  const OtpScreen({required this.internalEmail, required this.onVerified, Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  Future<void> _verify() async {
    final code = _otpController.text.trim();
    if (code.isEmpty) {
      setState(() => _errorText = 'Enter the code sent to your ZetraMail');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      final verified = await authService.verifyOtp(internalEmail: widget.internalEmail, otpCode: code);
      if (!mounted) return;

      if (verified) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => widget.onVerified()),
          (route) => false,
        );
      } else {
        setState(() => _errorText = 'Incorrect code — try again');
      }
    } catch (e) {
      setState(() => _errorText = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _resend() async {
    try {
      await authService.resendOtp();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New code sent')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1520),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.verified_user_outlined, color: Color(0xFF10B981), size: 48),
              const SizedBox(height: 24),
              const Text('Verify it\'s you', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Enter the code sent to your ZetraMail address', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF141C29),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 8),
                  decoration: InputDecoration(
                    hintText: '000000',
                    hintStyle: TextStyle(color: Colors.grey[700], letterSpacing: 8),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
              if (_errorText != null) ...[
                const SizedBox(height: 12),
                Text(_errorText!, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 13)),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isLoading
                      ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Verify', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: _resend,
                  child: Text('Resend code', style: TextStyle(color: Colors.grey[400])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
