import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<void> _fetchCartFuture;

  @override
  void initState() {
    super.initState();
    _fetchCartFuture =
        Provider.of<CartProvider>(context, listen: false).fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: FutureBuilder(
        future: _fetchCartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.items.isEmpty) {
            return Center(
              child: Text(
                "Cart is empty.",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.items[index];

                    return ListTile(
                      leading: Image.asset(
                        cartItem.product.imageUrl,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(cartItem.product.name),
                      subtitle: Text(
                        "IDR ${cartItem.product.price.toStringAsFixed(2)}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () async {
                              await cartProvider.updateQuantity(
                                cartItem,
                                cartItem.quantity - 1,
                              );
                            },
                          ),
                          Text("${cartItem.quantity}"),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              await cartProvider.updateQuantity(
                                cartItem,
                                cartItem.quantity + 1,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Total: IDR ${cartProvider.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed:
                          cartProvider.items.isEmpty
                              ? null
                              : () async {
                                final success = await cartProvider.checkout();
                                if (success) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text(
                                          "Thank you for ordering!",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                } else {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text(
                                          "Checkout failed. Please try again.",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
