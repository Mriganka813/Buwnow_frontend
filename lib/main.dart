import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofoods/providers/user_provider.dart';
import 'package:gofoods/router.dart';
import 'package:gofoods/screens/admin_screen/admin_screen.dart';
import 'package:gofoods/screens/bottombar/bottombar.dart';
import 'package:gofoods/screens/onbonding/onbonding.dart';
import 'package:gofoods/screens/search_screen/search_screen.dart';
import 'package:gofoods/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'utils/notifirecolor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ColorNotifier()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AuthServices authServices = AuthServices();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GoFoods',
        onGenerateRoute: (settings) => generateRoute(settings),
        home: FutureBuilder(
          future: authServices.getUserData(context),
          builder:(context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child:CircularProgressIndicator());
            }
            return Provider.of<UserProvider>(context).token!.isNotEmpty
                ? Provider.of<UserProvider>(context).user.role == 'user'
                ? SearchScreen()
                : const AdminScreen()
                : Onbonding();

          }
        ),
    );
  }
}
