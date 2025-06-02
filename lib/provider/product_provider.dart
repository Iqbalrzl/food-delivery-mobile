import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/data/api_service.dart';
import '../data/model.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> loadProducts() async {
    try {
      _products = await _apiService.fetchProducts();
      notifyListeners();
    } catch (e) {
      print('Error loading products: $e');
    }
  }
}
