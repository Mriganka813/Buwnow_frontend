import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/enstring.dart';
import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';

class HelpCenterScreen extends StatefulWidget {
  static const routeName = '/help-center';
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.getwhite,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,
              color: notifier.getblackcolor, size: height / 50),
        ),
        centerTitle: true,
        title: Text(
          LanguageEn.helpcenter,
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Feel free to Contact us',
          style: TextStyle(
              color: notifier.getblackcolor,
              fontFamily: 'GilroyBold',
              fontSize: height / 50),
        ),
        SizedBox(
          height: height / 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email:',
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontFamily: 'GilroyBold',
                  fontSize: height / 50),
            ),
            SelectableText(
              ' info@getcube.shop',
              style: TextStyle(
                  color: notifier.getred,
                  fontFamily: 'GilroyBold',
                  fontSize: height / 50),
            ),
          ],
        ),
        SizedBox(
          height: height / 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Phone: ',
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontFamily: 'GilroyBold',
                  fontSize: height / 50),
            ),
            SelectableText(
              '+916000637319',
              style: TextStyle(
                  color: notifier.getred,
                  fontFamily: 'GilroyBold',
                  fontSize: height / 50),
            ),
          ],
        ),
      ]),
    );
  }
}
