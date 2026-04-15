import 'package:flutter/material.dart';
import '../models/order.dart';
import 'confirmation_screen.dart';
import '../services/cache_services.dart';

class PaymentScreen extends StatelessWidget {
  final double total;
  final Order? order;

  const PaymentScreen({super.key, required this.total, this.order});

  Future<void> _showConfirmation(BuildContext context, String method) async {
    order?.items.clear();
    await CacheService.saveCartTotal(0.0);

    if (!context.mounted) return; // ✅ safe check

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const ConfirmationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Payment", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total to pay: €${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // 💳 Card payment button with icon
            ElevatedButton.icon(
              onPressed: () => _showConfirmation(context, "Card"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                minimumSize: const Size(220, 50),
              ),
              icon: const Icon(Icons.credit_card, color: Colors.red),
              label: const Text("Pay with Card"),
            ),

            const SizedBox(height: 12),

            // 💵 Cash payment button with icon
            ElevatedButton.icon(
              onPressed: () => _showConfirmation(context, "Cash"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                minimumSize: const Size(220, 50),
              ),
              icon: const Icon(Icons.attach_money, color: Colors.red),
              label: const Text("Pay with Cash"),
            ),
          ],
        ),
      ),
    );
  }
}
