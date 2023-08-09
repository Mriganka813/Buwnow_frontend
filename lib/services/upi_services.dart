import 'dart:convert';

import 'package:buynow/constants/const.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/models/upi.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UPIServices {
  Future<UPIModel> getUpiDetails(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print(userProvider.token);
    UPIModel upiData = UPIModel();
    try {
      final http.Response res = await http.get(
        Uri.parse('${Const.apiV1Url}/getupi/${userProvider.sellerId}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(res.body);

      final extractedData = jsonDecode(res.body);
      upiData = UPIModel.fromJson(extractedData as Map<String, dynamic>);
      print(upiData.businessName);
      if (upiData.success == false) {
        showSnackBar('Upi id is not available');
      }
    } catch (e) {
      showSnackBar(e.toString());
    }
    return upiData;
  }
}
