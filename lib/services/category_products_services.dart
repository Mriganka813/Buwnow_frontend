import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoryProductServices {
  getCategoryProducts(BuildContext context, String category) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final location = userProvider.result;
    List<dynamic> categoryData = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
            '${Const.apiV1Url}/consumer/category/${category}/location/${location}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${userProvider.token}'
        },
      );
      print(category);
      print(location);
      print(res.statusCode);
      print(res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            categoryData = jsonDecode(res.body) as List<dynamic>;
          });
      return categoryData;
    } catch (e) {
      showSnackBar('No seller available for this category.');
    }
  }
}
