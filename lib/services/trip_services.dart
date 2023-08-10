import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/const.dart';
import '../constants/utils.dart';
import '../models/new_trip_input.dart';
import '../models/trip_order.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TripServices {
  /// get all trips
  Future<List<TripOrder>> getAllTrips(String orderType) async {
    List<TripOrder> order = [];
    List<TripOrder> _waitingorder = [];
    List<TripOrder> _pastorder = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('cuteToken')!;
    print(token);

    await http.get(
      Uri.parse('http://65.0.7.20:8004/trips/info'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    ).then((value) {
      print(value.body);

      var res = jsonDecode(value.body)['trips'];

      for (var i = 0; i < res.length; i++) {
        if (res[i]['status'] == "WAITING FOR DRIVER" ||
            res[i]['status'] == "CONFIRMED" ||
            res[i]['status'] == "STARTED") {
          _waitingorder.add(TripOrder.fromMap(res[i]));
          // final _waitingorder = Order.waiting(value.data['trips'][i]);
        } else if (res[i]['status'] == "COMPLETED") {
          _pastorder.add(TripOrder.fromMap(res[i]));
          // final _pastorder = Order.fromMap(value.data['trips'][i]);
        }
      }
      order = orderType == "activeOrder" ? _waitingorder : _pastorder;
      order = order.reversed.toList();
    }).onError((error, stackTrace) {
      print(error);
      showSnackBar('No trips available');
      throw "No trips Available";
    });
    return order;
  }

  /// create new trip
  newTrip({
    required NewTripInput input,
    required String cuteToken,
  }) async {
    print(cuteToken);
    print(input.toMap());

    try {
      final http.Response res = await http.post(
          Uri.parse('http://65.0.7.20:8004/trips/confirmed/newtrip'),
          body: json.encode(input.toMap()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${cuteToken}",
          });
      print(res.body);

      // Map<String, dynamic> data = json.decode(res.body);

      // tripId = data['trip']['_id'];

      // print(tripId);
    } catch (e) {
      print(e.toString());
      showSnackBar(e.toString());
    }
    // start socket for very first time to update socket id to database

    IO.Socket socket = IO.io(Const.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'query': {'accessToken': 'Bearer ${cuteToken}', 'role': 'CUSTOMER'}
    });

    // success
    socket.on('success', (data) {
      print(data);
    });
  }
}
