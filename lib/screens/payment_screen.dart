import 'package:flutter/material.dart';
import '../models/order.dart';
import 'confirmation_screen.dart';

class PaymentScreen extends StatelessWidget {
  final double total;
  final Order? order; // make it optional so we can clear cart

  const PaymentScreen({super.key, required this.total, this.order});

  void _showConfirmation(BuildContext context, String method) {
    // Clear cart
    order?.items.clear();

    // Navigate to confirmation screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const ConfirmationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // centers vertically
          crossAxisAlignment: CrossAxisAlignment.center, // centers horizontally
          children: [
            Text(
              "Total to pay: €${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white, // adjust for burgundy background
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _showConfirmation(context, "Card"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(200, 50),
              ),
              child: const Text("Pay with Card"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showConfirmation(context, "Cash"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(200, 50),
              ),
              child: const Text("Pay with Cash"),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF800020), // burgundy background
    );
  }
}
