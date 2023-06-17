import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SearchProductServices {
  //get searched product list
  getProducts(String prodName, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<dynamic> prodList = [];
    try {
      http.Response res = await http.post(
        Uri.parse('${Const.apiV1Url}/consumer/search/product'),
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
            prodList = jsonDecode(res.body)['product'] as List<dynamic>;
          });
    } catch (e) {
      showSnackBar('No product found matching your search.');
    }
    return prodList;
  }
}
