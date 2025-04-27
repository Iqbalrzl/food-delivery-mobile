import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/components/my_drawer.dart';
import 'package:food_delivery_mobile/pages/cart_page.dart';
import 'package:food_delivery_mobile/pages/menu_page.dart';
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
            child: Icon(
              icon,
              color: Colors.white,
            ),
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
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: primaryColor,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
  onPressed: () {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "About This App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "NomNomGo is a food delivery application designed to make it easy for users to order their favorite food and have it delivered right to their doorsteps. Whether you're craving a quick snack or a full meal, NomNomGo connects you with a variety of restaurants in your area for fast and convenient delivery.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Menutup modal
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text("Close"),
              ),
            ],
          ),
        );
      },
    );
  },
  child: Text(
    "About",
    style: TextStyle(
      color: Colors.black87,
      fontSize: 14,
    ),
  ),
),

          
          TextButton(
            onPressed: () {
              showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
           decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), // Sudut kiri atas melengkung
              topRight: Radius.circular(30), // Sudut kanan atas melengkung
            ),
           ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 20),
              // Menambahkan teks "Admin" sebelum nomor telepon
              Text(
                "Admin",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "0823-7698-3421", // Nomor telepon yang ditampilkan
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Menutup bottom sheet
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text("Close"),
              ),
            ],
          ),
        );
      },
    );
  
            },
            child: Text(
              "Contact",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
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
                backgroundColor: accentColor,
                foregroundColor: Colors.white,
                  shape: CircleBorder(
                
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
             child :  Icon(Icons.person, color: Colors.white),
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
                            color:accentColor,
                          ),
                        ),
                        Text(
                          "Every Moment",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                        Text(
                          "by NomNomGo.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Order your products at any time and we will deliver them directly to your home.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MenuPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Text("Order Here!"),
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
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 60),
              
              // Why Choose Us Section
              Text(
                "Why NomNomGo?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
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
                  child: Icon(
                    Icons.eco,
                    size: 60,
                    color: accentColor,
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
