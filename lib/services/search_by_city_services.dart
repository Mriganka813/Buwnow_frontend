import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/error_handling.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/models/near_by_restorent.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SearchServices {
  // fetch nearby restorants
  Future<List<NearbyRestorentModel>> sendCityName(
      String location, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<NearbyRestorentModel> userList = [];
    try {
      final http.Response res = await http.post(
        Uri.parse('${Const.apiV1Url}/consumer/search/location'),
        body: jsonEncode({
          'location': location,
        }),
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
            userList.add(
                NearbyRestorentModel.fromJson(element as Map<String, dynamic>));
          }

          userList = userList.reversed.toList();
          print(userList);
        },
      );
    } catch (e) {
      showSnackBar('No seller found at this location');
    }
    return userList;
  }
}
