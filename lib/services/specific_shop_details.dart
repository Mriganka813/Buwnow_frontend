import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SpecificShopDetails {
  getShopDetails(BuildContext context, String shopId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<dynamic> productData = [];
    try {
      http.Response res = await http.get(
        Uri.parse('${Const.apiV1Url}/consumer/view/viewshop/$shopId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${userProvider.token}'
        },
      );

      print(res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            productData = jsonDecode(res.body);
          });
    } catch (e) {
      showSnackBar(e.toString());
    }
    return productData;
  }
}
