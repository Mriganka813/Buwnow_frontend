import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofoods/router.dart';
import 'package:gofoods/screens/onbonding/onbonding.dart';
import 'package:provider/provider.dart';

import 'utils/notifirecolor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ColorNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Onbonding(),
      ),
    );
  }
}
