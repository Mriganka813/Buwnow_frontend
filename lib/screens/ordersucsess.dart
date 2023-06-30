import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/screens/bottombar/bottombar.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSucsess extends StatefulWidget {
  static const routeName = '/order-success';
  const OrderSucsess({Key? key}) : super(key: key);

  @override
  State<OrderSucsess> createState() => _OrderSucsessState();
}

class _OrderSucsessState extends State<OrderSucsess> {
  late ColorNotifier notifier;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getwhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 8),
            Center(
              child: Text(
                LanguageEn.checking,
                style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 38,
                  fontFamily: 'GilroyBold',
                ),
              ),
            ),
            SizedBox(height: height / 13),
            Image.asset("assets/Deliveryscooter.png", height: height / 3),
            SizedBox(height: height / 20),
            Text(
              LanguageEn.ordersuccess,
              style: TextStyle(
                color: notifier.getblackcolor,
                fontSize: height / 36,
                fontFamily: 'GilroyBold',
              ),
            ),
            SizedBox(height: height / 90),
            Text(
              LanguageEn.pleasewaitafewminute,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: notifier.getgrey,
                fontSize: height / 55,
                fontFamily: 'GilroyMedium',
              ),
            ),
            SizedBox(height: height / 10),
            // GestureDetector(
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //     builder: (context) => const MyOrder(),
            //     //   ),
            //     // );
            //   },
            //   child: Container(
            //     height: height / 14,
            //     width: width / 1.1,
            //     decoration: BoxDecoration(
            //       border: Border.all(color: notifier.getred),
            //       borderRadius: const BorderRadius.all(
            //         Radius.circular(13),
            //       ),
            //     ),
            //     child: Center(
            //       child: Text(
            //         LanguageEn.myorder,
            //         style: TextStyle(
            //           color: notifier.getred,
            //           fontFamily: 'GilroyBold',
            //           fontSize: height / 50,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: height / 50),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomHome(),
                    ),
                  );
                },
                child: button(notifier.getred, notifier.getwhite,
                    LanguageEn.home, width / 1.1))
          ],
        ),
      ),
    );
  }
}
