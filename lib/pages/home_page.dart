import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/components/my_drawer.dart';
import 'package:food_delivery_mobile/pages/cart_page.dart';
import 'package:food_delivery_mobile/pages/profile_page.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        title: Text(
          "HOME",
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
        child: Center(
          child: Column(children: [Lottie.asset('assets/lotties/cat.json')]),
        ),
      ),
    );
  }
}
