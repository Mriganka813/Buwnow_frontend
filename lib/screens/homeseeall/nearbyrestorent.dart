import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtomrestorent.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NearByRestorent extends StatefulWidget {
  const NearByRestorent({Key? key}) : super(key: key);

  @override
  State<NearByRestorent> createState() => _NearByRestorentState();
}

class _NearByRestorentState extends State<NearByRestorent> {

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
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(backgroundColor: notifier.getwhite,
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
          LanguageEn.nearbyrestorent,
          style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 45,
              fontFamily: 'GilroyBold'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: height/50),
              CusttomRestorent("assets/foodmenu.png",
                  LanguageEn.savorbread, LanguageEn.banhmimilk),
              SizedBox(height: height / 50),
              CusttomRestorent("assets/burgerking.png",
                  LanguageEn.burgerkingg, LanguageEn.vietnamese),
              SizedBox(height: height / 50),
              CusttomRestorent("assets/papajogn.png",
                  LanguageEn.papajohn, LanguageEn.banhmimilk),
              SizedBox(height: height / 50),
              CusttomRestorent("assets/todayfoodmenu.png",
                  LanguageEn.cocahouse, LanguageEn.vietnamese),
              SizedBox(height: height / 50),
              CusttomRestorent("assets/foodmenu.png",
                  LanguageEn.savorbread, LanguageEn.banhmimilk),
              SizedBox(height: height / 50),
              CusttomRestorent("assets/burgerking.png",
                  LanguageEn.burgerkingg, LanguageEn.vietnamese),
              SizedBox(height: height / 50),
              CusttomRestorent("assets/papajogn.png",
                  LanguageEn.papajohn, LanguageEn.banhmimilk),
              SizedBox(height: height / 50),
              CusttomRestorent("assets/todayfoodmenu.png",
                  LanguageEn.cocahouse, LanguageEn.vietnamese),
              SizedBox(height: height / 50),
            ],
          ),
        ),
      ),
    );
  }
}
