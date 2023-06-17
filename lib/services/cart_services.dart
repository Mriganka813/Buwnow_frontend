import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  // add to cart
  Future<void> addToCart(
      BuildContext context, String productId, String quantity) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
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
          onSuccess: () {
            // showSnackBar(jsonDecode(res.body)['msg']);
          });
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  //get cart items
  Future<List<dynamic>> getCartItems(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<dynamic> cartData = [];
    try {
      http.Response res = await http.get(
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
            cartData = jsonDecode(res.body);
            cartData = cartData.reversed.toList();
          });
    } catch (e) {
      showSnackBar(e.toString());
    }
    return cartData;
  }

  //remove from cart
  removeFromCart(BuildContext context, String prodId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
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
