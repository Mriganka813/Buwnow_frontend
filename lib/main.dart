import 'dart:io';

import 'package:buynow/screens/authscreen/phonenumber.dart';
import 'package:buynow/services/background_service.dart';
import 'package:buynow/services/push_notification.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:buynow/router.dart';
import 'package:buynow/screens/search_screen/screens/search_screen.dart';
import 'package:buynow/services/auth_services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:in_app_update/in_app_update.dart';

import 'package:provider/provider.dart';

import 'utils/notifirecolor.dart';

Future<void> backgroungHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroungHandler);

  // set device orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // set status bar color
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));

  // initialize notification
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse: (details) {
      print(details.payload);
      print(details.notificationResponseType.name);
    },
  );

  PushNotifications.initialize;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ColorNotifier()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ColorNotifier notifier;
  AuthServices authServices = AuthServices();
  String? test;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  // check for update
  Future<void> checkForUpdate() async {
    final update = await InAppUpdate.checkForUpdate();
    if (update.updateAvailability == UpdateAvailability.updateNotAvailable) {
      return;
    }
    // if (update.immediateUpdateAllowed) {
    //   await InAppUpdate.startFlexibleUpdate();
    //   await InAppUpdate.completeFlexibleUpdate();
    //   return;
    // }
    await InAppUpdate.performImmediateUpdate();

    showUpdateRequiredDialog();
  }

  void showUpdateRequiredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        height = MediaQuery.of(context).size.height;
        return AlertDialog(
          backgroundColor: notifier.getbgcolor,
          title: Text(
            'Update Required',
            style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 30,
              fontFamily: 'GilroyBold',
            ),
          ),
          content: Text('Please update the app to continue using it.'),
          actions: [
            TextButton(
              child: Text('Exit App'),
              onPressed: () {
                Navigator.of(context).pop();
                // exit(0);
                // You might want to exit the app here.
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buynow',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
      onGenerateRoute: (settings) => generateRoute(settings),
      home: FutureBuilder(
          future: authServices.getUserData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // check token is empty or not
            return Provider.of<UserProvider>(context).token!.isNotEmpty
                ? SearchScreen()
                : PhoneNumber();
          }),
    );
  }
}
