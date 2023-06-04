import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gofoods/constants/const.dart';
import 'package:gofoods/constants/error_handling.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/screens/authscreen/phonenumber.dart';
import 'package:gofoods/screens/bottombar/bottombar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/search_screen/search_screen.dart';

class AuthServices {

  // sign up user

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
          phoneNo: phoneNo,);

      http.Response res = await http.post(
          Uri.parse('${Const.apiV1Url}/consumer/register'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });



      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async{
            SharedPreferences prefs = await SharedPreferences.getInstance();

            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            if (prefs != null && res.body != null) {
              try {
                String token = jsonDecode(res.body)['token'];
                await prefs.setString('auth-token', token);
              } catch (e) {
                showSnackBar('Token not set.');
              }
            }

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

  // sign in user

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

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async{

          SharedPreferences prefs = await SharedPreferences.getInstance();

          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          if (prefs != null && res.body != null) {
            try {
              String token = jsonDecode(res.body)['token'];
              await prefs.setString('auth-token', token);
            } catch (e) {
              showSnackBar('Token not set.');
            }
          }
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
              (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  // get user data

  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth-token');

      if (token == null) {
        prefs.setString('auth-token', '');
      }

      var userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setToken(token!);
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  // logout user

  Future<void> logout(BuildContext context) async {

    final http.Response response = await http.get(
        Uri.parse('${Const.apiV1Url}/consumer/logout'),);

    if (response.statusCode == 200) {
    showSnackBar(jsonDecode(response.body)['message']);
    Navigator.of(context).pushNamedAndRemoveUntil(PhoneNumber.routeName, (route) => false);
    } else {
    throw Exception('Logout failed'); // Handle any error here
    }
  }
}
