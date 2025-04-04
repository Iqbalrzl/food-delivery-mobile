import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/components/my_button.dart';
import 'package:food_delivery_mobile/data/model.dart';
import 'package:food_delivery_mobile/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class MenuDetailPage extends StatelessWidget {
  final Product product;

  const MenuDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: "menu-${product.id}",
                  child: Container(
                    height: isLandScape ? 150 : null,
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      product.imageUrl,
                      height: 375,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.black12,
                      shape: CircleBorder(),
                    ),
                    child: Icon(
                      Icons.navigate_before,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),

            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(top: 10, left: 20),
              child: Text(product.description, style: TextStyle(fontSize: 20)),
            ),

            isLandScape ? SizedBox(height: 20) : Spacer(),

            MyButton(
              onTap: () {
                Feedback.forTap(context);
                cartProvider.addToCart(
                  Product(
                    id: product.id,
                    category: product.category,
                    name: product.name,
                    description: product.description,
                    imageUrl: product.imageUrl,
                    price: product.price,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Added to cart",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    duration: Duration(milliseconds: 300),
                  ),
                );
              },
              text: "Add to Cart",
            ),

            isLandScape ? SizedBox(height: 10) : SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
