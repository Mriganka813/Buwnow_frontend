import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/custtomscreens/textfild.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  late ColorNotifier notifier;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

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
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getred,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: height / 13),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: height / 40,
                      color: notifier.getwhite,
                    ),
                  ),
                  SizedBox(width: width / 4),
                  Text(
                    LanguageEn.profilesetting,
                    style: TextStyle(
                      color: notifier.getwhite,
                      fontSize: height / 45,
                      fontFamily: 'GilroyBold',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      LanguageEn.done,
                      style: TextStyle(
                        color: notifier.getwhite,
                        fontSize: height / 45,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                  ),
                  SizedBox(width: width / 20),
                ],
              ),
              SizedBox(height: height / 6),
              // Image.asset("assets/p3.png"),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: notifier.getwhite,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: height / 5),
              Center(
                child: Image.asset(
                  "assets/p3.png",
                  height: height / 6.9,
                ),
              ),
              SizedBox(height: height/25),
              Customtextfild.textField(
                  "Mayur Bhai",
                  notifier.getblackcolor,
                  width / 1.13,
                  Icons.person,notifier.getbgfildcolor,
                firstNameController,
              ),
              SizedBox(height: height/25),
              Customtextfild.textField(
                  "Joshi",
                  notifier.getblackcolor,
                  width / 1.13,
                  Icons.person,notifier.getbgfildcolor,
                lastNameController,
              ),
              SizedBox(height: height/25),
              Customtextfild.textField(
                  "Joshi8bit@gmail.com",
                  notifier.getblackcolor,
                  width / 1.13,
                  Icons.email,notifier.getbgfildcolor,
                emailController,
              ),
              SizedBox(height: height/4.3),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: button(notifier.getred, notifier.getwhite, LanguageEn.save, width/1.1))
            ],
          ),

        ],
      ),
    );
  }
}
