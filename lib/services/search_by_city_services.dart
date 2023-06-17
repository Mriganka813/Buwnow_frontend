import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SearchServices {
  // fetch nearby restorants
  sendCityName(String location, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<dynamic> userList = [];
    try {
      http.Response res = await http.post(
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
          userList = jsonDecode(res.body)['users'] as List<dynamic>;
        },
      );
    } catch (e) {
      showSnackBar('No seller found at this location');
    }
    return userList;
  }
}
