import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_delivery_mobile/data/model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String get base_url => dotenv.env['BASE_API_URL'] ?? ' ';

  String fixLocalhostUrl(String? originalUrl) {
    if (originalUrl != null)
      return originalUrl.replaceFirst('http://127.0.0.1', 'http://10.0.2.2');
    return "";
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String firebaseUid = prefs.getString('firebase_uid') ?? ' ';

      final http.Response response = await http.get(
        Uri.parse('$base_url/api/profile'),
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
      rethrow;
    }
  }

  Future<Profile?> fetchProfileByUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("user_id");

    if (userId == null) return null;

    final url = Uri.parse('$base_url/api/profile/user/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body)['data'];
      return Profile.fromJson(data);
    } else {
      throw Exception("Failed to fetch profile");
    }
  }

  Future<http.Response> register(String firebaseUid, String email) async {
    final http.Response response = await http.post(
      Uri.parse('$base_url/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'firebase_uid': firebaseUid, 'email': email}),
    );

    return response;
  }

  Future<void> fetchAndStoreUserId(String firebaseUid) async {
    final url = Uri.parse('$base_url/api/auth/user-id');

    try {
      final response = await http.get(
        url,
        headers: {'firebase_uid': firebaseUid, 'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final int userId = data['user_id'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', userId);
      } else {
        print('Failed to fetch user_id. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user_id: $e');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$base_url/api/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<CartItem>> fetchCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    final url = Uri.parse('$base_url/api/users/$userId/cart-items');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CartItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<void> addCartItem(
    int productId,
    double productPrice,
    int quantity,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId == null) {
      throw Exception('User ID not found in SharedPreferences');
    }

    final response = await http.post(
      Uri.parse('$base_url/api/cart-items'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': userId,
        'product_id': productId,
        'quantity': quantity,
        'price': productPrice,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add item to cart: ${response.body}');
    }
  }

  Future<void> updateCartItemQuantity(int cartItemId, int quantity) async {
    final url = Uri.parse('$base_url/api/cart-items/$cartItemId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'quantity': quantity}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart item');
    }
  }

  Future<void> deleteCartItem(int cartItemId) async {
    final url = Uri.parse('$base_url/api/cart-items/$cartItemId');
    final response = await http.delete(url);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete cart item');
    }
  }

  Future<void> clearCart(int userId) async {
    final url = Uri.parse('$base_url/api/cart-items/clear/$userId');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to clear cart');
    }
  }

  Future<bool> checkoutCart() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId == null) return false;

    final response = await http.post(
      Uri.parse('$base_url/api/checkout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print("Checkout failed: ${response.body}");
      return false;
    }
  }

  Future<List<Order>> fetchUserOrders(int userId) async {
    final response = await http.get(
      Uri.parse("$base_url/api/users/$userId/orders"),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((orderJson) => Order.fromJson(orderJson)).toList();
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  Future<bool> updateProfileImage(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final firebaseUid = prefs.getString('firebase_uid');

    if (firebaseUid == null) {
      throw Exception("firebase_uid not found in SharedPreferences");
    }

    final uri = Uri.parse("$base_url/api/profile");
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile.path),
    );

    request.headers.addAll({
      "firebase_uid": firebaseUid,
      "Accept": "application/json",
    });

    request.fields['_method'] = 'PUT';

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print("Upload suceed: ${response.body}");
      return true;
    } else {
      print("Upload failed: ${response.statusCode} - ${response.body}");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$base_url/api/products'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map<Map<String, dynamic>>((product) {
        return {
          'id': product['id'],
          'name': product['name'],
          'price': double.tryParse(product['price']) ?? 0.0,
          'description': product['description'],
          'category': product['category'],
          'image_url': product['image_url'],
          'created_at': product['created_at'],
          'updated_at': product['updated_at'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<bool> createProduct(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$base_url/api/products'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return response.statusCode == 201;
  }

  Future<bool> updateProduct(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$base_url/api/products/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$base_url/api/products/$id'));
    return response.statusCode == 200;
  }
}
