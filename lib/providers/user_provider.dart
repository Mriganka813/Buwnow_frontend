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
  );

  String result = '';

  String? token = '';

  double? consumerLatitude;
  double? consumerLongitude;

  double? sellerLatitude;
  double? sellerLongitude;

  String sellerId = '';

  String? cuteToken;

  int subtotal = 0;

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

  void setConsumerLatLong(double lat, double long) {
    consumerLatitude = lat;
    consumerLongitude = long;
    notifyListeners();
  }

  void setSellerLatLong(double lat, double long) {
    sellerLatitude = lat;
    sellerLongitude = long;
    notifyListeners();
  }

  void setCuteToken(String token) {
    cuteToken = token;
    notifyListeners();
  }

  void setTotalPriceOfCartItems(int sub) {
    subtotal = sub;
    notifyListeners();
  }

  setSellerId(String id) {
    sellerId = id;
    notifyListeners();
  }
}
