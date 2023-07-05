import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/models/near_by_restorent.dart';
import 'package:gofoods/providers/user_provider.dart';
import 'package:gofoods/screens/homeseeall/nearbyrestorent.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RestaurantServices {
  Future<List<NearbyRestorentModel>> fetchAllNearbyRestaurantsList(
      BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<NearbyRestorentModel> restaurantList = [];
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
            final extractedData = jsonDecode(res.body)['users'];
            for (Map element in extractedData) {
              restaurantList.add(NearbyRestorentModel.fromJson(
                  element as Map<String, dynamic>));
            }
            print(extractedData.toString());
            restaurantList = restaurantList.reversed.toList();
          });
    } catch (e) {
      showSnackBar("No Nearby Restaurants available at this location");
    }
    return restaurantList;
  }
}
