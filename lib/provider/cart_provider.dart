import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/data/api_service.dart';
import 'package:food_delivery_mobile/data/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  final ApiService _apiService = ApiService();

  List<CartItem> get items => _items;

  double get totalPrice {
    return _items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  Future<void> fetchCartItems() async {
    try {
      _items.clear();
      final fetchedItems = await _apiService.fetchCartItems();
      _items.addAll(fetchedItems);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching cart items: $e');
    }
  }

  Future<void> addToCart(Product product) async {
    int index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      final updatedQuantity = _items[index].quantity + 1;
      await _apiService.updateCartItemQuantity(
        _items[index].id,
        updatedQuantity,
      );
      _items[index].quantity = updatedQuantity;
    } else {
      await _apiService.addCartItem(product.id, product.price, 1);
      await fetchCartItems();
    }

    notifyListeners();
  }

  Future<void> updateQuantity(CartItem cartItem, int quantity) async {
    int index = _items.indexWhere((item) => item.id == cartItem.id);
    if (index >= 0) {
      if (quantity > 0) {
        await _apiService.updateCartItemQuantity(cartItem.id, quantity);
        _items[index].quantity = quantity;
      } else {
        await removeFromCart(cartItem);
      }
      notifyListeners();
    }
  }

  Future<void> removeFromCart(CartItem cartItem) async {
    try {
      await _apiService.deleteCartItem(cartItem.id);
      _items.removeWhere((item) => item.id == cartItem.id);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to delete cart item: $e');
    }
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId != null) {
      await _apiService.clearCart(userId);
      _items.clear();
      notifyListeners();
    }
  }

  Future<bool> checkout() async {
    final success = await ApiService().checkoutCart();
    if (success) {
      _items.clear();
      notifyListeners();
    }
    return success;
  }
}
