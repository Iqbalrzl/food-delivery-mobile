import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/auth/api_service.dart';
import 'package:food_delivery_mobile/auth/auth_service.dart';
import 'package:food_delivery_mobile/auth/login_or_register.dart';
import 'package:food_delivery_mobile/components/my_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  late Future<Map<String, dynamic>> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = _apiService.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar-default.jpg"),
                radius: 100,
              ),
            ),
            const SizedBox(height: 25),
            FutureBuilder<Map<String, dynamic>>(
              future: _userProfileFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final userProfile = snapshot.data!;
                  final username =
                      userProfile["data"]?["username"] ?? "No Username";
                  return Center(
                    child: Text(username, style: const TextStyle(fontSize: 25)),
                  );
                } else {
                  return const Center(child: Text("No data available"));
                }
              },
            ),
            const SizedBox(height: 470),
            MyButton(
              onTap: () {
                _authService.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginOrRegister(),
                  ),
                  (route) => false,
                );
              },
              text: "Logout",
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
