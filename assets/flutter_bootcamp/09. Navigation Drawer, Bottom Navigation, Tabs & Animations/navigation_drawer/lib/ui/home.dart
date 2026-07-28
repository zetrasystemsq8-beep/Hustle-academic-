import 'package:firebase_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
      ),
      drawer: MyAppDrawer(),

      body: Center(
        child: Text('Welcome to Home Screen!'),
      ),
    );
  }
}
