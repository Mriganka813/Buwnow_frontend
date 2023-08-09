import 'dart:convert';

import 'package:buynow/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants/utils.dart';
import '../providers/user_provider.dart';

class SearchProductServices {
  //get searched product list
  Future<List<Product>> getProducts(
      String prodName, BuildContext context, int page) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> prodList = [];
    try {
      final http.Response res = await http.post(
        Uri.parse(
            '${Const.apiV1Url}/consumer/search/product/${userProvider.result}?page=$page&limit=10'),
        body: {
          'productName': prodName,
        },
        headers: {'Authorization': '${userProvider.token}'},
      );

      print(res.statusCode);
      print(res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // prodList = jsonDecode(res.body)['product'] as List<dynamic>;

            List extractedData = jsonDecode(res.body)['data'];

            print('extractedData:' + extractedData.toString());
            for (Map element in extractedData) {
              prodList.add(Product.fromJson(element as Map<String, dynamic>));
            }
            print(extractedData.toString());
          });
    } catch (e) {
      showSnackBar('No product found matching your search.');
    }
    return prodList;
  }
}
