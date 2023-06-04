import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<void> sendCityName(String city, BuildContext context) async {
    try {
      http.Response res =
          await http.post(Uri.parse('${Const.apiV1Url}/consumer/'),
              body: jsonEncode({
                'city': city,
              }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(e.toString());
    }
  }
}
