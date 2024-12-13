import 'package:flutter/material.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
      body: Padding(
        padding: EdgeInsets.only(left: width / 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height / 50),
            tags("assets/idli.png", LanguageEn.idle),
            SizedBox(height: height / 100),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Divider(color: notifier.getgrey),
            ),
            SizedBox(height: height / 100),
            tags("assets/supcup.png", LanguageEn.sup),
            SizedBox(height: height / 100),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Divider(color: notifier.getgrey),
            ),
            SizedBox(height: height / 100),
            tags("assets/juice.png", LanguageEn.juice),
            SizedBox(height: height / 100),
          ],
        ),
      ),
    );
  }

  Widget tags(icon, txt) {
    return Row(
      children: [
        Image.asset(icon, height: height / 18),
        SizedBox(width: width / 40),
        Text(
          txt,
          style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 60,
              fontFamily: 'GilroyMedium'),
        )
      ],
    );
  }
}
