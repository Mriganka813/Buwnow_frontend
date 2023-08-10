import 'dart:convert';

import 'package:buynow/constants/error_handling.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/models/vehicle.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DeliveryServices {
  /// delivery charge calculation
  Future<List<Vehicle>> deliveryFairCharges(double pickupLat, double pickupLong,
      double dropLat, double dropLong, BuildContext context) async {
    final token = Provider.of<UserProvider>(context, listen: false).cuteToken;
    List<Vehicle> vehicles = [];

    print(pickupLat);
    print(pickupLong);
    print(dropLat);
    print(dropLong);

    try {
      final http.Response res = await http.get(
        Uri.parse(
            'http://65.0.7.20:8004/trips/info/newtrip?pickupLat=$pickupLat&dropLat=$dropLat&pickupLong=$pickupLong&dropLong=$dropLong'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print('res' + res.body);

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            final extractedData = jsonDecode(res.body)['output']['vehicles'];
            print('extractedData:' + extractedData.toString());
            for (Map element in extractedData) {
              vehicles.add(Vehicle.fromJson(element as Map<String, dynamic>));
            }
            print(extractedData.toString());
          });
    } catch (e) {
      showSnackBar(e.toString());
    }
    return vehicles;
  }
}
