import 'package:flutter/material.dart';
import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class AddressServices {
  // add address of current order
  addAddress({
    required BuildContext context,
    required String city,
    required String state,
    required String phoneNo,
    required String pincode,
    required String street,
    required String additional,
    required String latitude,
    required String longitude,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final http.Response res = await http.post(
        Uri.parse('${Const.apiV1Url}/consumer/add/address'),
        body: {
          'state': state,
          'city': city,
          'phoneNumber': phoneNo,
          'pinCode': pincode,
          'streetAddress': street,
          'additionalInfo': additional,
          'landmark': '',
          'latitude': latitude,
          'longitude': longitude,
        },
        headers: {'Authorization': '${userProvider.token}'},
      );

      print(res.statusCode);
      print(res.body);
    } catch (e) {
      showSnackBar(e.toString());
    }
  }
}
