import 'package:flutter/material.dart';
import '../editor/syntax_highlighter.dart';

/// A single reference entry: a syntax term paired with a plain-language
/// explanation of what it does. Deliberately generic — never tied to a
/// specific challenge or task, so this never functions as an answer key.
class ReferenceEntry {
  final String term;
  final String explanation;
  final String example;

  const ReferenceEntry({
    required this.term,
    required this.explanation,
    required this.example,
  });
}

/// A collapsible glossary of common HTML, CSS, and JavaScript syntax,
/// shown alongside the Code Editor so students can look up what a tag,
/// property, or keyword means without leaving the editor. Content is
/// static reference material — general language syntax, never a
/// solution to any specific challenge.
class QuickReferencePanel extends StatelessWidget {
  final EditorLanguage language;

  const QuickReferencePanel({super.key, required this.language});

  static const List<ReferenceEntry> _htmlEntries = [
    ReferenceEntry(term: '<h1> – <h6>', explanation: 'Headings, from largest (h1) to smallest (h6). Use one h1 per page.', example: '<h1>Page Title</h1>'),
    ReferenceEntry(term: '<p>', explanation: 'A paragraph of text.', example: '<p>Some text.</p>'),
    ReferenceEntry(term: '<div>', explanation: 'A generic block container, used to group other elements together for styling or layout.', example: '<div class="box">...</div>'),
    ReferenceEntry(term: '<span>', explanation: 'A generic inline container, used to style a small piece of text without breaking the line.', example: '<span>highlighted</span>'),
    ReferenceEntry(term: '<a href="">', explanation: 'A link to another page or section. The href attribute sets the destination.', example: '<a href="https://example.com">Visit</a>'),
    ReferenceEntry(term: '<img src="" alt="">', explanation: 'Displays an image. src is the file path, alt is a text description.', example: '<img src="cat.png" alt="A cat">'),
    ReferenceEntry(term: '<ul> / <li>', explanation: 'An unordered (bulleted) list, made of list items.', example: '<ul><li>Item</li></ul>'),
    ReferenceEntry(term: '<button>', explanation: 'A clickable button. Combine with JavaScript to make it do something.', example: '<button onclick="doThing()">Click</button>'),
    ReferenceEntry(term: '<form> / <input>', explanation: 'A form collects user input. Each field is an <input> inside the <form>.', example: '<form><input type="text"></form>'),
    ReferenceEntry(term: 'class=""', explanation: 'Attaches a reusable name to an element so CSS can style every element with that class the same way.', example: '<div class="card">'),
    ReferenceEntry(term: 'id=""', explanation: 'Attaches a unique name to one specific element, for CSS or JavaScript to target just that one.', example: '<div id="main">'),
  ];

  static const List<ReferenceEntry> _cssEntries = [
    ReferenceEntry(term: 'color', explanation: 'Sets the text color.', example: 'color: blue;'),
    ReferenceEntry(term: 'background-color', explanation: 'Sets the background color of an element.', example: 'background-color: #f0f0f0;'),
    ReferenceEntry(term: 'display', explanation: 'Controls how an element is laid out. flex arranges children in a row/column; block stacks; none hides it.', example: 'display: flex;'),
    ReferenceEntry(term: 'justify-content', explanation: 'With display: flex, controls horizontal alignment of children (e.g. center, space-between).', example: 'justify-content: center;'),
    ReferenceEntry(term: 'align-items', explanation: 'With display: flex, controls vertical alignment of children.', example: 'align-items: center;'),
    ReferenceEntry(term: 'margin', explanation: 'Space outside an element\'s border, pushing other elements away.', example: 'margin: 16px;'),
    ReferenceEntry(term: 'padding', explanation: 'Space inside an element\'s border, between the border and its content.', example: 'padding: 12px;'),
    ReferenceEntry(term: 'font-size', explanation: 'Sets the size of text.', example: 'font-size: 18px;'),
    ReferenceEntry(term: 'border-radius', explanation: 'Rounds the corners of an element.', example: 'border-radius: 8px;'),
    ReferenceEntry(term: 'width / height', explanation: 'Sets the size of an element.', example: 'width: 200px; height: 100px;'),
    ReferenceEntry(term: '.class-name { }', explanation: 'Styles every element with that class attribute.', example: '.card { padding: 12px; }'),
    ReferenceEntry(term: '#id-name { }', explanation: 'Styles the one element with that id attribute.', example: '#main { margin: 0; }'),
  ];

  static const List<ReferenceEntry> _jsEntries = [
    ReferenceEntry(term: 'let / const', explanation: 'Declares a variable. Use const if the value never changes, let if it will.', example: 'let score = 0;'),
    ReferenceEntry(term: 'function', explanation: 'Defines a reusable block of code you can run by calling its name.', example: 'function greet() { console.log("hi"); }'),
    ReferenceEntry(term: 'console.log()', explanation: 'Prints a value to the Console panel, useful for checking what your code is doing.', example: 'console.log(score);'),
    ReferenceEntry(term: 'if / else', explanation: 'Runs one block of code if a condition is true, otherwise runs the else block.', example: 'if (score > 0) { ... } else { ... }'),
    ReferenceEntry(term: 'document.getElementById()', explanation: 'Finds an HTML element by its id attribute so JavaScript can read or change it.', example: 'document.getElementById("main")'),
    ReferenceEntry(term: 'document.querySelector()', explanation: 'Finds the first HTML element matching a CSS-style selector.', example: 'document.querySelector(".card")'),
    ReferenceEntry(term: 'addEventListener()', explanation: 'Runs a function whenever something happens, like a click.', example: 'button.addEventListener("click", doThing);'),
    ReferenceEntry(term: '.innerText / .textContent', explanation: 'Reads or changes the visible text inside an element.', example: 'element.innerText = "Hello";'),
    ReferenceEntry(term: '.style.property', explanation: 'Changes a CSS property on an element directly from JavaScript.', example: 'element.style.color = "red";'),
    ReferenceEntry(term: 'for loop', explanation: 'Repeats a block of code a set number of times.', example: 'for (let i = 0; i < 5; i++) { ... }'),
  ];

  List<ReferenceEntry> get _entriesForLanguage {
    switch (language) {
      case EditorLanguage.html:
        return _htmlEntries;
      case EditorLanguage.css:
        return _cssEntries;
      case EditorLanguage.javascript:
        return _jsEntries;
      case EditorLanguage.plain:
        return const [];
    }
  }

  String get _title {
    switch (language) {
      case EditorLanguage.html:
        return 'HTML Quick Reference';
      case EditorLanguage.css:
        return 'CSS Quick Reference';
      case EditorLanguage.javascript:
        return 'JavaScript Quick Reference';
      case EditorLanguage.plain:
        return 'Quick Reference';
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = _entriesForLanguage;
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(2))),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.menu_book_outlined),
                    const SizedBox(width: 8),
                    Text(_title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: entries.isEmpty
                    ? const Center(child: Text('No reference available for this file type.'))
                    : ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: entries.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final entry = entries[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry.term, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 4),
                                Text(entry.explanation, style: theme.textTheme.bodyMedium),
                                const SizedBox(height: 6),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    entry.example,
                                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFF9CDCFE)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Shows the panel as a modal bottom sheet, scoped to [language].
  static void show(BuildContext context, EditorLanguage language) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickReferencePanel(language: language),
    );
  }
}
