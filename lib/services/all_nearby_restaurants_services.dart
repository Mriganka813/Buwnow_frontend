import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/error_handling.dart';
import 'package:buynow/models/near_by_restorent.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants/utils.dart';

class RestaurantServices {
  Future<List<NearbyRestorentModel>> fetchAllNearbyRestaurantsList(
      BuildContext context, int page) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<NearbyRestorentModel> restaurantList = [];
    try {
      final http.Response res = await http.get(
        Uri.parse(
            '${Const.apiV1Url}/consumer/search/location/viewall/${userProvider.result}?page=$page&limit=10'),
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
            final extractedData = jsonDecode(res.body)['users'];
            for (Map element in extractedData) {
              restaurantList.add(NearbyRestorentModel.fromJson(
                  element as Map<String, dynamic>));
            }
            print(extractedData.toString());
            restaurantList = restaurantList.reversed.toList();
          });
    } catch (e) {
      // showSnackBar("No Nearby Restaurants available at this location");
    }
    return restaurantList;
  }
}
