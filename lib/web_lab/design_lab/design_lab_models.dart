import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// A reusable HTML+CSS component a student built and saved from the
/// Component Workshop — a button, card, form, navbar, or dashboard piece
/// they can insert into any future project without rebuilding it from
/// scratch. Stored independently of any single project, since a
/// personal library is meant to follow the student across projects.
class SavedComponent {
  final String id;
  String name;
  String category;
  String html;
  String css;
  final DateTime createdAt;

  SavedComponent({
    required this.id,
    required this.name,
    required this.category,
    required this.html,
    required this.css,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'html': html,
        'css': css,
        'createdAt': createdAt.toIso8601String(),
      };

  factory SavedComponent.fromJson(Map<String, dynamic> json) {
    return SavedComponent(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      html: json['html'] as String,
      css: json['css'] as String,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}

/// A ready-to-edit starting point shown in the Component Workshop's
/// browser — an educational skeleton, not a finished design, so the
/// student still has real work to do styling and extending it.
class ComponentStarter {
  final String name;
  final String category;
  final String html;
  final String css;

  const ComponentStarter({
    required this.name,
    required this.category,
    required this.html,
    required this.css,
  });
}

/// Curated starter skeletons for the Component Workshop. Deliberately
/// minimal — enough structure to be useful, not so much that there's
/// nothing left for the student to build.
class ComponentStarterLibrary {
  ComponentStarterLibrary._();

  static const List<ComponentStarter> all = [
    ComponentStarter(
      name: 'Button',
      category: 'Buttons',
      html: '<button class="my-button">Click me</button>',
      css: '.my-button {\n  padding: 10px 20px;\n  border: none;\n  border-radius: 6px;\n  cursor: pointer;\n}\n',
    ),
    ComponentStarter(
      name: 'Card',
      category: 'Cards',
      html: '<div class="my-card">\n  <h3>Card title</h3>\n  <p>Card description goes here.</p>\n</div>',
      css: '.my-card {\n  padding: 16px;\n  border-radius: 10px;\n  box-shadow: 0 2px 8px rgba(0,0,0,0.1);\n}\n',
    ),
    ComponentStarter(
      name: 'Form',
      category: 'Forms',
      html: '<form class="my-form">\n  <label for="email">Email</label>\n  <input type="email" id="email" name="email">\n  <button type="submit">Submit</button>\n</form>',
      css: '.my-form {\n  display: flex;\n  flex-direction: column;\n  gap: 8px;\n  max-width: 300px;\n}\n',
    ),
    ComponentStarter(
      name: 'Navbar',
      category: 'Navigation',
      html: '<nav class="my-navbar">\n  <span class="brand">Brand</span>\n  <a href="#">Home</a>\n  <a href="#">About</a>\n  <a href="#">Contact</a>\n</nav>',
      css: '.my-navbar {\n  display: flex;\n  align-items: center;\n  gap: 16px;\n  padding: 12px 20px;\n}\n',
    ),
    ComponentStarter(
      name: 'Dashboard panel',
      category: 'Dashboards',
      html: '<div class="my-panel">\n  <div class="my-panel-label">Total Users</div>\n  <div class="my-panel-value">1,204</div>\n</div>',
      css: '.my-panel {\n  padding: 16px;\n  border-radius: 8px;\n}\n.my-panel-label {\n  font-size: 12px;\n  opacity: 0.7;\n}\n.my-panel-value {\n  font-size: 28px;\n  font-weight: bold;\n}\n',
    ),
  ];
}

/// Persists the student's saved component library across app sessions,
/// independent of any single project's storage.
class ComponentLibraryRepository {
  static const String _storageKey = 'web_lab.component_library';

  Future<List<SavedComponent>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => SavedComponent.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<SavedComponent> components) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(components.map((c) => c.toJson()).toList()));
  }
}
