import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';

class ApiService {
  final String api = "http://10.0.2.2:8000";

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String firebaseUid = await prefs.getString('firebase_uid') ?? " ";

      final http.Response response = await http.get(
        Uri.parse('${api}/api/profile'),
        headers: {
          'Content-Type': 'application/json',
          'firebase_uid': firebaseUid,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception(
          'Failed to load profile. Status code: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (error) {
      print('Error fetching profile: $error');
      throw error;
    }
  }
}
