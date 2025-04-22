import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/auth/login_or_register.dart';
import 'package:food_delivery_mobile/components/my_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar-default.jpg"),
                radius: 100,
              ),
            ),

            SizedBox(height: 25),

            Center(
              child: Text("Iqal Mahendra", style: TextStyle(fontSize: 25)),
            ),

            SizedBox(height: 470),

            MyButton(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginOrRegister()),
                  (route) => false,
                );
              },
              text: "Logout",
            ),

            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
