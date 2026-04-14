import 'package:flutter/material.dart';
import 'package:kiosk_app/screens/welcome_screen.dart';

class KioskApp extends StatelessWidget {
  const KioskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Italiano Restaurant Kiosk',
      theme: ThemeData(
        primaryColor: const Color(0xFF800020), // Burgundy
        scaffoldBackgroundColor: const Color(0xFF800020),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ).copyWith(secondary: Colors.pinkAccent),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF800020),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

void main() {
  runApp(const KioskApp());
}
