import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/components/my_drawer.dart';
import 'package:food_delivery_mobile/pages/menu_page.dart';
import 'package:lottie/lottie.dart';

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
  static const Color primaryColor = Color(0xFFB85C44); // Rust Brown
  static const Color secondaryColor = Color(0xFF0A3A5A); // Dark Blue for text
  static const Color accentColor = Color(0xFFB85C44); // Rust/brown
  static const Color backgroundColor = Color(0xFFF8F6F0); // Cream background
  static const Color yellowAccent = Color(0xFFFFB800); // Yellow
  static const Color pinkAccent = Color(0xFFF8A5A5); // Pink
  static const Color silver = Color.fromARGB(255, 131, 127, 127);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: Text(
          "NomNomGo",
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
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            width: screenWidth,
            height: 250,
            padding: EdgeInsets.only(top: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  'assets/lotties/motorcycle.json',
                  width: screenWidth * 0.8,
                  fit: BoxFit.contain,
                ),

                Positioned(
                  top: 30,
                  right: screenWidth * 0.2,
                  child: CircleAvatar(
                    backgroundColor: primaryColor.withOpacity(0.8),
                    radius: 20,
                    child: Icon(Icons.location_on, color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: screenWidth * 0.15,
                  child: CircleAvatar(
                    backgroundColor: primaryColor.withOpacity(0.8),
                    radius: 20,
                    child: Icon(Icons.location_on, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text content
                    Column(
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
                                builder: (context) => MenuPage(),
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

                    SizedBox(height: 60),

                    Text(
                      "Why NomNomGo?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),

                    SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FeatureCard(
                          icon: Icons.motorcycle,
                          title: "Fast Delivery",
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
                          color: silver,
                        ),
                      ],
                    ),

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
          ),
        ],
      ),
    );
  }
}
