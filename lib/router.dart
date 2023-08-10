import 'package:buynow/screens/order_details/screens/order_details_screen.dart';
import 'package:buynow/screens/ordertabs/pay_now.dart';
import 'package:buynow/screens/payment_details/screens/payment_details_screen.dart';
import 'package:buynow/screens/payment_details/screens/show_qr_screen.dart';
import 'package:buynow/screens/specific_shop/screens/show_all_products.dart';
import 'package:flutter/material.dart';
import 'package:buynow/screens/authscreen/createaccount.dart';
import 'package:buynow/screens/authscreen/phonenumber.dart';
import 'package:buynow/screens/bottombar/profile.dart';
import 'package:buynow/screens/bottombar/profilesetting.dart';
import 'package:buynow/screens/enablelocation.dart';
import 'package:buynow/screens/home_page/screens/home.dart';
import 'package:buynow/screens/homeseeall/explorecategories.dart';
import 'package:buynow/screens/homeseeall/nearbyrestorent.dart';
import 'package:buynow/screens/homeseeall/recommendedshowall.dart';
import 'package:buynow/screens/order_confirmation.dart/screens/orderconfirmation.dart';
import 'package:buynow/screens/ordersucsess.dart';
import 'package:buynow/screens/search_screen/screens/search_product_list_screen.dart';
import 'package:buynow/screens/search_screen/screens/search_products_details_screen.dart';
import 'package:buynow/screens/search_screen/screens/search_screen.dart';
import 'package:buynow/screens/track_order/screens/track_order_screen.dart';
import 'package:buynow/screens/yourorder/adress.dart';
import 'package:buynow/screens/yourorder/deliveryadrees.dart';
import 'package:buynow/screens/yourorder/yourorder.dart';

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

    // case RestorentDeal.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => RestorentDeal());

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

    case TrackOrderScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => TrackOrderScreen());

    case OrderDetailsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => OrderDetailsScreen());

    case PayNow.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => PayNow());

    case ShowQRScreen.routeName:
      final args = routeSettings.arguments as Map<String, dynamic>;
      final name = args['name'];
      final phone = args['phone'];
      final additional = args['phone'];

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ShowQRScreen(
                name: name,
                phone: phone,
                additional: additional,
              ));

    case SpecificAllProductScreen.routeName:
      final args = routeSettings.arguments as Map<String, dynamic>;
      final shopId = args['id'];
      final shopName = args['name'];
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SpecificAllProductScreen(shopId, shopName));

    case PaymentDetailsScreen.routeName:
      final args = routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => PaymentDetailsScreen(
                name: args['name'],
                phoneNo: args['phone'],
                additional: args['additional'],
              ));

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text('Screen does not exist'),
              )));
  }
}
