import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body:
          cartProvider.items.isEmpty
              ? Center(
                child: Text(
                  "Cart is empty.",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 25,
                  ),
                ),
              )
              : Column(
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
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  cartProvider.updateQuantity(
                                    cartItem.product,
                                    cartItem.quantity - 1,
                                  );
                                },
                              ),
                              Text("${cartItem.quantity}"),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  cartProvider.updateQuantity(
                                    cartItem.product,
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed:
                              cartProvider.items.isEmpty
                                  ? null
                                  : () {
                                    cartProvider.clearCart();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text(
                                          "Thank you for ordering!",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
