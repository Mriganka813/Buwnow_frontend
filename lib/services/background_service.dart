import 'dart:async';

import 'dart:ui';

import 'package:buynow/models/new_trip_input.dart';
import 'package:buynow/models/order.dart';
import 'package:buynow/services/cute_services.dart';

import 'package:buynow/services/order_services.dart';
import 'package:buynow/services/trip_services.dart';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
        onStart: onStart, isForegroundMode: true, autoStart: true),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsBackgroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(Duration(seconds: 10), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: 'Buynow', content: 'Waiting for order confirmation');
      }
    }

    //
    List<Order> latestOrder = [];
    OrderServices orderServices = OrderServices();
    TripServices trip = TripServices();
    NewTripInput newTrip = NewTripInput();
    CuteServices cuteServices = CuteServices();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final cuteToken = prefs.getString('cuteToken');

    Timer.periodic(Duration(minutes: 15), (timer) async {
      await cuteServices.getNewToken();
    });

    final sellerLat = prefs.getString('lat');
    final sellerLong = prefs.getString('long');
    final consumerLat = prefs.getString('consumerLat');
    final consumerLong = prefs.getString('consumerLong');
    final serviceAreaId = prefs.getString('serviceAreaId');
    final vehicleId = prefs.getString('vehicleId');
    final price = prefs.getDouble('price');

    print(sellerLat);
    print(sellerLong);
    print(consumerLat);
    print(consumerLong);
    print(serviceAreaId);
    print(vehicleId);
    print(price);

    newTrip = NewTripInput(
        pickuplocation: {'lat': sellerLat, 'long': sellerLong},
        droplocatioon: {'lat': consumerLat, 'long': consumerLong},
        price: price,
        serviceAreaId: serviceAreaId,
        vehicleId: vehicleId);

    latestOrder = await orderServices.orderHistory();
    print('latestorder' + latestOrder.toString());

    // calculate order products price

    int orderAmount = 0;

    for (int i = 0; i < latestOrder[0].items!.length; i++) {
      final prodPrice = latestOrder[0].items![i].productPrice;
      orderAmount += prodPrice!;
    }

    //check isPaid status

    bool isPaid = latestOrder[0].isPaid ?? true;
    final upi = prefs.getString('upi') ?? '6388415501@ybl';

    // check whether order is confirmed

    if (latestOrder[0].items![0].status == 'confirmed') {
      await trip.newTrip(
          input: newTrip,
          cuteToken: cuteToken!,
          amount: orderAmount,
          status: isPaid,
          orderId: latestOrder[0].sId!,
          upi: upi);

      // await trip.sendTripInfoForUPI(
      //     tripId, orderAmount, isPaid, upi, latestOrder[0].sId!, cuteToken);

      await showNotification();
      timer.cancel();
      service.stopSelf();
    } else if (latestOrder[0].items![0].status == 'rejected') {
      timer.cancel();
      service.stopSelf();
    }

    print('buynow background service running');
  });
}

Future<void> showNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id', // Replace with your channel ID
    'your_channel_name', // Replace with your channel name

    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID (optional)
    'BuyNow', // Notification title
    'Your order has accepted', // Notification body
    platformChannelSpecifics,

    payload: 'Custom_Payload', // Custom payload (optional)
  );
}
