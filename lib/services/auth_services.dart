import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/error_handling.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/screens/authscreen/phonenumber.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/search_screen/screens/search_screen.dart';

class AuthServices {
  // sign up user
  Future<void> signUpUser({
    required BuildContext context,
    required User user,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // buynow registration
      final http.Response res = await http.post(
          Uri.parse('${Const.apiV1Url}/consumer/register'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      // creating account in cute app
      final http.Response cuteSignup = await http.post(
        Uri.parse('http://65.0.7.20:8004/auth/signup'),
        body: {
          'username': user.name,
          'password': 'qwertyuiop',
          'roleType': 'CUSTOMER',
          'phoneNum': user.phoneNo,
          'address': user.address,
        },
      );

      print(cuteSignup.body);

      if (cuteSignup.statusCode == 200) {
        // signup verification
        final http.Response cuteVerify = await http.post(
            Uri.parse('http://65.0.7.20:8004/auth/signup/verify'),
            body: {'user_id': jsonDecode(cuteSignup.body)['user_id']});

        print(cuteVerify.body);
      } else {
        return;
      }

      print(cuteSignup.body);

      print(user);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            userProvider.setUser(res.body);
            userProvider.setId(jsonDecode(res.body)['user']['_id']);
            userProvider.setToken(jsonDecode(res.body)['token']);

            try {
              // store token and userId at signup
              String token = jsonDecode(res.body)['token'];
              String id = jsonDecode(res.body)['user']['_id'];
              await prefs.setString('auth-token', token);
              await prefs.setString('id', id);
            } catch (e) {
              showSnackBar('Token not set.');
            }

            Navigator.of(context).pushNamedAndRemoveUntil(
                SearchScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  // sign in user

  Future<void> signInUser({
    required BuildContext context,
    required User user,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final http.Response res = await http.post(
          Uri.parse('${Const.apiV1Url}/consumer/login'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          userProvider.setUser(res.body);
          userProvider.setId(jsonDecode(res.body)['user']['_id']);
          userProvider.setToken(jsonDecode(res.body)['token']);

          print(res.body);

          try {
            // store token and userId at login
            String id = jsonDecode(res.body)['user']['_id'];
            String token = jsonDecode(res.body)['token'];
            await prefs.setString('auth-token', token);
            await prefs.setString('id', id);
          } catch (e) {
            showSnackBar('Token not set.');
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
      // get token and userId for auto login
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth-token');
      String? id = prefs.getString('id');

      if (token == null) {
        prefs.setString('auth-token', '');
      }
      if (id == null) {
        prefs.setString('id', '');
      }

      var userProvider = Provider.of<UserProvider>(context, listen: false);

      userProvider.setToken(token!);
      userProvider.setId(id!);
    } catch (e) {
      // showSnackBar(e.toString());
    }
  }

  // logout user
  Future<void> logout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final http.Response response = await http.get(
      Uri.parse('${Const.apiV1Url}/consumer/logout'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userProvider.token}'
      },
    );

    if (response.statusCode == 200) {
      showSnackBar(jsonDecode(response.body)['message']);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(PhoneNumber.routeName, (route) => false);
    } else {
      showSnackBar('Logout failed');
      throw Exception('Logout failed'); // Handle any error here
    }
  }
}
