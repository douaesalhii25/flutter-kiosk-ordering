import 'package:flutter/material.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Canvas Demo")),
      backgroundColor: const Color(0xFF800020),
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: CustomPaint(
            size: const Size(200, 200),
            painter: HeartPainter(),
          ),
        ),
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
