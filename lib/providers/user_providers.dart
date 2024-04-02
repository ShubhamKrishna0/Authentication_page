import 'package:flutter/material.dart';
import 'package:foody/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    address: '',
    email: '',
    id: '',
    name: '',
    password: '',
    type: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
