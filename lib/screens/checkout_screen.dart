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
        Text(category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...items.map((item) {
          final qty = quantities[item.id] ?? 0;
          return ListTile(
            title: Text(item.name),
            subtitle: Text('€${item.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => decreaseQuantity(item)),
                Text('$qty'),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => increaseQuantity(item)),
              ],
            ),
          );
        }),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
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
            const Divider(),
            Text(
              'Total: €${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
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
  child: const Text('Proceed to Payment'),
),
          ],
        ),
      ),
    );
  }
}