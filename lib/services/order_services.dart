import 'dart:convert';

import 'package:buynow/models/consumer_adrress.dart';
import 'package:flutter/material.dart';
import 'package:buynow/constants/const.dart';

import 'package:buynow/constants/utils.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';

class OrderServices {
  // order place
  orderPlace({
    required BuildContext context,
    required ConsumerAddress orderDetail,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final http.Response res = await http.post(
        Uri.parse('${Const.apiV1Url}/consumer/order/placeorder'),
        body: orderDetail.toJson(),
        headers: {'Authorization': '${userProvider.token}'},
      );

      print(res.statusCode);
      print(res.body);
    } catch (e) {
      // showSnackBar(e.toString());
    }
  }

  // order history
  Future<List<Order>> orderHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    List<Order> orderHistory = [];
    try {
      final http.Response res = await http.get(
        Uri.parse('${Const.apiV1Url}/consumer/orders/history'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${token}'
        },
      );

      print(res.statusCode);
      print('order = ${res.body}');

      if (res.statusCode == 200) {
        final extractedData = jsonDecode(res.body)['recentOrders'];
        // print('extractedData:' + extractedData.toString());
        for (Map element in extractedData) {
          orderHistory.add(Order.fromJson(element as Map<String, dynamic>));
        }
        // print(extractedData.toString());
        orderHistory = orderHistory.reversed.toList();
        print('orderhistory =${orderHistory[0].sellerNum!}');
        print(orderHistory[0]);
      }

      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSuccess: () {
      //       final extractedData = jsonDecode(res.body.toString());
      //       print('extractedData:' + extractedData.toString());
      //       for (Map element in extractedData) {
      //         orderHistory.add(Order.fromJson(element as Map<String, dynamic>));
      //       }
      //       print(extractedData.toString());
      //       orderHistory = orderHistory.reversed.toList();
      //     });
    } catch (e) {
      // showSnackBar(e.toString());
      print(e.toString());
    }
    return orderHistory;
  }
}
