import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/food_items.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final Order order;

  const CartScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // ✅ flag red background
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Your Cart", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: order.items.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                  color: Colors.white,
                ), // ✅ empty cart text in white
              ),
            )
          : ListView.builder(
              itemCount: order.items.length,
              itemBuilder: (ctx, index) {
                final FoodItem item = order.items[index];
                return ListTile(
                  leading: Image.asset(item.imagePath, width: 50, height: 50),
                  title: Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white, // ✅ dish names in white
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '€${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white, // ✅ prices in white
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // button background
            foregroundColor: Colors.red, // text color matches flag red
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => CheckoutScreen(order: order)),
            );
          },
          child: const Text(
            "Proceed to Checkout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
