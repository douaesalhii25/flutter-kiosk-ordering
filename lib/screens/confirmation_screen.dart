import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // ✅ flag red background
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Order Confirmed",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Canvas checkmark
            SizedBox(
              width: 100,
              height: 100,
              child: CustomPaint(painter: CheckMarkPainter()),
            ),
            const SizedBox(height: 20),
            const Text(
              "Thank you!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white, // ✅ text in white
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your order has been placed successfully.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // ✅ text in white
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // button background
                foregroundColor: Colors.red, // ✅ text in flag red
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                // Go back to menu
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text(
                "Back to Main Page",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Custom painter for checkmark
class CheckMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final paintCheck = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // Draw circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 6,
      paintCircle,
    );

    // Draw checkmark
    final path = Path();
    path.moveTo(size.width * 0.28, size.height * 0.55);
    path.lineTo(size.width * 0.45, size.height * 0.72);
    path.lineTo(size.width * 0.75, size.height * 0.35);
    canvas.drawPath(path, paintCheck);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
