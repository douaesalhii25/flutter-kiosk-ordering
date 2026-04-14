import 'package:flutter/material.dart';
import '../models/food_items.dart';

class ItemCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onTap;

  const ItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Item image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Item details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // readable on white card
                      ),
                    ),
                    Text(
                      item.category,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      '€${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF800020), // Burgundy accent for price
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart, color: Colors.green),
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
