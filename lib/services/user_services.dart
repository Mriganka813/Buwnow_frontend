import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class UserServices {
  // get user details
  Future<Map<String, dynamic>> getUserDetails(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Map<String, dynamic> extractedData = {};
    try {
      http.Response res = await http.get(
        Uri.parse('${Const.apiV1Url}/consumer/detail/${userProvider.id}'),
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
            extractedData =
                jsonDecode(res.body)['consumer'] as Map<String, dynamic>;
          });
    } catch (e) {
      showSnackBar(e.toString());
    }
    return extractedData;
  }

  //update user details
  Future<void> updateUserDetails(
      BuildContext context, String name, String email) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.put(
        Uri.parse('${Const.apiV1Url}/consumer/upd/${userProvider.id}'),
        body: {
          'name': name,
          'email': email,
        },
        headers: {'Authorization': '${userProvider.token}'},
      );
      print(res.body);
      print(res.statusCode);
    } catch (e) {
      showSnackBar(e.toString());
    }
  }
}
