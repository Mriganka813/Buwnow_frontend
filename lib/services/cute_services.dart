import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/utils.dart';
import '../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class CuteServices {
  /// cute login
  cuteLogin(BuildContext context, String phoneNo) async {
    try {
      final http.Response res =
          await http.post(Uri.parse('http://65.0.7.20:8004/auth/login'), body: {
        'phoneNum': phoneNo,
        'password': "qwertyuiop",
      });
      print(res.body);
      if (res.statusCode == 200) {
        final token = jsonDecode(res.body)['tokens'];
        final accessToken = token['access'];
        final refreshToken = token['refresh'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('cuteToken', accessToken);
        await prefs.setString('cute_refresh_token', refreshToken);
        Provider.of<UserProvider>(context, listen: false)
            .setCuteToken(accessToken);
        print(accessToken);
      } else {
        showSnackBar('This number is not registered in this app.');
        return;
      }
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  /// get new token
  getNewToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String refresh_token = prefs.getString('cute_refresh_token') ?? "";
    final http.Response response =
        await http.get(Uri.parse('/auth/newtoken'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $refresh_token",
    });
    if ((response.statusCode) > 300) {
      return null;
    }
    final String access_token = jsonDecode(response.body)['token'];
    await prefs.setString('cuteToken', access_token);
    await prefs.reload();
  }
}
