import 'dart:convert';

import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ProductServices {
  rating(String productId, BuildContext context, int rating) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final http.Response res = await http.post(
        Uri.parse('${Const.apiV1Url}/consumer/rate/$productId'),
        body: jsonEncode({
          'rating': rating,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${userProvider.token}'
        },
      );
      print(res.body);
    } catch (e) {
      showSnackBar(e.toString());
    }
  }
}
