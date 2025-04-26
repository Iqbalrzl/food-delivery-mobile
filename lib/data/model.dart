class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class OrderHistory {
  final String orderId;
  final Product product;
  final int quantity;
  final double totalPrice;
  final DateTime orderDate;

  OrderHistory({
    required this.orderId,
    required this.product,
    required this.quantity,
    required this.totalPrice,
    required this.orderDate,
  });

  String getOrderDetail(){
    return '${product.name} x$quantity - Total: Rp $totalPrice';
  }
}

class User {
  final String email;
  final String password;
  final String username;
  final String location;

  User({
    required this.email,
    required this.password,
    required this.username,
    required this.location,
  });
}
