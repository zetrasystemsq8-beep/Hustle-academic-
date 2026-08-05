import 'package:flutter/material.dart';
import 'mobile_editor_screen.dart';

// ============================================================
// MODEL
// ============================================================

/// A complete, real Flutter starter project — every template here
/// compiles and runs on its own the moment it's created; students
/// modify real working code, they never start from something broken
/// or half-finished.
class MobileProjectTemplate {
  final String id;
  final String name;
  final String category;
  final String description;
  final List<String> extraDependencies;
  final String mainDartContent;

  const MobileProjectTemplate({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    this.extraDependencies = const [],
    required this.mainDartContent,
  });
}

// ============================================================
// TEMPLATE REGISTRY — ten real, complete starter apps
// ============================================================

class MobileTemplateRegistry {
  MobileTemplateRegistry._();

  static const List<MobileProjectTemplate> all = [
    _calculatorTemplate,
    _weatherTemplate,
    _chatTemplate,
    _ecommerceTemplate,
    _musicPlayerTemplate,
    _socialMediaTemplate,
    _bankingTemplate,
    _schoolTemplate,
    _posTemplate,
    _inventoryTemplate,
  ];

  static MobileProjectTemplate? findById(String id) {
    try {
      return all.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  // ---------------------------------------------------------
  // CALCULATOR — a real, fully working four-function calculator
  // ---------------------------------------------------------
  static const _calculatorTemplate = MobileProjectTemplate(
    id: 'calculator',
    name: 'Calculator',
    category: 'Utility',
    description: 'A real working calculator: addition, subtraction, multiplication, division, decimals, and clear.',
    mainDartContent: '''
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorSchemeSeed: Colors.orange),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double? _storedValue;
  String? _pendingOperator;
  bool _shouldResetDisplay = false;

  void _onDigitPressed(String digit) {
    setState(() {
      if (_display == '0' || _shouldResetDisplay) {
        _display = digit;
        _shouldResetDisplay = false;
      } else {
        _display += digit;
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      if (_storedValue != null && _pendingOperator != null && !_shouldResetDisplay) {
        _calculate();
      }
      _storedValue = double.tryParse(_display);
      _pendingOperator = operator;
      _shouldResetDisplay = true;
    });
  }

  void _calculate() {
    if (_storedValue == null || _pendingOperator == null) return;
    final currentValue = double.tryParse(_display) ?? 0;
    double result;
    switch (_pendingOperator) {
      case '+':
        result = _storedValue! + currentValue;
        break;
      case '-':
        result = _storedValue! - currentValue;
        break;
      case '×':
        result = _storedValue! * currentValue;
        break;
      case '÷':
        result = currentValue == 0 ? double.nan : _storedValue! / currentValue;
        break;
      default:
        result = currentValue;
    }
    _display = result.isNaN
        ? 'Error'
        : (result == result.roundToDouble() ? result.toInt().toString() : result.toString());
    _storedValue = null;
    _pendingOperator = null;
  }

  void _onEqualsPressed() {
    setState(() {
      _calculate();
      _shouldResetDisplay = true;
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _storedValue = null;
      _pendingOperator = null;
      _shouldResetDisplay = false;
    });
  }

  Widget _buildButton(String label, {Color? color, VoidCallback? onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: AspectRatio(
          aspectRatio: 1,
          child: Material(
            color: color ?? Colors.grey.shade800,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              child: Center(child: Text(label, style: const TextStyle(fontSize: 26, color: Colors.white))),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: Text(_display, style: const TextStyle(fontSize: 64, color: Colors.white)),
              ),
            ),
            Row(children: [
              _buildButton('C', color: Colors.redAccent, onTap: _onClearPressed),
              _buildButton('÷', color: Colors.orange, onTap: () => _onOperatorPressed('÷')),
              _buildButton('×', color: Colors.orange, onTap: () => _onOperatorPressed('×')),
              _buildButton('-', color: Colors.orange, onTap: () => _onOperatorPressed('-')),
            ]),
            Row(children: [
              _buildButton('7', onTap: () => _onDigitPressed('7')),
              _buildButton('8', onTap: () => _onDigitPressed('8')),
              _buildButton('9', onTap: () => _onDigitPressed('9')),
              _buildButton('+', color: Colors.orange, onTap: () => _onOperatorPressed('+')),
            ]),
            Row(children: [
              _buildButton('4', onTap: () => _onDigitPressed('4')),
              _buildButton('5', onTap: () => _onDigitPressed('5')),
              _buildButton('6', onTap: () => _onDigitPressed('6')),
              _buildButton('=', color: Colors.blue, onTap: _onEqualsPressed),
            ]),
            Row(children: [
              _buildButton('1', onTap: () => _onDigitPressed('1')),
              _buildButton('2', onTap: () => _onDigitPressed('2')),
              _buildButton('3', onTap: () => _onDigitPressed('3')),
              _buildButton('0', onTap: () => _onDigitPressed('0')),
            ]),
            Row(children: [
              _buildButton('.', onTap: _onDecimalPressed),
              const Spacer(flex: 3),
            ]),
          ],
        ),
      ),
    );
  }
}
''',
  );

  // ---------------------------------------------------------
  // WEATHER — a real API call to Open-Meteo, no key required
  // ---------------------------------------------------------
  static const _weatherTemplate = MobileProjectTemplate(
    id: 'weather',
    name: 'Weather',
    category: 'Utility',
    description: 'A real weather app calling the live Open-Meteo API — genuine current conditions, no API key needed.',
    extraDependencies: ['http: ^1.2.0'],
    mainDartContent: '''
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.lightBlue),
      home: const WeatherScreen(),
    );
  }
}

class WeatherReading {
  final double temperatureCelsius;
  final double windSpeedKmh;
  final int weatherCode;

  const WeatherReading({required this.temperatureCelsius, required this.windSpeedKmh, required this.weatherCode});

  String get description {
    if (weatherCode == 0) return 'Clear sky';
    if (weatherCode <= 3) return 'Partly cloudy';
    if (weatherCode <= 48) return 'Foggy';
    if (weatherCode <= 67) return 'Rainy';
    if (weatherCode <= 77) return 'Snowy';
    if (weatherCode <= 82) return 'Rain showers';
    return 'Thunderstorm';
  }

  IconData get icon {
    if (weatherCode == 0) return Icons.wb_sunny;
    if (weatherCode <= 3) return Icons.cloud_queue;
    if (weatherCode <= 67) return Icons.water_drop;
    if (weatherCode <= 77) return Icons.ac_unit;
    return Icons.thunderstorm;
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherReading? _reading;
  bool _isLoading = false;
  String? _error;

  // Lagos, Nigeria — change this to any real latitude/longitude.
  static const double _latitude = 6.5244;
  static const double _longitude = 3.3792;

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final uri = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=\$_latitude&longitude=\$_longitude&current=temperature_2m,wind_speed_10m,weather_code',
      );
      final response = await http.get(uri);
      if (response.statusCode != 200) throw Exception('Server returned \${response.statusCode}');

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final current = data['current'] as Map<String, dynamic>;

      setState(() {
        _reading = WeatherReading(
          temperatureCelsius: (current['temperature_2m'] as num).toDouble(),
          windSpeedKmh: (current['wind_speed_10m'] as num).toDouble(),
          weatherCode: current['weather_code'] as int,
        );
      });
    } catch (e) {
      setState(() => _error = 'Could not fetch weather: \$e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: RefreshIndicator(
        onRefresh: _fetchWeather,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (_isLoading) const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator())),
            if (_error != null) Center(child: Text(_error!, style: const TextStyle(color: Colors.red))),
            if (_reading != null) ...[
              Icon(_reading!.icon, size: 96, color: Colors.orange),
              const SizedBox(height: 16),
              Center(child: Text('\${_reading!.temperatureCelsius.toStringAsFixed(1)}°C', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold))),
              Center(child: Text(_reading!.description, style: const TextStyle(fontSize: 20))),
              const SizedBox(height: 12),
              Center(child: Text('Wind: \${_reading!.windSpeedKmh.toStringAsFixed(0)} km/h')),
            ],
          ],
        ),
      ),
    );
  }
}
''',
  );

  // ---------------------------------------------------------
  // CHAT APP — a real, working local chat UI (no backend/AI)
  // ---------------------------------------------------------
  static const _chatTemplate = MobileProjectTemplate(
    id: 'chat',
    name: 'Chat App',
    category: 'Social',
    description: 'A real working chat interface — message bubbles, input, and a scripted contact reply. No backend or AI included; students wire in real networking themselves.',
    mainDartContent: '''
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const ChatScreen(),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime sentAt;

  ChatMessage({required this.text, required this.isMe, DateTime? sentAt}) : sentAt = sentAt ?? DateTime.now();
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Hey! Welcome to your chat app template.', isMe: false),
    ChatMessage(text: 'Wire up a real backend (Firebase, Supabase, your own server) to make this send messages for real.', isMe: false),
  ];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isMe: true));
    });
    _textController.clear();

    // Scripted local reply — replace this with a real network call.
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _messages.add(ChatMessage(text: 'Got it: "\$text"', isMe: false));
      });
      _scrollToBottom();
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: message.isMe ? Colors.green.shade400 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(message.text, style: TextStyle(color: message.isMe ? Colors.white : Colors.black87)),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(hintText: 'Message...', border: OutlineInputBorder()),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
''',
  );

  // ---------------------------------------------------------
  // E-COMMERCE — a real working product catalog + cart
  // ---------------------------------------------------------
  static const _ecommerceTemplate = MobileProjectTemplate(
    id: 'ecommerce',
    name: 'E-commerce',
    category: 'Business',
    description: 'A real working shop: product grid, add-to-cart, quantity management, and total calculation.',
    mainDartContent: '''
import 'package:flutter/material.dart';

void main() {
  runApp(const ShopApp());
}

class Product {
  final String id;
  final String name;
  final double price;
  final IconData icon;

  const Product({required this.id, required this.name, required this.price, required this.icon});
}

const List<Product> kProducts = [
  Product(id: '1', name: 'Wireless Earbuds', price: 45000, icon: Icons.headphones),
  Product(id: '2', name: 'Phone Case', price: 8000, icon: Icons.phone_android),
  Product(id: '3', name: 'Power Bank', price: 22000, icon: Icons.battery_charging_full),
  Product(id: '4', name: 'USB Cable', price: 3500, icon: Icons.cable),
  Product(id: '5', name: 'Bluetooth Speaker', price: 35000, icon: Icons.speaker),
  Product(id: '6', name: 'Laptop Stand', price: 15000, icon: Icons.laptop_mac),
];

class ShopApp extends StatefulWidget {
  const ShopApp({super.key});

  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  final Map<String, int> _cart = {};

  void _addToCart(Product product) {
    setState(() => _cart[product.id] = (_cart[product.id] ?? 0) + 1);
  }

  void _removeFromCart(Product product) {
    setState(() {
      final current = _cart[product.id] ?? 0;
      if (current <= 1) {
        _cart.remove(product.id);
      } else {
        _cart[product.id] = current - 1;
      }
    });
  }

  double get _total {
    var sum = 0.0;
    _cart.forEach((id, qty) {
      final product = kProducts.firstWhere((p) => p.id == id);
      sum += product.price * qty;
    });
    return sum;
  }

  int get _itemCount => _cart.values.fold(0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shop'),
          actions: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () => _showCart(context)),
                if (_itemCount > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(radius: 8, backgroundColor: Colors.red, child: Text('\$_itemCount', style: const TextStyle(fontSize: 10, color: Colors.white))),
                  ),
              ],
            ),
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.8),
          itemCount: kProducts.length,
          itemBuilder: (context, index) {
            final product = kProducts[index];
            final qty = _cart[product.id] ?? 0;
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Icon(product.icon, size: 48, color: Colors.deepPurple),
                    const SizedBox(height: 8),
                    Text(product.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('₦\${product.price.toStringAsFixed(0)}'),
                    const Spacer(),
                    qty == 0
                        ? FilledButton(onPressed: () => _addToCart(product), child: const Text('Add'))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => _removeFromCart(product)),
                              Text('\$qty'),
                              IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => _addToCart(product)),
                            ],
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  if (_cart.isEmpty) const Text('Your cart is empty.'),
                  ..._cart.entries.map((entry) {
                    final product = kProducts.firstWhere((p) => p.id == entry.key);
                    return ListTile(title: Text(product.name), trailing: Text('x\${entry.value}  ₦\${(product.price * entry.value).toStringAsFixed(0)}'));
                  }),
                  const Divider(),
                  Text('Total: ₦\${_total.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SizedBox(width: double.infinity, child: FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Checkout (wire this up yourself!)'))),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
''',
  );

  // ---------------------------------------------------------
  // MUSIC PLAYER — real playback using audioplayers, real remote audio
  // ---------------------------------------------------------
  static const _musicPlayerTemplate = MobileProjectTemplate(
    id: 'music_player',
    name: 'Music Player',
    category: 'Media',
    description: 'A real, working music player — genuinely plays real audio via the audioplayers package, with play/pause, seek, and a progress bar.',
    extraDependencies: ['audioplayers: ^6.0.0'],
    mainDartContent: '''
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MusicPlayerApp());
}

class Track {
  final String title;
  final String artist;
  final String url;

  const Track({required this.title, required this.artist, required this.url});
}

// Free, royalty-free sample tracks — replace with your own audio files
// or a real streaming API.
const List<Track> kTracks = [
  Track(title: 'Sample Track One', artist: 'Demo Artist', url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
  Track(title: 'Sample Track Two', artist: 'Demo Artist', url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'),
];

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorSchemeSeed: Colors.pink),
      home: const PlayerScreen(),
    );
  }
}

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AudioPlayer _player = AudioPlayer();
  int _currentTrackIndex = 0;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player.onPositionChanged.listen((pos) => setState(() => _position = pos));
    _player.onDurationChanged.listen((dur) => setState(() => _duration = dur));
    _player.onPlayerComplete.listen((_) => _playNext());
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Track get _currentTrack => kTracks[_currentTrackIndex];

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(_currentTrack.url));
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  Future<void> _playNext() async {
    setState(() {
      _currentTrackIndex = (_currentTrackIndex + 1) % kTracks.length;
      _isPlaying = true;
    });
    await _player.play(UrlSource(_currentTrack.url));
  }

  Future<void> _playPrevious() async {
    setState(() {
      _currentTrackIndex = (_currentTrackIndex - 1 + kTracks.length) % kTracks.length;
      _isPlaying = true;
    });
    await _player.play(UrlSource(_currentTrack.url));
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '\$minutes:\$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(color: Colors.pink.shade900, borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.music_note, size: 100, color: Colors.white70),
            ),
            const SizedBox(height: 32),
            Text(_currentTrack.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(_currentTrack.artist, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Slider(
              value: _position.inSeconds.toDouble().clamp(0, _duration.inSeconds.toDouble() == 0 ? 1 : _duration.inSeconds.toDouble()),
              max: _duration.inSeconds.toDouble() == 0 ? 1 : _duration.inSeconds.toDouble(),
              onChanged: (value) => _player.seek(Duration(seconds: value.toInt())),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(_formatDuration(_position)), Text(_formatDuration(_duration))],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(iconSize: 40, icon: const Icon(Icons.skip_previous), onPressed: _playPrevious),
                const SizedBox(width: 16),
                IconButton(
                  iconSize: 64,
                  icon: Icon(_isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
                  onPressed: _togglePlayPause,
                ),
                const SizedBox(width: 16),
                IconButton(iconSize: 40, icon: const Icon(Icons.skip_next), onPressed: _playNext),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
''',
  );

  // ---------------------------------------------------------
  // SOCIAL MEDIA — a real working feed with likes/comments state
  // ---------------------------------------------------------
  static const _socialMediaTemplate = MobileProjectTemplate(
    id: 'social_media',
    name: 'Social Media',
    category: 'Social',
    description: 'A real working feed — posts, like toggling with a live counter, and a comments sheet, all with genuine local state.',
    mainDartContent: '''
import 'package:flutter/material.dart';

void main() {
  runApp(const SocialApp());
}

class Post {
  final String author;
  final String content;
  int likes;
  bool likedByMe;
  final List<String> comments;

  Post({required this.author, required this.content, this.likes = 0, this.likedByMe = false, List<String>? comments}) : comments = comments ?? [];
}

class SocialApp extends StatefulWidget {
  const SocialApp({super.key});

  @override
  State<SocialApp> createState() => _SocialAppState();
}

class _SocialAppState extends State<SocialApp> {
  final List<Post> _posts = [
    Post(author: 'Amaka', content: 'Just shipped my first Flutter app! 🚀', likes: 12),
    Post(author: 'Tunde', content: 'Lagos traffic is no joke today 😅', likes: 4),
    Post(author: 'Chidi', content: 'Learning Dart has been amazing so far.', likes: 8),
  ];
  final TextEditingController _newPostController = TextEditingController();

  void _toggleLike(Post post) {
    setState(() {
      post.likedByMe = !post.likedByMe;
      post.likes += post.likedByMe ? 1 : -1;
    });
  }

  void _addPost() {
    final text = _newPostController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _posts.insert(0, Post(author: 'You', content: text));
      _newPostController.clear();
    });
  }

  void _showComments(Post post) {
    final commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Comments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  if (post.comments.isEmpty) const Padding(padding: EdgeInsets.all(12), child: Text('No comments yet.')),
                  ...post.comments.map((c) => ListTile(dense: true, title: Text(c))),
                  Row(
                    children: [
                      Expanded(child: TextField(controller: commentController, decoration: const InputDecoration(hintText: 'Add a comment...'))),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (commentController.text.trim().isEmpty) return;
                          setSheetState(() => post.comments.add(commentController.text.trim()));
                          setState(() {});
                          commentController.clear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Feed')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _newPostController, decoration: const InputDecoration(hintText: "What's on your mind?", border: OutlineInputBorder()))),
                  IconButton(icon: const Icon(Icons.send), onPressed: _addPost),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.author, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(post.content),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(icon: Icon(post.likedByMe ? Icons.favorite : Icons.favorite_border, color: post.likedByMe ? Colors.red : null), onPressed: () => _toggleLike(post)),
                              Text('\${post.likes}'),
                              const SizedBox(width: 16),
                              IconButton(icon: const Icon(Icons.comment_outlined), onPressed: () => _showComments(post)),
                              Text('\${post.comments.length}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''',
  );

  // ---------------------------------------------------------
  // BANKING — a real working local accounts + transfer app
  // ---------------------------------------------------------
  static const _bankingTemplate = MobileProjectTemplate(
    id: 'banking',
    name: 'Banking',
    category: 'Business',
    description: 'A real working banking UI — account balances, a genuine transfer flow with validation, and a transaction history. Local state only — no real money moves.',
    mainDartContent: '''
import 'package:flutter/material.dart';

void main() {
  runApp(const BankingApp());
}

class Account {
  final String name;
  double balance;

  Account({required this.name, required this.balance});
}

class Transaction {
  final String description;
  final double amount;
  final DateTime date;

  Transaction({required this.description, required this.amount, DateTime? date}) : date = date ?? DateTime.now();
}

class BankingApp extends StatefulWidget {
  const BankingApp({super.key});

  @override
  State<BankingApp> createState() => _BankingAppState();
}

class _BankingAppState extends State<BankingApp> {
  final Account _account = Account(name: 'My Account', balance: 250000);
  final List<Transaction> _transactions = [];

  void _transfer(String recipient, double amount) {
    if (amount <= 0 || amount > _account.balance) return;
    setState(() {
      _account.balance -= amount;
      _transactions.insert(0, Transaction(description: 'Transfer to \$recipient', amount: -amount));
    });
  }

  void _showTransferDialog() {
    final recipientController = TextEditingController();
    final amountController = TextEditingController();
    String? error;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Transfer Money'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: recipientController, decoration: const InputDecoration(labelText: 'Recipient')),
              TextField(controller: amountController, decoration: const InputDecoration(labelText: 'Amount (₦)'), keyboardType: TextInputType.number),
              if (error != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(error!, style: const TextStyle(color: Colors.red))),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0;
                if (recipientController.text.trim().isEmpty) {
                  setDialogState(() => error = 'Enter a recipient.');
                  return;
                }
                if (amount <= 0) {
                  setDialogState(() => error = 'Enter a valid amount.');
                  return;
                }
                if (amount > _account.balance) {
                  setDialogState(() => error = 'Insufficient balance.');
                  return;
                }
                _transfer(recipientController.text.trim(), amount);
                Navigator.pop(context);
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(title: const Text('My Bank')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.indigo, Colors.deepPurple]), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_account.name, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text('₦\${_account.balance.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.send), label: const Text('Transfer'), onPressed: _showTransferDialog)),
            const SizedBox(height: 24),
            const Text('Recent Transactions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            if (_transactions.isEmpty) const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Text('No transactions yet.')),
            ..._transactions.map((t) => ListTile(
                  leading: Icon(t.amount < 0 ? Icons.arrow_upward : Icons.arrow_downward, color: t.amount < 0 ? Colors.red : Colors.green),
                  title: Text(t.description),
                  trailing: Text('₦\${t.amount.abs().toStringAsFixed(2)}'),
                )),
          ],
        ),
      ),
    );
  }
}
''',
  );

  // ---------------------------------------------------------
  // SCHOOL APP — a real working timetable + grades tracker
  // ---------------------------------------------------------
  static const _schoolTemplate = MobileProjectTemplate(
    id: 'school',
    name: 'School App',
    category: 'Education',
    description: 'A real working student app — a weekly timetable and a genuine grade tracker with an average calculation.',
    mainDartContent: '''
import 'package:flutter/material.dart';

void main() {
  runApp(const SchoolApp());
}

class Grade {
  final String subject;
  final double score;

  Grade({required this.subject, required this.score});
}

class SchoolApp extends StatefulWidget {
  const SchoolApp({super.key});

  @override
  State<SchoolApp> createState() => _SchoolAppState();
}

class _SchoolAppState extends State<SchoolApp> {
  int _tabIndex = 0;

  final Map<String, List<String>> _timetable = {
    'Monday': ['Mathematics', 'English', 'Physics'],
    'Tuesday': ['Chemistry', 'Biology', 'Mathematics'],
    'Wednesday': ['English', 'Geography', 'Physics'],
    'Thursday': ['Mathematics', 'Chemistry', 'Civic Education'],
    'Friday': ['Biology', 'English', 'Physical Education'],
  };

  final List<Grade> _grades = [
    Grade(subject: 'Mathematics', score: 82),
    Grade(subject: 'English', score: 74),
    Grade(subject: 'Physics', score: 68),
  ];

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();

  double get _average => _grades.isEmpty ? 0 : _grades.map((g) => g.score).reduce((a, b) => a + b) / _grades.length;

  void _addGrade() {
    final subject = _subjectController.text.trim();
    final score = double.tryParse(_scoreController.text);
    if (subject.isEmpty || score == null) return;
    setState(() {
      _grades.add(Grade(subject: subject, score: score));
      _subjectController.clear();
      _scoreController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: Scaffold(
        appBar: AppBar(title: const Text('School')),
        body: _tabIndex == 0 ? _buildTimetable() : _buildGrades(),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tabIndex,
          onDestinationSelected: (i) => setState(() => _tabIndex = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.schedule), label: 'Timetable'),
            NavigationDestination(icon: Icon(Icons.grade_outlined), label: 'Grades'),
          ],
        ),
      ),
    );
  }

  Widget _buildTimetable() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _timetable.entries.map((entry) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                ...entry.value.map((subject) => Text('• \$subject')),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGrades() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.teal.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              const Text('Average Score'),
              Text(_average.toStringAsFixed(1), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: _grades.map((g) => ListTile(title: Text(g.subject), trailing: Text(g.score.toStringAsFixed(0)))).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(child: TextField(controller: _subjectController, decoration: const InputDecoration(labelText: 'Subject'))),
              const SizedBox(width: 8),
              SizedBox(width: 70, child: TextField(controller: _scoreController, decoration: const InputDecoration(labelText: 'Score'), keyboardType: TextInputType.number)),
              IconButton(icon: const Icon(Icons.add), onPressed: _addGrade),
            ],
          ),
        ),
      ],
    );
  }
}
''',
  );

  // ---------------------------------------------------------
  // POS — a real working point-of-sale checkout screen
  // ---------------------------------------------------------
  static const _posTemplate = MobileProjectTemplate(
    id: 'pos',
    name: 'Point of Sale',
    category: 'Business',
    description: 'A real working POS screen — a product grid, running order total, and a genuine change-due calculation.',
    mainDartContent: '''
import 'package:flutter/material.dart';

void main() {
  runApp(const PosApp());
}

class PosItem {
  final String name;
  final double price;

  const PosItem(this.name, this.price);
}

const List<PosItem> kMenu = [
  PosItem('Jollof Rice', 1500),
  PosItem('Fried Rice', 1500),
  PosItem('Grilled Chicken', 2000),
  PosItem('Suya', 1000),
  PosItem('Chapman', 800),
  PosItem('Bottled Water', 300),
];

class PosApp extends StatefulWidget {
  const PosApp({super.key});

  @override
  State<PosApp> createState() => _PosAppState();
}

class _PosAppState extends State<PosApp> {
  final Map<String, int> _order = {};
  final TextEditingController _cashController = TextEditingController();

  void _addItem(PosItem item) {
    setState(() => _order[item.name] = (_order[item.name] ?? 0) + 1);
  }

  void _removeItem(PosItem item) {
    setState(() {
      final current = _order[item.name] ?? 0;
      if (current <= 1) {
        _order.remove(item.name);
      } else {
        _order[item.name] = current - 1;
      }
    });
  }

  double get _total {
    var sum = 0.0;
    _order.forEach((name, qty) {
      final item = kMenu.firstWhere((i) => i.name == name);
      sum += item.price * qty;
    });
    return sum;
  }

  double get _cashGiven => double.tryParse(_cashController.text) ?? 0;
  double get _change => (_cashGiven - _total).clamp(0, double.infinity);

  void _clearOrder() {
    setState(() {
      _order.clear();
      _cashController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(title: const Text('Point of Sale'), actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _clearOrder)]),
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.4),
                itemCount: kMenu.length,
                itemBuilder: (context, index) {
                  final item = kMenu[index];
                  return Card(
                    child: InkWell(
                      onTap: () => _addItem(item),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('₦\${item.price.toStringAsFixed(0)}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: _order.entries.map((entry) {
                          final item = kMenu.firstWhere((i) => i.name == entry.key);
                          return ListTile(
                            dense: true,
                            title: Text(item.name),
                            subtitle: Text('x\${entry.value}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(icon: const Icon(Icons.remove, size: 18), onPressed: () => _removeItem(item)),
                                Text('₦\${(item.price * entry.value).toStringAsFixed(0)}'),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)), Text('₦\${_total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]),
                          const SizedBox(height: 8),
                          TextField(controller: _cashController, decoration: const InputDecoration(labelText: 'Cash received (₦)', border: OutlineInputBorder()), keyboardType: TextInputType.number, onChanged: (_) => setState(() {})),
                          const SizedBox(height: 8),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Change'), Text('₦\${_change.toStringAsFixed(0)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''',
  );

  // ---------------------------------------------------------
  // INVENTORY — a real working stock tracker with low-stock alerts
  // ---------------------------------------------------------
  static const _inventoryTemplate = MobileProjectTemplate(
    id: 'inventory',
    name: 'Inventory',
    category: 'Business',
    description: 'A real working stock manager — add/remove quantity, restock, and genuine low-stock warnings.',
    mainDartContent: '''
import 'package:flutter/material.dart';

void main() {
  runApp(const InventoryApp());
}

class StockItem {
  final String name;
  int quantity;
  final int lowStockThreshold;

  StockItem({required this.name, required this.quantity, this.lowStockThreshold = 5});
}

class InventoryApp extends StatefulWidget {
  const InventoryApp({super.key});

  @override
  State<InventoryApp> createState() => _InventoryAppState();
}

class _InventoryAppState extends State<InventoryApp> {
  final List<StockItem> _items = [
    StockItem(name: 'Rice (50kg bag)', quantity: 12),
    StockItem(name: 'Cooking Oil (5L)', quantity: 3),
    StockItem(name: 'Sugar (1kg)', quantity: 20),
    StockItem(name: 'Flour (2kg)', quantity: 2),
  ];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _addStock(StockItem item, int amount) {
    setState(() => item.quantity += amount);
  }

  void _removeStock(StockItem item, int amount) {
    setState(() => item.quantity = (item.quantity - amount).clamp(0, 999999));
  }

  void _addNewItem() {
    final name = _nameController.text.trim();
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    if (name.isEmpty) return;
    setState(() {
      _items.add(StockItem(name: name, quantity: quantity));
      _nameController.clear();
      _quantityController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lowStockCount = _items.where((i) => i.quantity <= i.lowStockThreshold).length;

    return MaterialApp(
      title: 'Inventory',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.brown),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Inventory'),
          actions: [
            if (lowStockCount > 0)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Chip(label: Text('\$lowStockCount low'), backgroundColor: Colors.red.shade100, labelStyle: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final isLow = item.quantity <= item.lowStockThreshold;
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    color: isLow ? Colors.red.withOpacity(0.05) : null,
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text(isLow ? 'Low stock!' : 'In stock', style: TextStyle(color: isLow ? Colors.red : Colors.green)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => _removeStock(item, 1)),
                          Text('\${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => _addStock(item, 1)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Item name'))),
                  const SizedBox(width: 8),
                  SizedBox(width: 70, child: TextField(controller: _quantityController, decoration: const InputDecoration(labelText: 'Qty'), keyboardType: TextInputType.number)),
                  IconButton(icon: const Icon(Icons.add), onPressed: _addNewItem),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''',
  );
}

// ============================================================
// SCREENS
// ============================================================

class MobileTemplatesListScreen extends StatefulWidget {
  final MobileProjectController projectController;

  const MobileTemplatesListScreen({super.key, required this.projectController});

  @override
  State<MobileTemplatesListScreen> createState() => _MobileTemplatesListScreenState();
}

class _MobileTemplatesListScreenState extends State<MobileTemplatesListScreen> {
  String? _categoryFilter;

  List<String> get _categories => MobileTemplateRegistry.all.map((t) => t.category).toSet().toList()..sort();

  List<MobileProjectTemplate> get _filtered => _categoryFilter == null
      ? MobileTemplateRegistry.all
      : MobileTemplateRegistry.all.where((t) => t.category == _categoryFilter).toList();

  Future<void> _useTemplate(MobileProjectTemplate template) async {
    final nameController = TextEditingController(text: template.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Name your project'),
        content: TextField(controller: nameController, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;

    await widget.projectController.createProjectFromTemplate(name.trim(), template);

    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => MobileProjectExplorerScreen(projectController: widget.projectController)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project Templates')),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: const Text('All'), selected: _categoryFilter == null, onSelected: (_) => setState(() => _categoryFilter = null))),
                ..._categories.map((c) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(c), selected: _categoryFilter == c, onSelected: (_) => setState(() => _categoryFilter = c)))),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _filtered.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final template = _filtered[index];
                return Card(
                  child: ListTile(
                    title: Text(template.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(template.description),
                    trailing: FilledButton.tonal(onPressed: () => _useTemplate(template), child: const Text('Use')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
