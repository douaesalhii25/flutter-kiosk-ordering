//test push - Douae March 31
import 'package:flutter/material.dart';
import '../models/food_items.dart';
import '../models/order.dart';
import '../widgets/item_card.dart';
import 'checkout_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<FoodItem> items = [
    // Main Dishes
    FoodItem(id: '1', name: 'Margherita Pizza', price: 8.0, category: 'Main', imagePath: 'assets/images/Margherita-pizza.jpg'),
    FoodItem(id: '2', name: 'Spaghetti Carbonara', price: 10.0, category: 'Main', imagePath: 'assets/images/Spaghetti-Carbonara.jpg'),
    FoodItem(id: '3', name: 'Lasagna', price: 11.0, category: 'Main', imagePath: 'assets/images/Lasagna.jpg'),
    FoodItem(id: '4', name: 'Risotto alla Milanese', price: 12.0, category: 'Main', imagePath: 'assets/images/Risotto-alla-Milanese.jpg'),
    FoodItem(id: '5', name: 'Fettuccine Alfredo', price: 9.0, category: 'Main', imagePath: 'assets/images/Fettuccine-Alfredo.jpg'),
    FoodItem(id: '6', name: 'Penne Arrabbiata', price: 9.0, category: 'Main', imagePath: 'assets/images/Penne-Arrabbiata.jpg'),
    FoodItem(id: '7', name: 'Gnocchi Sorrentina', price: 10.0, category: 'Main', imagePath: 'assets/images/Gnocchi-Sorrentina.jpg'),
    FoodItem(id: '8', name: 'Osso Buco', price: 18.0, category: 'Main', imagePath: 'assets/images/Osso-Buco.jpg'),
    FoodItem(id: '9', name: 'Eggplant Parmigiana', price: 10.0, category: 'Main', imagePath: 'assets/images/Eggplant-Parmigiana.jpg'),

    // Beverages
    FoodItem(id: '10', name: 'Espresso', price: 2.0, category: 'Beverage', imagePath: 'assets/images/Espresso.jpg'),
    FoodItem(id: '11', name: 'Cappuccino', price: 3.0, category: 'Beverage', imagePath: 'assets/images/Cappuccino.jpg'),
    FoodItem(id: '12', name: 'Italian Soda', price: 4.0, category: 'Beverage', imagePath: 'assets/images/Italian-Soda.jpg'),
    FoodItem(id: '13', name: 'Red Wine (Chianti)', price: 6.0, category: 'Beverage', imagePath: 'assets/images/Red-Wine-Chianti.jpg'),

    // Desserts
    FoodItem(id: '14', name: 'Tiramisu', price: 5.0, category: 'Dessert', imagePath: 'assets/images/Tiramisu.jpg'),
    FoodItem(id: '15', name: 'Cannoli', price: 4.0, category: 'Dessert', imagePath: 'assets/images/Cannoli.jpg'),
    FoodItem(id: '16', name: 'Panna Cotta', price: 5.0, category: 'Dessert', imagePath: 'assets/images/Panna-Cotta.jpg'),
    FoodItem(id: '17', name: 'Gelato', price: 3.0, category: 'Dessert', imagePath: 'assets/images/Gelato.jpg'),
    FoodItem(id: '18', name: 'Sfogliatella', price: 4.0, category: 'Dessert', imagePath: 'assets/images/Sfogliatella.jpg'),
    FoodItem(id: '19', name: 'Zeppole', price: 4.0, category: 'Dessert', imagePath: 'assets/images/Zeppole.jpg'),
  ];

  final Order order = Order(items: []);

  void addToCart(FoodItem item) {
    setState(() {
      order.items.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} added to cart!')),
    );
  }

  void goToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => CheckoutScreen(order: order)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Italian Menu'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: goToCheckout,
              ),
              if (order.items.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${order.items.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          final item = items[index];
          return ItemCard(
            item: item,
            onTap: () => addToCart(item),
          );
        },
      ),
    );
  }
}