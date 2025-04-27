import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/provider/order_history_provider.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_mobile/pages/review_page.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order History")),
      body: Consumer<OrderHistoryProvider>(
        builder: (context, orderHistoryProvider, child) {
          final orderHistory = orderHistoryProvider.orderHistory;

          if (orderHistory.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: orderHistory.length,
            itemBuilder: (context, index) {
              final order = orderHistory[index];
              return ListTile(
                leading: Image.asset(
                  order.product.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(order.product.name),
                subtitle: Text(
                  'Rp ${order.totalPrice} - ${order.orderDate.toLocal().toString().split(' ')[0]}',
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewPage(order: order),
                      ),
                    );
                  },
                  child: const Text("Review"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
