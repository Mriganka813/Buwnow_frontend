import 'dart:convert';

import 'package:buynow/models/product.dart';
import 'package:flutter/material.dart';
import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/error_handling.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SpecificShopDetails {
  // get specific shop products list
  Future<List<Product>> getShopProducts(
      BuildContext context, String shopId, int page) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productData = [];
    try {
      final http.Response res = await http.get(
        Uri.parse(
            '${Const.apiV1Url}/consumer/view/viewshop/$shopId?page=$page&limit=10'),
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
            // productData = jsonDecode(res.body);

            List extractedData = jsonDecode(res.body)['inventory'];

            print('extractedData:' + extractedData.toString());
            for (Map element in extractedData) {
              productData
                  .add(Product.fromJson(element as Map<String, dynamic>));
            }
            print(extractedData.toString());
          });
    } catch (e) {
      // showSnackBar(e.toString());
    }
    return productData;
  }
}
