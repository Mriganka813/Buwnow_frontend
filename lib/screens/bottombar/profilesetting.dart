import 'package:flutter/material.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/custtomscreens/custtombutton.dart';
import 'package:buynow/custtomscreens/textfild.dart';
import 'package:buynow/services/user_services.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetting extends StatefulWidget {
  static const routeName = '/profile-setting';

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  late ColorNotifier notifier;

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final UserServices userServices = UserServices();
  bool isLoading = false;

  Map<String, dynamic> map = {};

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
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  getUserData() async {
    setState(() {
      isLoading = true;
    });
    map = await userServices.getUserDetails(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getred,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
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
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //   },
                        //   child: Text(
                        //     LanguageEn.done,
                        //     style: TextStyle(
                        //       color: notifier.getwhite,
                        //       fontSize: height / 45,
                        //       fontFamily: 'GilroyMedium',
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(width: width / 20),
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height / 5),
                      Center(
                        child: Image.asset(
                          "assets/p3.png",
                          height: height / 6.9,
                        ),
                      ),
                      SizedBox(height: height / 25),

                      // show user name and user can update his name
                      Customtextfild.textField(
                          map['name'] ?? '',
                          notifier.getblackcolor,
                          width / 1.13,
                          Icons.person,
                          notifier.getbgfildcolor,
                          nameController,
                          false),
                      SizedBox(height: height / 25),
                      // Customtextfild.textField(
                      //     widget.phone,
                      //     notifier.getblackcolor,
                      //     width / 1.13,
                      //     Icons.phone,notifier.getbgfildcolor,
                      //     phoneController,
                      //     false
                      // ),
                      // SizedBox(height: height/25),

                      // show user email and user can update his email
                      Customtextfild.textField(
                          map['email'] ?? '',
                          notifier.getblackcolor,
                          width / 1.13,
                          Icons.email,
                          notifier.getbgfildcolor,
                          emailController,
                          false),
                      SizedBox(height: height / 4.3),

                      // update user name and email
                      GestureDetector(
                          onTap: () async {
                            final name = nameController.text.trim();
                            final email = emailController.text.trim();

                            if (name.isEmpty || email.isEmpty) {
                              showSnackBar(
                                  'Please fill all the fields or press back button');
                              return;
                            }
                            await userServices
                                .updateUserDetails(context, name, email)
                                .then((value) {
                              showSnackBar('updated');
                              Navigator.pop(context);
                            }).catchError((e) {
                              showSnackBar(e.toString());
                            });
                          },
                          child: button(notifier.getred, notifier.getwhite,
                              LanguageEn.save, width / 1.1))
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
