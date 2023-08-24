import 'dart:convert';

import 'package:buynow/models/near_by_restorent.dart';
import 'package:flutter/cupertino.dart';
import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/error_handling.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoryProductServices {
  // get category wise products
  Future<List<NearbyRestorentModel>> getCategoryProducts(
      BuildContext context, String category, int page) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final location = userProvider.result;
    List<NearbyRestorentModel> categoryData = [];
    try {
      final http.Response res = await http.get(
        Uri.parse(
            '${Const.apiV1Url}/consumer/category/${category}/location/${location}?page=$page&limit=10'),
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
            // categoryData = jsonDecode(res.body) as List<dynamic>;

            final extractedData = jsonDecode(res.body.toString());
            print('extractedData:' + extractedData.toString());
            for (Map element in extractedData) {
              categoryData.add(NearbyRestorentModel.fromJson(
                  element as Map<String, dynamic>));
            }
            print(extractedData.toString());
          });
    } catch (e) {
      showSnackBar('No seller available for this category.');
    }
    return categoryData;
  }
}
