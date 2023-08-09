import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_services.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ColorNotifier notifier;
  final AuthServices authServices = AuthServices();

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

  void logout() async {
    showSnackBar('logging out...');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth-token');
    await prefs.remove('id');
    authServices.logout(context);
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
            SizedBox(height: height / 11),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.myprofile,
                  style: TextStyle(
                    color: notifier.getblackcolor,
                    fontSize: height / 22,
                    fontFamily: 'GilroyBold',
                  ),
                )
              ],
            ),
            SizedBox(height: height / 20),
            GestureDetector(
              child: profiletype("assets/Bag.png", LanguageEn.myporder),
            ),
            SizedBox(height: height / 30),
            GestureDetector(
              child:
                  profiletype("assets/Setting.png", LanguageEn.profilesetting),
            ),
            SizedBox(height: height / 30),
            GestureDetector(
              child: profiletype(
                  "assets/Ticket.png", LanguageEn.discountsandpromocodes),
            ),
            SizedBox(height: height / 30),
            GestureDetector(
              child: profiletype(
                  "assets/Notification.png", LanguageEn.notifications),
            ),
            SizedBox(height: height / 30),
            GestureDetector(
                child:
                    profiletype("assets/invite.png", LanguageEn.invitefriend)),
            SizedBox(height: height / 30),
            GestureDetector(
                child: profiletype("assets/about.png", LanguageEn.aboutus)),
            SizedBox(height: height / 30),
            GestureDetector(
                child: profiletype("assets/Paper.png", LanguageEn.faq)),
            SizedBox(height: height / 30),
            GestureDetector(
                child: profiletype(
                    "assets/teams.png", LanguageEn.teamsandcontiotion)),
            SizedBox(height: height / 30),
            GestureDetector(
                child: profiletype("assets/Call.png", LanguageEn.helpcenter)),
            SizedBox(height: height / 30),
            darkmode(),
            SizedBox(height: height / 30),
            GestureDetector(
              onTap: logout,
              child: profiletype("assets/Logout.png", LanguageEn.logout),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Widget profiletype(icon, txt) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 13),
          Image.asset(
            icon,
            height: height / 33,
            color: notifier.getred,
          ),
          SizedBox(width: width / 20),
          Text(
            txt,
            style: TextStyle(
              fontSize: height / 50,
              fontFamily: 'GilroyMedium',
              color: notifier.getblackcolor,
            ),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,
              size: height / 40, color: notifier.getgrey),
          SizedBox(width: width / 13),
        ],
      ),
    );
  }

  Widget darkmode() {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 13),
          Image.asset(
            "assets/darkmode.png",
            height: height / 33,
            color: notifier.getred,
          ),
          SizedBox(width: width / 20),
          Text(
            LanguageEn.darkmode,
            style: TextStyle(
              fontSize: height / 50,
              fontFamily: 'GilroyMedium',
              color: notifier.getblackcolor,
            ),
          ),
          const Spacer(),
          SizedBox(width: width / 13),
        ],
      ),
    );
  }
}
