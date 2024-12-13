import 'package:flutter/material.dart';
import 'package:buynow/custtomscreens/custtompopularfoodlist.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopularViewMore extends StatefulWidget {
  const PopularViewMore({Key? key}) : super(key: key);

  @override
  State<PopularViewMore> createState() => _PopularViewMoreState();
}

class _PopularViewMoreState extends State<PopularViewMore> {
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
      appBar: AppBar(
        backgroundColor: notifier.getwhite,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: notifier.getblackcolor,
            size: height / 30,
          ),
        ),
        title: Text(
          LanguageEn.popularnearyou,
          style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 45,
              fontFamily: 'GilroyBold'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CusttomPopularfoodlist(
                  "assets/bfood.jpg",
                  height / 3,
                  width / 1.1,
                  height / 5,
                  width / 1.1,
                  width / 3,
                  LanguageEn.burgerking),
            ),
            SizedBox(height: height / 60),
            Center(
              child: CusttomPopularfoodlist(
                  "assets/cake.jpg",
                  height / 3,
                  width / 1.1,
                  height / 5,
                  width / 1.1,
                  width / 3,
                  LanguageEn.atul),
            ),
            SizedBox(height: height / 60),
            Center(
              child: CusttomPopularfoodlist(
                  "assets/bfood.jpg",
                  height / 3,
                  width / 1.1,
                  height / 5,
                  width / 1.1,
                  width / 3,
                  LanguageEn.mayo),
            ),
            SizedBox(height: height / 60),
            Center(
              child: CusttomPopularfoodlist(
                  "assets/cake.jpg",
                  height / 3,
                  width / 1.1,
                  height / 5,
                  width / 1.1,
                  width / 3,
                  LanguageEn.monginis),
            ),
            SizedBox(height: height / 60),
          ],
        ),
      ),
    );
  }
}
