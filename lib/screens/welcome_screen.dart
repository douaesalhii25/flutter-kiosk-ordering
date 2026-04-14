import 'package:flutter/material.dart';
import 'package:kiosk_app/services/cache_services.dart';
import 'menu_screen.dart';
import 'nearest_screen.dart';
// ignore: duplicate_import
import '../services/cache_services.dart';
import 'canvas_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? lastRestaurant;

  @override
  void initState() {
    super.initState();
    _loadLastRestaurant();
  }

  Future<void> _loadLastRestaurant() async {
    final last = await CacheService.loadRestaurant();
    if (last != null) {
      setState(() {
        lastRestaurant = last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800020), // Burgundy red
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, color: Colors.pinkAccent, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Welcome to Italiano Restaurant ",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            if (lastRestaurant != null)
              Text(
                "Last visited: $lastRestaurant",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const CanvasScreen()),
                );
              },
              child: const Text("Canvas Demo"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF800020),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const MenuScreen(category: 'Main'),
                  ),
                );
              },
              child: const Text("Enter Menu"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF800020),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const NearestScreen()),
                );
              },
              child: const Text("Nearest Italiano to me"),
            ),
          ],
        ),
      ),
    );
  }
}
