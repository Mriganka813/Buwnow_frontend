import 'dart:async';

import 'dart:ui';

import 'package:buynow/models/new_trip_input.dart';
import 'package:buynow/models/order.dart';
import 'package:buynow/models/order_history.dart';
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
    List<OrderHistory> latestOrder = [];
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

    List<String> pendingOrder = [];

    latestOrder = await orderServices.orderHistory();
    print('latestorder' + latestOrder.toString());

    int orderAmount = 0;
    bool isPaid = true;
    String? orderId;

    for (int i = 0; i < latestOrder.length; i++) {
      for (int j = 0; j < latestOrder[i].recentOrders!.items!.length; j++) {
        if (latestOrder[i].recentOrders!.items![j].status == 'pending') {
          pendingOrder.add(latestOrder[i].recentOrders!.sId!);
          final prodPrice = latestOrder[i].recentOrders!.items![j].productPrice;
          orderAmount += prodPrice!;
          isPaid = latestOrder[i].recentOrders!.isPaid!;
          orderId = latestOrder[i].recentOrders!.sId;
        }
      }
    }

    //check isPaid status

    final upi = prefs.getString('upi') ?? '6388415501@ybl';
    final businessName = prefs.getString('businessName') ?? '';

    newTrip = NewTripInput(
      pickuplocation: {'lat': sellerLat, 'long': sellerLong},
      droplocatioon: {'lat': consumerLat, 'long': consumerLong},
      price: price,
      serviceAreaId: serviceAreaId,
      vehicleId: vehicleId,
      upi: upi,
      businessName: businessName,
      orderId: orderId,
      amount: orderAmount,
      isPaid: isPaid,
    );

    // check whether order is confirmed

    for (int i = 0; i < latestOrder.length; i++) {
      if (pendingOrder.contains(latestOrder[i].recentOrders!.sId) &&
          latestOrder[i].recentOrders!.items![0].status == 'confirmed') {
        await trip.newTrip(
          input: newTrip,
          cuteToken: cuteToken!,
        );

        await showNotification('Your order has accepted');
      } else if (pendingOrder.contains(latestOrder[i]) &&
          latestOrder[0].recentOrders!.items![0].status == 'rejected') {
        await showNotification('Your order has rejected');
      }
    }
    if (pendingOrder.isEmpty) {
      timer.cancel();
      service.stopSelf();
    }

    print('buynow background service running');
  });
}

Future<void> showNotification(String msg) async {
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
    msg, // Notification body
    platformChannelSpecifics,

    payload: 'Custom_Payload', // Custom payload (optional)
  );
}
