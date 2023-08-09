import 'package:buynow/screens/authscreen/phonenumber.dart';
import 'package:buynow/services/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:buynow/router.dart';
import 'package:buynow/screens/search_screen/screens/search_screen.dart';
import 'package:buynow/services/auth_services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:provider/provider.dart';

import 'utils/notifirecolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// set device orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// set status bar color
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));

  /// initialize notification
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse: (details) {
      print(details.payload);
      print(details.notificationResponseType.name);
    },
  );

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
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoFoods',
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
            return Provider.of<UserProvider>(context).token!.isNotEmpty
                ? SearchScreen()
                : PhoneNumber();
          }),
    );
  }
}
