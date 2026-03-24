 import 'package:flutter/material.dart';
import '../models/food_items.dart';

class ItemCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onTap;

  const ItemCard({Key? key, required this.item, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: name + category
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  item.category,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            // Right side: price + cart icon
            Row(
              children: [
                Text(
                  '€${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart, color: Colors.green),
                  onPressed: onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}