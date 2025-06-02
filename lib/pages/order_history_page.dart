import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_mobile/provider/order_history_provider.dart';
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
    Future.microtask(
      () =>
          Provider.of<OrderHistoryProvider>(
            context,
            listen: false,
          ).fetchOrderHistory(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order History")),
      body: Consumer<OrderHistoryProvider>(
        builder: (context, orderHistoryProvider, _) {
          if (orderHistoryProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderHistoryProvider.errorMessage != null) {
            return Center(
              child: Text('Error: ${orderHistoryProvider.errorMessage}'),
            );
          }

          final orders = orderHistoryProvider.orderHistory;

          if (orders.isEmpty) {
            return const Center(child: Text("No orders found."));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ExpansionTile(
                  title: Text(
                    "Order ID: ${order.id} - IDR ${order.totalPrice}",
                  ),
                  subtitle: Text("Status: ${order.status}"),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                  collapsedBackgroundColor:
                      Theme.of(context).colorScheme.surface,
                  children:
                      order.items.map((item) {
                        return ListTile(
                          leading: Image.asset(
                            item.product.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.product.name),
                          subtitle: Text(
                            "Qty: ${item.quantity} | Price: IDR ${item.price}",
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ReviewPage(orderItem: item),
                                ),
                              );
                            },
                            child: const Text("Review"),
                          ),
                        );
                      }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
