import 'package:flutter/material.dart';
import '../data/model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: "1",
      category: "main",
      name: "Nasi Goreng Spesial",
      description: "Nasi goreng dengan topping ayam, telur, dan sayuran.",
      imageUrl: "assets/images/food1.jpg",
      price: 25000,
    ),
    Product(
      id: "2",
      category: "main",
      name: "Mie Ayam Bakso",
      description: "Mie ayam dengan bakso dan kuah kaldu lezat.",
      imageUrl: "assets/images/food2.jpg",
      price: 20000,
    ),
    Product(
      id: "3",
      category: "dessert",
      name: "Ayam Geprek",
      description: "Ayam goreng crispy dengan sambal pedas.",
      imageUrl: "assets/images/food1.jpg",
      price: 22000,
    ),
    Product(
      id: "4",
      category: "dessert",
      name: "Sate Ayam",
      description: "Sate ayam dengan bumbu kacang khas.",
      imageUrl: "assets/images/food1.jpg",
      price: 27000,
    ),
  ];

  List<Product> get products => _products;
}
