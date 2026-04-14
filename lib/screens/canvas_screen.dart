import 'package:flutter/material.dart';

class CanvasScreen extends StatelessWidget {
  const CanvasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Canvas Demo")),
      backgroundColor: const Color(0xFF800020), // Burgundy background
      body: Center(
        child: CustomPaint(size: const Size(200, 200), painter: HeartPainter()),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.fill;

    final path = Path();

    // Draw a heart shape
    path.moveTo(size.width / 2, size.height * 0.75);
    path.quadraticBezierTo(
      0,
      size.height * 0.4,
      size.width / 2,
      size.height * 0.25,
    );
    path.quadraticBezierTo(
      size.width,
      size.height * 0.4,
      size.width / 2,
      size.height * 0.75,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
