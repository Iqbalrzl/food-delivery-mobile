import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/components/list_product_by_category.dart';
import 'package:food_delivery_mobile/components/menu_category_divider.dart';
import 'package:food_delivery_mobile/components/my_drawer.dart';
import 'package:food_delivery_mobile/pages/cart_page.dart';
import 'package:food_delivery_mobile/pages/profile_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedCategory = "MAIN";
  List category = ["MAIN", "DESSERT", "BEVERAGE", "ALACARTE"];

  void changeSection(String section) {
    setState(() {
      selectedCategory = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        title: Text(
          "MENU",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            letterSpacing: 5,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 10.0),
            child: GestureDetector(
              onTap: () {
                Feedback.forTap(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar-default.jpg"),
              ),
            ),
          ),
        ],
      ),

      drawer: const MyDrawer(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            Container(
              height: 50,
              width: 500,
              decoration: BoxDecoration(),
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          FilledButton(
                            onPressed: () {
                              changeSection(category[index]);
                            },
                            child: Text(category[index]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 20),

            MenuCategoryDivider(categoryName: selectedCategory),

            Container(
              height: 680,
              width: 380,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ListProductByCategory(
                    productCategory: selectedCategory.toLowerCase(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
