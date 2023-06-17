import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RestaurantServices {
  fetchAllNearbyRestaurantsList(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<dynamic> restaurantList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(
            '${Const.apiV1Url}/consumer//search/location/viewall/${userProvider.result}'),
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
            restaurantList = jsonDecode(res.body)['users'] as List<dynamic>;
          });
    } catch (e) {
      showSnackBar("No Nearby Restaurants available at this location");
    }
    return restaurantList;
  }
}
