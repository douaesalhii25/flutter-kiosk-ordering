import 'food_items.dart';

class Order {
  final List<FoodItem> items;

  Order({required this.items});

  double get totalPrice {
    return items.fold(0, (sum, item) => sum + item.price);
  }
}