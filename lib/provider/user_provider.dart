import 'package:flutter/material.dart';
import '../data/model.dart';

class UserProvider with ChangeNotifier {
  final List<User> _users = [
    User(
      email: "iqal@gmail.com",
      password: "iqal123",
      username: "Iqal Mahendra",
      location: "jalan bojongsoang no 7",
    ),
  ];

  List<User> get users => _users;
}
