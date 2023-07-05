import 'package:flutter/material.dart';
import 'package:gofoods/screens/authscreen/createaccount.dart';
import 'package:gofoods/screens/authscreen/phonenumber.dart';
import 'package:gofoods/screens/bottombar/profile.dart';
import 'package:gofoods/screens/bottombar/profilesetting.dart';
import 'package:gofoods/screens/enablelocation.dart';
import 'package:gofoods/screens/home_page/screens/home.dart';
import 'package:gofoods/screens/homeseeall/explorecategories.dart';
import 'package:gofoods/screens/homeseeall/nearbyrestorent.dart';
import 'package:gofoods/screens/homeseeall/recommendedshowall.dart';
import 'package:gofoods/screens/order_confirmation.dart/screens/orderconfirmation.dart';
import 'package:gofoods/screens/ordersucsess.dart';
import 'package:gofoods/screens/restorentdeal.dart';
import 'package:gofoods/screens/search_screen/screens/search_product_list_screen.dart';
import 'package:gofoods/screens/search_screen/screens/search_products_details_screen.dart';
import 'package:gofoods/screens/search_screen/screens/search_screen.dart';
import 'package:gofoods/screens/track_order.dart';
import 'package:gofoods/screens/yourorder/adress.dart';
import 'package:gofoods/screens/yourorder/deliveryadrees.dart';
import 'package:gofoods/screens/yourorder/yourorder.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case CreateAccount.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CreateAccount());

    case PhoneNumber.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PhoneNumber());

    case SearchScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => SearchScreen());

    case HomePage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => HomePage());

    case YourOrder.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const YourOrder());

    case OrderConformation.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => OrderConformation());

    case Profile.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Profile());

    case EnableLocation.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => EnableLocation());

    case SearchProductListScreen.routeName:
      final title = routeSettings.arguments as String;

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchProductListScreen(
                title: title,
              ));

    case RecommendedSeeall.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => RecommendedSeeall());

    case ProfileSetting.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => ProfileSetting());

    case SearchProductDetailsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchProductDetailsScreen());

    case RestorentDeal.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => RestorentDeal());

    case Categories.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Categories());

    case NearByRestorent.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => NearByRestorent());

    case OrderSucsess.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => OrderSucsess());

    case AddressUpdates.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AddressUpdates());

    case Address.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => Address());

    case TrackOrder.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => TrackOrder());

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text('Screen does not exist'),
              )));
  }
}
