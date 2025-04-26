import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/provider/order_history_provider.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Memanggil addDummyData untuk menambahkan data dummy ketika halaman pertama kali dimuat
    Future.delayed(Duration.zero, () {
      // ignore: use_build_context_synchronously
      Provider.of<OrderHistoryProvider>(context, listen: false).addDummyData();
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Order History")),
      body: Consumer<OrderHistoryProvider>(
        builder: (context, orderHistoryProvider, child) {
          final orderHistory = orderHistoryProvider.orderHistory;

          // Memastikan bahwa orderHistory tidak kosong
          if (orderHistory.isEmpty) {
            return const Center(child: CircularProgressIndicator()); // Menunggu data dummy ditambahkan
          }

          return ListView.builder(
            itemCount: orderHistory.length,
            itemBuilder: (context, index) {
              final order = orderHistory[index];
              return ListTile(
                leading: const Icon(Icons.fastfood),
                title: Text(order.product.name), // Menampilkan nama produk dari OrderHistory
                subtitle: Text(
                  'Rp ${order.totalPrice} - ${order.orderDate.toLocal().toString().split(' ')[0]}', // Menampilkan harga dan tanggal
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/*class OrderHistoryPage extends StatelessWidget {
  // Data riwayat pesanan disimpan di sini
  static List<Map<String, dynamic>> orderHistory = [];

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Provider.of<OrderHistoryProvider>(context, listen: false).addDummyData();
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Order History")),
      body: ListView.builder(
        itemCount: orderHistory.length,
        itemBuilder: (context, index) {
          final order = orderHistory[index];
          return ListTile(
            leading: const Icon(Icons.fastfood),
            title: Text(order['foodName']),
            subtitle: Text(
              'Rp ${order['price']} - ${order['orderDate'].toLocal().toString().split(' ')[0]}',
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk menambahkan pesanan
  static void addToOrderHistory(String foodName, int price) {
    orderHistory.add({
      'foodName': foodName,
      'price': price,
      'orderDate': DateTime.now(),
    });
  }
}
*/
