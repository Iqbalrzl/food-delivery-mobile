import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/data/api_service.dart';
import 'package:food_delivery_mobile/data/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryProvider with ChangeNotifier {
  List<Order> _orderHistory = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Order> get orderHistory => _orderHistory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchOrderHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id');

      if (userId == null) {
        throw Exception("User ID not found");
      }

      final orders = await ApiService().fetchUserOrders(userId);
      _orderHistory = orders;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _orderHistory = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
