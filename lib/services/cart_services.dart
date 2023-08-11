import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/error_handling.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item.dart';

class CartServices {
  // add to cart
  Future<void> addToCart(
      BuildContext context, String productId, String quantity) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final http.Response res = await http.post(
        Uri.parse('${Const.apiV1Url}/consumer/cart/add/product/$productId'),
        body: {
          'qty': quantity,
        },
        headers: {
          'Authorization': '${userProvider.token}',
        },
      );

      print(res.statusCode);
      print(res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            // showSnackBar(jsonDecode(res.body)['msg']);
            var data = jsonDecode(res.body)['cart'];
            double lat = double.parse(data['latitude'].toString());
            double long = double.parse(data['longitude'].toString());

            SharedPreferences prefs = await SharedPreferences.getInstance();

            String? sellerlat = prefs.getString('lat');
            String? sellerlong = prefs.getString('long');
            print(lat.toString() + long.toString());
            if (sellerlat == null || sellerlong == null) {
              String lat = data['latitude'];
              String long = data['longitude'];
              await prefs.setString('lat', lat);
              await prefs.setString('long', long);
              print(lat.toString() + long.toString());
            } else {}

            userProvider.setSellerLatLong(lat, long);
          });
    } catch (e) {
      // showSnackBar(e.toString());
    }
  }

  //get cart items
  Future<List<CartItem>> getCartItems(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<CartItem> cartData = [];
    try {
      final http.Response res = await http.get(
        Uri.parse('${Const.apiV1Url}/consumer/showcart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${userProvider.token}'
        },
      );

      print(res.statusCode);
      print(res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            final extractedData = jsonDecode(res.body.toString());
            print('getCartItems:' + extractedData.toString());
            for (Map element in extractedData) {
              cartData.add(CartItem.fromJson(element as Map<String, dynamic>));
            }
            print(extractedData.toString());
            cartData = cartData.reversed.toList();
          });
    } catch (e) {
      // showSnackBar(e.toString());
    }
    return cartData;
  }

  //remove from cart
  removeFromCart(BuildContext context, String prodId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final http.Response res = await http.get(
        Uri.parse('${Const.apiV1Url}/consumer/cart/delete/$prodId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${userProvider.token}'
        },
      );

      print(res.statusCode);
      print(res.body);
    } catch (e) {
      showSnackBar(e.toString());
    }
  }
}
