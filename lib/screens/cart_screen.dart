// lib/screens/cart_screen.dart
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
      appBar: AppBar(title: const Text("Your Cart ❤️")),
      body: order.items.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : ListView.builder(
              itemCount: order.items.length,
              itemBuilder: (ctx, index) {
                final FoodItem item = order.items[index];
                return ListTile(
                  leading: Image.asset(item.imagePath, width: 50, height: 50),
                  title: Text(item.name),
                  subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => CheckoutScreen(order: order)),
            );
          },
          child: const Text("Proceed to Checkout ❤️"),
        ),
      ),
    );
  }
}
