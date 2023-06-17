import 'package:flutter/material.dart';
import 'package:gofoods/screens/bottombar/bottombar.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnableLocation extends StatefulWidget {
  static const routeName = '/enable-location';
  const EnableLocation({Key? key}) : super(key: key);

  @override
  State<EnableLocation> createState() => _EnableLocationState();
}

class _EnableLocationState extends State<EnableLocation> {
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
      backgroundColor: notifier.getbgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 3.7),
            Image.asset("assets/enablelocation.png"),
            SizedBox(height: height / 10),
            Text(
              LanguageEn.enableyourlocation,
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 33,
                  fontFamily: 'GilroyBold'),
            ),
            SizedBox(height: height / 120),
            Text(
              LanguageEn.tosearchforthebest,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: notifier.getgrey,
                  fontSize: height / 50,
                  fontFamily: 'GilroyMedium'),
            ),
            SizedBox(height: height / 8.5),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomHome(),
                  ),
                );
              },
              child: locationbutton(notifier.getred, notifier.getwhite,
                  LanguageEn.usecurrentlocation, width / 1.13),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomHome(),
                  ),
                );
              },
              child: locationbutton(Colors.transparent, notifier.getgrey,
                  LanguageEn.skipfornow, width / 1.13),
            )
          ],
        ),
      ),
    );
  }

  Widget locationbutton(buttoncolor, buttontextcolor, txt, w) {
    return Container(
      height: height / 14,
      width: w,
      decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on_outlined,
              size: height / 32, color: notifier.getwhite),
          SizedBox(width: width / 100),
          Text(
            txt,
            style: TextStyle(
                color: buttontextcolor,
                fontSize: height / 50,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
