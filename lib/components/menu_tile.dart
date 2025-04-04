import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/pages/menu_detail_page.dart';
import 'package:food_delivery_mobile/provider/cart_provider.dart';
import 'package:food_delivery_mobile/data/model.dart';
import 'package:provider/provider.dart';

class MenuTile extends StatelessWidget {
  final String? id;
  final String? menuCategory;
  final String? menuTitle;
  final String? menuDesc;
  final double? menuPrice;
  final String? imageUrl;

  const MenuTile({
    super.key,
    this.id,
    this.menuCategory,
    this.menuTitle,
    this.menuDesc,
    this.menuPrice,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => MenuDetailPage(
                    product: Product(
                      id: id ?? "1",
                      category: menuCategory ?? "main",
                      name: menuTitle ?? "Title",
                      description:
                          menuDesc ??
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      price: menuPrice ?? 10.0,
                      imageUrl: imageUrl ?? "assets/images/food1.jpg",
                    ),
                  ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
                color: Theme.of(context).colorScheme.tertiary,
                shadowColor: Theme.of(context).colorScheme.secondary,
                child: SizedBox(
                  height: 150,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        decoration: BoxDecoration(),
                        margin: EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          menuTitle ?? "Title",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        indent: 10,
                        endIndent: 100,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 30),
                        child: Text(
                          menuDesc ??
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Hero(
                tag: "menu-$id",
                child: Container(
                  padding: const EdgeInsets.only(top: 4.5, left: 190),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      imageUrl ?? 'assets/images/food1.jpg',
                      height: 151,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Feedback.forTap(context);
                  cartProvider.addToCart(
                    Product(
                      id: id ?? "1",
                      category: menuCategory ?? "Main",
                      name: menuTitle ?? "Title",
                      description: menuDesc ?? "Description",
                      imageUrl: imageUrl ?? "assets/images/food1.jpg",
                      price: menuPrice ?? 10.0,
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
                child: Container(
                  margin: EdgeInsets.only(top: 155, left: 3.5),
                  height: 35,
                  width: 186,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
