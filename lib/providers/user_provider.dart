import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      phoneNo: '',
      password: '',
      address: '',
      role: '',
      token: '',
      cart: []);

  String result = '';

  String? token = '';

  String? id = '';
  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  void setKeyword(String text) {
    result = text;
    notifyListeners();
  }

  void setToken(String tok) {
    token = tok;
    notifyListeners();
  }

  void setId(String idd) {
    id = idd;
    notifyListeners();
  }
}
