import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/data/api_service.dart';
import 'package:food_delivery_mobile/auth/auth_service.dart';
import 'package:food_delivery_mobile/auth/login_or_register.dart';
import 'package:food_delivery_mobile/components/my_button.dart';
import 'package:food_delivery_mobile/data/model.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  late Future<Profile?> _userProfileFuture;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final success = await _apiService.updateProfileImage(imageFile);

      if (success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Profile image updated!')));
        setState(() {
          _userProfileFuture = _apiService.fetchProfileByUserId();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update image.')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _userProfileFuture = _apiService.fetchProfileByUserId();
  }

  @override
  Widget build(BuildContext context) {
    var apiService = ApiService();
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0),
      body: SingleChildScrollView(
        child: FutureBuilder<Profile?>(
          future: _userProfileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final profile = snapshot.data!;
              final imageUrl = profile.profileImageUrl;
              final fixedUrl = apiService.fixLocalhostUrl(imageUrl!);

              return Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          (imageUrl != null && imageUrl.isNotEmpty)
                              ? NetworkImage(fixedUrl)
                              : const AssetImage(
                                    "assets/images/avatar-default.jpg",
                                  )
                                  as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: _pickAndUploadImage,
                    icon: const Icon(Icons.image),
                    label: const Text("Upload Image"),
                  ),
                  Center(
                    child: Text(
                      profile.username,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  const SizedBox(height: 400),
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
              );
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }
}
