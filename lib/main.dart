import 'package:flutter/material.dart';
import 'package:kiosk_app/screens/welcome_screen.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Italian Restaurant Kiosk',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const WelcomeScreen(),
    );
  }
}
