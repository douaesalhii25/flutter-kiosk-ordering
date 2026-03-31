import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ordering/models/order.dart';

class PaymentScreen extends StatelessWidget {
  final double total;

  const PaymentScreen({super.key, required this.total, required Order order});

  void _showConfirmation(BuildContext context, String method) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment successful with $method!')),
    );
    Navigator.pop(context); // return to previous screen after payment
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total to pay: €${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _showConfirmation(context, 'Card'),
              child: const Text('Pay with Card'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showConfirmation(context, 'Cash'),
              child: const Text('Pay with Cash'),
            ),
          ],
        ),
      ),
    );
  }
}