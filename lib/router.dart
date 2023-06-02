

import 'package:flutter/material.dart';
import 'package:gofoods/screens/authscreen/createaccount.dart';
import 'package:gofoods/screens/authscreen/phonenumber.dart';
import 'package:gofoods/screens/bottombar/profile.dart';
import 'package:gofoods/screens/enablelocation.dart';
import 'package:gofoods/screens/home.dart';
import 'package:gofoods/screens/orderconfirmation.dart';
import 'package:gofoods/screens/yourorder/yourorder.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case CreateAccount.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CreateAccount());

    case PhoneNumber.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PhoneNumber());

    case HomePage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomePage());

    case YourOrder.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const YourOrder());

    case OrderConformation.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderConformation());

    case Profile.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Profile());

    case EnableLocation.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => EnableLocation());

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
              body: Center(
                child: Text('Screen does not exist'),
              )));
  }
}
