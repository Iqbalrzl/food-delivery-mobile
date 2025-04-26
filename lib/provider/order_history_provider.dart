import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/data/model.dart';

class OrderHistoryProvider extends ChangeNotifier {
  // List yang menyimpan riwayat pesanan
  List<OrderHistory> _orderHistory = [];

  List<OrderHistory> get orderHistory => _orderHistory;

  // Fungsi untuk menambah pesanan ke dalam orderHistory
  void addOrderHistory(OrderHistory orderHistory) {
    _orderHistory.add(orderHistory);
    notifyListeners(); // Memberitahu UI untuk melakukan rebuild
  }

  // Fungsi untuk menambah data dummy
  void addDummyData() {
    final dummyProduct1 = Product(
      id: '1',
      category: 'main',
      name: 'Nasi Goreng Spesial',
      description: "Nasi goreng dengan topping ayam, telur, dan sayuran.",
      price: 25000,
      imageUrl: "assets/images/food1.jpg",
    );

    final dummyProduct2 = Product(
      id: '2',
      category: 'main',
      name: 'Mie Ayam Bakso',
      description: "Mie ayam dengan bakso dan kuah kaldu lezat.",
      price: 20000,
      imageUrl: "assets/images/food2.jpg",
    );

    final dummyOrder1 = OrderHistory(
      orderId: 'order1',
      product: dummyProduct1,
      quantity: 2,
      totalPrice: dummyProduct1.price * 2,
      orderDate: DateTime.now().subtract(
        const Duration(days: 1),
      ), // Pesanan kemarin
    );

    final dummyOrder2 = OrderHistory(
      orderId: 'order2',
      product: dummyProduct2,
      quantity: 1,
      totalPrice: dummyProduct2.price,
      orderDate: DateTime.now().subtract(
        const Duration(days: 2),
      ), // Pesanan dua hari lalu
    );

    // Menambahkan data dummy ke dalam list
    _orderHistory.addAll([dummyOrder1, dummyOrder2]);

    notifyListeners(); // Memberitahu UI untuk melakukan rebuild
  }
}
