import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';

import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderServices {
  orderPlace({
    required BuildContext context,
    required String name,
    required String state,
    required String city,
    required String phoneNo,
    required String pincode,
    required String streetAddress,
    required String additional,
    required String latitude,
    required String longitude,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('${Const.apiV1Url}/consumer/order/placeorder'),
        body: {
          'name': name,
          'country': 'India',
          'state': state,
          'city': city,
          'phoneNumber': phoneNo,
          'pinCode': pincode,
          'streetAddress': streetAddress,
          'additionalInfo': additional,
          'landmark': '',
          'latitude': latitude,
          'longitude': longitude,
        },
        headers: {'Authorization': '${userProvider.token}'},
      );

      print(res.statusCode);
      print(res.body);
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  orderHistory(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<dynamic> orderHistory = [];
    try {
      http.Response res = await http.get(
        Uri.parse('${Const.apiV1Url}/consumer/orders/hostory'),
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
            orderHistory = jsonDecode(res.body) as List<dynamic>;
            orderHistory = orderHistory.reversed.toList();
          });
    } catch (e) {
      showSnackBar(e.toString());
    }
    return orderHistory;
  }
}
