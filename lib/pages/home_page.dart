import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/components/my_drawer.dart';
import 'package:food_delivery_mobile/pages/cart_page.dart';
import 'package:food_delivery_mobile/pages/profile_page.dart';
import 'package:lottie/lottie.dart';

// Feature card widget moved inside the same file
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Define colors directly in this file
  static const Color primaryColor = Color(0xFF0D5C46); // Teal green
  static const Color secondaryColor = Color(0xFF0A3A5A); // Dark blue
  static const Color accentColor = Color(0xFFB85C44); // Rust/brown
  static const Color backgroundColor = Color(0xFFF8F6F0); // Cream background
  static const Color yellowAccent = Color(0xFFFFB800); // Yellow
  static const Color pinkAccent = Color(0xFFF8A5A5); // Pink

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: Text(
          "Delivero",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: primaryColor,
          ),
        ),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(Icons.menu, color: primaryColor),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "About",
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Delivery",
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Contact",
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text("Sign in"),
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section
              Row(
                children: [
                  // Left side - Text content
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery for",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        Text(
                          "any Special",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        Text(
                          "Occasion.",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Order your products at any time and we will deliver them directly to your home.",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: Text("Get Started"),
                        ),
                      ],
                    ),
                  ),

                  // Right side - Image or Lottie animation
                  Expanded(
                    flex: 6,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // You can use your existing Lottie animation or an image
                        // If you have a delivery person image, use this:
                        // Image.asset("assets/images/delivery-person.png", fit: BoxFit.contain),

                        // Or keep using your Lottie animation:
                        Lottie.asset('assets/lotties/cat.json'),

                        // Add location markers like in the design
                        Positioned(
                          top: 50,
                          right: 80,
                          child: CircleAvatar(
                            backgroundColor: primaryColor.withOpacity(0.8),
                            radius: 20,
                            child: Icon(Icons.location_on, color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: 70,
                          right: 40,
                          child: CircleAvatar(
                            backgroundColor: primaryColor.withOpacity(0.8),
                            radius: 20,
                            child: Icon(Icons.location_on, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 60),

              // Why Choose Us Section
              Text(
                "Why Delivero?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),

              SizedBox(height: 24),

              // Feature cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureCard(
                    icon: Icons.local_shipping,
                    title: "Logistic support",
                    color: primaryColor,
                  ),
                  FeatureCard(
                    icon: Icons.verified,
                    title: "Quality control",
                    color: yellowAccent,
                  ),
                  FeatureCard(
                    icon: Icons.money_off,
                    title: "No tax",
                    color: pinkAccent,
                  ),
                  FeatureCard(
                    icon: Icons.security,
                    title: "Safe Delivery",
                    color: secondaryColor,
                  ),
                ],
              ),

              // Add a decorative element like the leaf in the design
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Icon(Icons.eco, size: 60, color: yellowAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
