import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/components/menu_tile.dart';
import 'package:food_delivery_mobile/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ListProductByCategory extends StatelessWidget {
  final String productCategory;
  const ListProductByCategory({super.key, required this.productCategory});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final filteredProducts =
            productProvider.products
                .where((product) => product.category == productCategory)
                .toList();

        if (filteredProducts.isEmpty) {
          return Center(
            child: Text(
              "Product not found.",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return MenuTile(
              id: product.id,
              menuCategory: product.category,
              menuTitle: product.name,
              menuDesc: product.description,
              menuPrice: product.price,
              imageUrl: product.imageUrl,
            );
          },
        );
      },
    );
  }
}
