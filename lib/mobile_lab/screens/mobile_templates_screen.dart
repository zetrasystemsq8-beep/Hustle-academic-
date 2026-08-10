import 'package:flutter/material.dart';
import 'mobile_editor_screen.dart';

// ============================================================
// MOBILE APP TEMPLATES — 10 real, working starter apps. Each
// compiles standalone with only material.dart — no extra
// packages, no API keys required. Selecting one seeds a new
// project's file tree instead of the blank counter starter.
// ============================================================

class MobileAppTemplate {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final String Function(String projectName) mainDartBuilder;

  const MobileAppTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.mainDartBuilder,
  });
}

class MobileAppTemplates {
  static List<MobileAppTemplate> get all => [
        blankCounter,
        todoList,
        notesApp,
        calculator,
        bmiCalculator,
        quizApp,
        expenseTracker,
        recipeBrowser,
        loginUi,
        chatUi,
      ];

  static String _pubspecFor(String packageName) => '''name: $packageName
description: A new Flutter project built in Mobile Lab.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  flutter_launcher_icons: ^0.14.1

flutter:
  uses-material-design: true
  assets:
    - assets/icon.png

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon.png"
''';

  static MobileFileNode buildProjectTree(MobileAppTemplate template, String projectName) {
    final fileSystem = MobileFileSystemService();
    final packageName = projectName.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9_]'), '_');

    final root = MobileFileNode(
      id: fileSystem.generateId(),
      name: projectName,
      type: MobileFileNodeType.folder,
      isExpanded: true,
    );

    final libFolder = MobileFileNode(
      id: fileSystem.generateId(),
      name: 'lib',
      type: MobileFileNodeType.folder,
      isExpanded: true,
    );
    libFolder.children.add(MobileFileNode(
      id: fileSystem.generateId(),
      name: 'main.dart',
      type: MobileFileNodeType.file,
      content: template.mainDartBuilder(projectName),
    ));
    root.children.add(libFolder);

    root.children.add(MobileFileNode(
      id: fileSystem.generateId(),
      name: 'pubspec.yaml',
      type: MobileFileNodeType.file,
      content: _pubspecFor(packageName),
    ));

    return root;
  }

  // ---------------- TEMPLATE 1: Counter ----------------
  static final blankCounter = MobileAppTemplate(
    id: 'blank_counter',
    name: 'Blank Counter',
    description: 'The classic Flutter starter — a button and a counter.',
    icon: Icons.exposure_plus_1,
    color: Colors.indigo,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  void _increment() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text('\$_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _increment, child: const Icon(Icons.add)),
    );
  }
}
''',
  );

  // ---------------- TEMPLATE 2: Todo List ----------------
  static final todoList = MobileAppTemplate(
    id: 'todo_list',
    name: 'Todo List',
    description: 'Add, complete, and delete tasks.',
    icon: Icons.checklist,
    color: Colors.teal,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const TodoPage(),
    );
  }
}

class Todo {
  String title;
  bool done;
  Todo(this.title, {this.done = false});
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Todo> _todos = [];
  final _controller = TextEditingController();

  void _add() {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _todos.add(Todo(_controller.text.trim())));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(hintText: 'New task', border: OutlineInputBorder()))),
                const SizedBox(width: 8),
                FilledButton(onPressed: _add, child: const Text('Add')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, i) {
                final todo = _todos[i];
                return CheckboxListTile(
                  value: todo.done,
                  onChanged: (v) => setState(() => todo.done = v ?? false),
                  title: Text(todo.title, style: TextDecoration.lineThrough == null ? null : TextStyle(decoration: todo.done ? TextDecoration.lineThrough : null)),
                  secondary: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => setState(() => _todos.removeAt(i))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
''',
  );

  // ---------------- TEMPLATE 3: Notes App ----------------
  static final notesApp = MobileAppTemplate(
    id: 'notes_app',
    name: 'Notes App',
    description: 'Create and delete simple text notes.',
    icon: Icons.sticky_note_2_outlined,
    color: Colors.amber,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: const NotesPage(),
    );
  }
}

class Note {
  String title;
  String body;
  Note(this.title, this.body);
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> _notes = [];

