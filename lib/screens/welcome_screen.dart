import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'nearest_screen.dart';
import 'package:kiosk_app/services/cache_services.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  String? lastRestaurant;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _loadLastRestaurant();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadLastRestaurant() async {
    final last = await CacheService.loadRestaurant();
    if (!mounted) return;
    if (last != null) {
      setState(() {
        lastRestaurant = last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // ✅ everything centered vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Italian flag canvas at the top
            SizedBox(
              height: 120,
              width: double.infinity,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ItalianFlagPainter(_controller.value),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Fancy welcome text
            Text(
              "Welcome to Italiano Restaurant",
              style: GoogleFonts.dancingScript(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Wine glasses farther apart
            SizedBox(
              height: 150,
              width: double.infinity,
              child: CustomPaint(painter: WineGlassesPainter()),
            ),
            const SizedBox(height: 20),

            if (lastRestaurant != null)
              Text(
                "Last visited: $lastRestaurant",
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            const SizedBox(height: 30),

            // Buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
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
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
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

// Italian flag painter
class ItalianFlagPainter extends CustomPainter {
  final double wave;
  ItalianFlagPainter(this.wave);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final width = size.width;
    final height = size.height;

    paint.color = Colors.green;
    canvas.drawRect(Rect.fromLTWH(0, wave * 10, width / 3, height), paint);

    paint.color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(width / 3, -wave * 10, width / 3, height),
      paint,
    );

    paint.color = Colors.red;
    canvas.drawRect(
      Rect.fromLTWH(2 * width / 3, wave * 10, width / 3, height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant ItalianFlagPainter oldDelegate) =>
      oldDelegate.wave != wave;
}

// Wine glasses painter (farther apart)
class WineGlassesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Left glass
    canvas.drawOval(Rect.fromLTWH(40, 20, 40, 60), paint);
    canvas.drawLine(const Offset(60, 80), const Offset(60, 120), paint);
    canvas.drawLine(const Offset(45, 120), const Offset(75, 120), paint);

    // Right glass farther away
    canvas.drawOval(Rect.fromLTWH(size.width - 80, 20, 40, 60), paint);
    canvas.drawLine(
      Offset(size.width - 60, 80),
      Offset(size.width - 60, 120),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - 75, 120),
      Offset(size.width - 45, 120),
      paint,
    );

    // Cheers line
    canvas.drawLine(const Offset(80, 40), Offset(size.width - 80, 40), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
