import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/food_items.dart';
import 'payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final Order order;

  const CheckoutScreen({super.key, required this.order});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final Map<String, int> quantities = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.order.items) {
      quantities[item.id] = (quantities[item.id] ?? 0) + 1;
    }
  }

  void increaseQuantity(FoodItem item) {
    setState(() {
      quantities[item.id] = (quantities[item.id] ?? 0) + 1;
    });
  }

  void decreaseQuantity(FoodItem item) {
    setState(() {
      if ((quantities[item.id] ?? 0) > 1) {
        quantities[item.id] = quantities[item.id]! - 1;
      } else {
        quantities.remove(item.id);
        widget.order.items.remove(item);
      }
    });
  }

  double get totalPrice {
    double total = 0;
    for (var item in widget.order.items) {
      total += item.price * (quantities[item.id] ?? 0);
    }
    return total;
  }

  Widget buildCategorySection(String category) {
    final items = widget.order.items
        .where((item) => item.category == category)
        .toSet()
        .toList();

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // ✅ category in white
          ),
        ),
        ...items.map((item) {
          final qty = quantities[item.id] ?? 0;
          return ListTile(
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.white),
                  onPressed: () => decreaseQuantity(item),
                ),
                Text('$qty', style: const TextStyle(color: Colors.white)),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () => increaseQuantity(item),
                ),
              ],
            ),
          );
        }),
        const Divider(color: Colors.white),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // ✅ flag red background
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildCategorySection('Main'),
                  buildCategorySection('Beverage'),
                  buildCategorySection('Dessert'),
                ],
              ),
            ),
            const Divider(color: Colors.white),
            Text(
              'Total: €${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white, // ✅ total in white
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // button background
                foregroundColor: Colors.red, // text color matches flag red
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => PaymentScreen(
                      total: totalPrice,
                      order: widget.order, // pass the order here
                    ),
                  ),
                );
              },
              child: const Text(
                'Proceed to Payment',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
