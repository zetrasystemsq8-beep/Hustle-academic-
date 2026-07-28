import 'package:flutter/material.dart';

class AppLesson {
  final String title;
  final String body;
  final String? codeSnippet;
  final bool hasImage;

  const AppLesson({
    required this.title,
    required this.body,
    this.codeSnippet,
    this.hasImage = false,
  });
}

class AppCourse {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String category;
  final String difficulty;
  final IconData icon;
  final Color color;
  final List<AppLesson> lessons;
  final String duration;

  const AppCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.category,
    required this.difficulty,
    required this.icon,
    required this.color,
    required this.lessons,
    required this.duration,
  });
}

class AppCategory {
  final String name;
  final IconData icon;
  final Color color;

  const AppCategory(
    this.name,
    this.icon,
    this.color,
  );
}
