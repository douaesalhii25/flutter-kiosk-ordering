import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  // Save cart total
  static Future<void> saveCartTotal(double total) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('cart_total', total);
  }

  // Load cart total
  static Future<double?> loadCartTotal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('cart_total');
  }

  // Save last restaurant name
  static Future<void> saveRestaurant(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_restaurant', name);
  }

  // Load last restaurant name
  static Future<String?> loadRestaurant() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_restaurant');
  }
}
