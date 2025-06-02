import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/data/api_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _productFuture;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _productFuture = _apiService.fetchAllProducts();
    });
  }

  void _deleteProduct(int id) async {
    final success = await _apiService.deleteProduct(id);
    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Product deleted")));
      _loadProducts();
    }
  }

  void _editProductDialog(Map<String, dynamic> product) {
    final nameController = TextEditingController(text: product['name'] ?? '');
    final priceController = TextEditingController(
      text: product['price']?.toString() ?? '',
    );
    final descriptionController = TextEditingController(
      text: product['description'] ?? '',
    );
    final categoryController = TextEditingController(
      text: product['category'] ?? '',
    );

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(product['id'] != null ? "Edit Product" : "Add Product"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: "Description"),
                  ),
                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(labelText: "Category"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final priceText = priceController.text.trim();
                  final description = descriptionController.text.trim();
                  final category = categoryController.text.trim();

                  if (name.isEmpty ||
                      priceText.isEmpty ||
                      description.isEmpty ||
                      category.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All fields are required")),
                    );
                    return;
                  }

                  final price = double.tryParse(priceText);
                  if (price == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Price must be a valid number"),
                      ),
                    );
                    return;
                  }

                  final updated = {
                    "name": name,
                    "price": price,
                    "description": description,
                    "category": category,
                  };

                  bool success = false;
                  if (product['id'] != null) {
                    success = await _apiService.updateProduct(
                      product['id'],
                      updated,
                    );
                  } else {
                    success = await _apiService.createProduct(updated);
                  }

                  Navigator.pop(context);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          product['id'] != null ? "Updated!" : "Created!",
                        ),
                      ),
                    );
                    _loadProducts();
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin - Manage Products")),
      body: FutureBuilder<List<dynamic>>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return ListTile(
                title: Text(p['name']),
                subtitle: Text("Rp${p['price']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editProductDialog(p),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteProduct(p['id']),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _editProductDialog({
            'id': null,
            'name': '',
            'price': 0.0,
            'description': '',
            'category': '',
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