  Future<void> _addNote() async {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Note'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
          TextField(controller: bodyController, decoration: const InputDecoration(labelText: 'Note'), maxLines: 3),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
        ],
      ),
    );
    if (result == true && titleController.text.trim().isNotEmpty) {
      setState(() => _notes.add(Note(titleController.text.trim(), bodyController.text.trim())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      floatingActionButton: FloatingActionButton(onPressed: _addNote, child: const Icon(Icons.add)),
      body: _notes.isEmpty
          ? const Center(child: Text('No notes yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _notes.length,
              itemBuilder: (context, i) => Card(
                child: ListTile(
                  title: Text(_notes[i].title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(_notes[i].body),
                  trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => setState(() => _notes.removeAt(i))),
                ),
              ),
            ),
    );
  }
}
''',
  );

  // ---------------- TEMPLATE 4: Calculator ----------------
  static final calculator = MobileAppTemplate(
    id: 'calculator',
    name: 'Calculator',
    description: 'A working four-function calculator.',
    icon: Icons.calculate_outlined,
    color: Colors.deepOrange,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  double? _first;
  String? _op;

  void _tap(String key) {
    setState(() {
      if (key == 'C') {
        _display = '0';
        _first = null;
        _op = null;
      } else if ('+-x÷'.contains(key)) {
        _first = double.tryParse(_display);
        _op = key;
        _display = '0';
      } else if (key == '=') {
        final second = double.tryParse(_display) ?? 0;
        final first = _first ?? 0;
        double result;
        switch (_op) {
          case '+': result = first + second; break;
          case '-': result = first - second; break;
          case 'x': result = first * second; break;
          case '÷': result = second == 0 ? 0 : first / second; break;
          default: result = second;
        }
        _display = result.toString();
        _first = null;
        _op = null;
      } else {
        _display = _display == '0' ? key : _display + key;
      }
    });
  }

  Widget _btn(String label) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ElevatedButton(onPressed: () => _tap(label), child: Text(label, style: const TextStyle(fontSize: 20))),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['7', '8', '9', '÷'],
      ['4', '5', '6', 'x'],
      ['1', '2', '3', '-'],
      ['C', '0', '=', '+'],
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(_display, style: const TextStyle(fontSize: 48)),
            ),
          ),
          for (final row in rows) Row(children: [for (final key in row) _btn(key)]),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
''',
  );

  // ---------------- TEMPLATE 5: BMI Calculator ----------------
  static final bmiCalculator = MobileAppTemplate(
    id: 'bmi_calculator',
    name: 'BMI Calculator',
    description: 'Sliders for height and weight, computes BMI live.',
    icon: Icons.monitor_weight_outlined,
    color: Colors.green,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const BmiPage(),
    );
  }
}

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});
  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  double _heightCm = 170;
  double _weightKg = 65;

  double get _bmi {
    final heightM = _heightCm / 100;
    return _weightKg / (heightM * heightM);
  }

  String get _category {
    final b = _bmi;
    if (b < 18.5) return 'Underweight';
    if (b < 25) return 'Normal';
    if (b < 30) return 'Overweight';
    return 'Obese';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(_bmi.toStringAsFixed(1), style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold)),
            Text(_category, style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 32),
            Text('Height: \${_heightCm.round()} cm'),
            Slider(value: _heightCm, min: 100, max: 220, onChanged: (v) => setState(() => _heightCm = v)),
            Text('Weight: \${_weightKg.round()} kg'),
            Slider(value: _weightKg, min: 30, max: 150, onChanged: (v) => setState(() => _weightKg = v)),
          ],
        ),
      ),
    );
  }
}
''',
  );

  // ---------------- TEMPLATE 6: Quiz App ----------------
  static final quizApp = MobileAppTemplate(
    id: 'quiz_app',
    name: 'Quiz App',
    description: 'Multiple-choice quiz with a running score.',
    icon: Icons.quiz_outlined,
    color: Colors.purple,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: const QuizPage(),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  const Question(this.text, this.options, this.correctIndex);
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> _questions = const [
    Question('What language is Flutter built with?', ['Dart', 'Java', 'Swift', 'Kotlin'], 0),
    Question('Which widget makes a screen scrollable?', ['Container', 'ListView', 'Text', 'Icon'], 1),
    Question('What does setState() do?', ['Deletes state', 'Rebuilds the widget', 'Nothing', 'Closes the app'], 1),
  ];
  int _index = 0;
  int _score = 0;

  void _answer(int selected) {
    if (selected == _questions[_index].correctIndex) _score++;
    setState(() {
      if (_index < _questions.length - 1) {
        _index++;
      } else {
        _index = -1; // finished
      }
    });
  }

  void _restart() => setState(() {
        _index = 0;
        _score = 0;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _index == -1
            ? Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Score: \$_score / \${_questions.length}', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 16),
                  FilledButton(onPressed: _restart, child: const Text('Restart')),
                ]),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question \${_index + 1} of \${_questions.length}', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(_questions[_index].text, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 24),
                  for (int i = 0; i < _questions[_index].options.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(onPressed: () => _answer(i), child: Text(_questions[_index].options[i])),
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

  // ---------------- TEMPLATE 7: Expense Tracker ----------------
  static final expenseTracker = MobileAppTemplate(
    id: 'expense_tracker',
    name: 'Expense Tracker',
    description: 'Log expenses by category, see the running total.',
    icon: Icons.receipt_long_outlined,
    color: Colors.redAccent,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.redAccent),
      home: const ExpensesPage(),
    );
  }
}

class Expense {
  final String label;
  final double amount;
  Expense(this.label, this.amount);
}

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});
  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final List<Expense> _expenses = [];
  final _labelController = TextEditingController();
  final _amountController = TextEditingController();

  double get _total => _expenses.fold(0, (sum, e) => sum + e.amount);

  void _add() {
    final label = _labelController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());
    if (label.isEmpty || amount == null) return;
    setState(() => _expenses.add(Expense(label, amount)));
    _labelController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.all(20),
            child: Text('Total: \\\$\${_total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(flex: 2, child: TextField(controller: _labelController, decoration: const InputDecoration(hintText: 'Label', border: OutlineInputBorder()))),
                const SizedBox(width: 8),
                Expanded(child: TextField(controller: _amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: 'Amount', border: OutlineInputBorder()))),
                IconButton(onPressed: _add, icon: const Icon(Icons.add_circle), iconSize: 32),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(_expenses[i].label),
                trailing: Text('\\\$\${_expenses[i].amount.toStringAsFixed(2)}'),
                leading: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => setState(() => _expenses.removeAt(i))),
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

  // ---------------- TEMPLATE 8: Recipe Browser ----------------
  static final recipeBrowser = MobileAppTemplate(
    id: 'recipe_browser',
    name: 'Recipe Browser',
    description: 'Browse a list of recipes and view details.',
    icon: Icons.restaurant_menu,
    color: Colors.brown,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.brown),
      home: const RecipeListPage(),
    );
  }
}

class Recipe {
  final String title;
  final String emoji;
  final List<String> ingredients;
  const Recipe(this.title, this.emoji, this.ingredients);
}

const _recipes = [
  Recipe('Pancakes', '🥞', ['Flour', 'Milk', 'Eggs', 'Sugar', 'Butter']),
  Recipe('Jollof Rice', '🍚', ['Rice', 'Tomato', 'Pepper', 'Onion', 'Spices']),
  Recipe('Grilled Chicken', '🍗', ['Chicken', 'Garlic', 'Lemon', 'Herbs']),
];

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, i) {
          final r = _recipes[i];
          return ListTile(
            leading: Text(r.emoji, style: const TextStyle(fontSize: 28)),
            title: Text(r.title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailPage(recipe: r))),
          );
        },
      ),
    );
  }
}

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe.emoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            for (final i in recipe.ingredients) Text('• \$i'),
          ],
        ),
      ),
    );
  }
}
''',
  );

  // ---------------- TEMPLATE 9: Login UI ----------------
  static final loginUi = MobileAppTemplate(
    id: 'login_ui',
    name: 'Login UI',
    description: 'A styled login screen — UI only, no backend.',
    icon: Icons.login,
    color: Colors.blueGrey,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 96, color: Colors.blueGrey),
              const SizedBox(height: 16),
              Text('Welcome to $name', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline), border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                controller: _password,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscure = !_obscure)),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(onPressed: () {}, child: const Text('Log In')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''',
  );

  // ---------------- TEMPLATE 10: Chat UI ----------------
  static final chatUi = MobileAppTemplate(
    id: 'chat_ui',
    name: 'Chat UI',
    description: 'A local chat screen with message bubbles.',
    icon: Icons.chat_bubble_outline,
    color: Colors.cyan,
    mainDartBuilder: (name) => '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$name',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.cyan),
      home: const ChatPage(),
    );
  }
}

class Message {
  final String text;
  final bool fromMe;
  Message(this.text, this.fromMe);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [
    Message('Hey! Welcome to $name 👋', false),
  ];
  final _controller = TextEditingController();

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _messages.add(Message(_controller.text.trim(), true)));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$name')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                return Align(
                  alignment: m.fromMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: m.fromMe ? Colors.cyan : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(m.text, style: TextStyle(color: m.fromMe ? Colors.white : Colors.black)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(hintText: 'Message...', border: OutlineInputBorder()))),
                IconButton(icon: const Icon(Icons.send), onPressed: _send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
''',
  );
}

// ============================================================
// TEMPLATE PICKER SCREEN
// ============================================================

class MobileTemplatePickerScreen extends StatefulWidget {
  final MobileProjectController projectController;

  const MobileTemplatePickerScreen({required this.projectController, Key? key}) : super(key: key);

  @override
  State<MobileTemplatePickerScreen> createState() => _MobileTemplatePickerScreenState();
}

class _MobileTemplatePickerScreenState extends State<MobileTemplatePickerScreen> {
  Future<void> _selectTemplate(MobileAppTemplate template) async {
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

    await widget.projectController.createProject(
      name.trim(),
      treeBuilder: (projectName) => MobileAppTemplates.buildProjectTree(template, projectName),
    );

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MobileProjectExplorerScreen(projectController: widget.projectController)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a Template')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.95,
        ),
        itemCount: MobileAppTemplates.all.length,
        itemBuilder: (context, i) {
          final t = MobileAppTemplates.all[i];
          return GestureDetector(
            onTap: () => _selectTemplate(t),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: t.color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: t.color.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(t.icon, color: t.color, size: 32),
                  const SizedBox(height: 12),
                  Text(t.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(t.description, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
