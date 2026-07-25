import 'package:flutter/material.dart';

void main() {
  runApp(const HustleAcademyApp());
}

class HustleAcademyApp extends StatelessWidget {
  const HustleAcademyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hustle Academy',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hustle Academy'),
        ),
        body: const Center(
          child: Text(
            'Welcome to Hustle Academy',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
