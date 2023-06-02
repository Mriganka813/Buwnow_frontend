import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/screens/bottombar/bottombar.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class AuthServices {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phoneNo,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          role: 'user',
          token: '',
          phoneNo: phoneNo);

      http.Response res = await http.post(
          Uri.parse('${Const.apiV1Url}/register'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      print(res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar('Account Created! Login with the same credentials.');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => BottomHome(),
                ),
                (route) => false);
          });
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${Const.apiV1Url}/consumer/login'),
          body: jsonEncode({
            'phoneNumber': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BottomHome(),
              ),
              (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(e.toString());
    }
  }
}
