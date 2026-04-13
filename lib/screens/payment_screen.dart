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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total to pay: €${total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _showConfirmation(context, "Card"),
              child: const Text("Pay with Card"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showConfirmation(context, "Cash"),
              child: const Text("Pay with Cash"),
            ),
          ],
        ),
      ),
    );
  }
}