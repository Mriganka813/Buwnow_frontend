import 'package:flutter/material.dart';
import 'package:buynow/custtomscreens/custtombutton.dart';
import 'package:buynow/screens/authscreen/otp.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late ColorNotifier notifier;
  String? _selectedindex;
  bool isChecked = false;
  final List<Map> _myjson = [
    {
      'id': '2',
      'image': 'assets/flagfour.png.png',
      'Text': "+92",
    },
    {
      'id': '3',
      'image': 'assets/flagthree.jpg',
      'Text': "+93",
    },
    {
      'id': '5',
      'image': 'assets/flagfive.png',
      'Text': "+95",
    }
  ];
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
            Stack(
              children: [
                Image.asset("assets/resetpassword.png"),
                Column(
                  children: [
                    SizedBox(height: height / 12),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          LanguageEn.forgot,
                          style: TextStyle(
                            color: notifier.getblackcolor,
                            fontSize: height / 25,
                            fontFamily: 'GilroyBold',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 80),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          LanguageEn.passwordreset,
                          style: TextStyle(
                            color: notifier.getblackcolor,
                            fontSize: height / 42,
                            fontFamily: 'GilroyMedium',
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.phonenumber,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 60),
            mobailnotextfild(),
            SizedBox(height: height / 2.1),
            GestureDetector(
              onTap: () {
                _showMyDialog();
              },
              child: button(
                notifier.getred,
                notifier.getwhite,
                LanguageEn.forgot,
                width / 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showMyDialog() async {
    return showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifier.getwhite,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: height / 3.6,
                child: Column(
                  children: [
                    SizedBox(height: height / 130),
                    Text(
                      LanguageEn.loginwithphonenumber,
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 60,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(height: height / 60),
                    Text(
                      "(+84) 39 787 5256",
                      style: TextStyle(
                        color: notifier.getblackcolor,
                        fontSize: height / 30,
                        fontFamily: 'GilroyBold',
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Text(
                      LanguageEn.wewillsend,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 60,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(height: height / 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: dailogbutton(Colors.transparent,
                              LanguageEn.cancel, notifier.getred),
                        ),
                        SizedBox(width: width / 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Otp(),
                              ),
                            );
                          },
                          child: dailogbutton(notifier.getred, LanguageEn.next,
                              notifier.getwhite),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        );
      },
    );
  }

  Widget dailogbutton(buttoncolor, txt, textcolor) {
    return Container(
      height: height / 16,
      width: width / 3.8,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        // border: Border.all(color: bordercolor),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
            color: textcolor,
            fontSize: height / 50,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }

  Widget mobailnotextfild() {
    return Container(
      height: height / 16,
      width: width / 1.1,
      decoration: BoxDecoration(
        color: notifier.getbgfildcolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: width / 100),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: notifier.getbgfildcolor,
              hint: Row(
                children: [
                  Image.asset("assets/flagfour.png.png", height: height / 25),
                  Text(
                    "+91",
                    style: TextStyle(color: notifier.getblackcolor),
                  )
                ],
              ),
              value: _selectedindex,
              onChanged: (newValue) {
                setState(() {
                  _selectedindex = newValue;
                });
              },
              items: _myjson.map((Map map) {
                return DropdownMenuItem<String>(
                  value: map["id"].toString(),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        map["image"].toString(),
                        width: 35,
                      ),
                      Text(
                        map["Text"].toString(),
                        style: TextStyle(color: notifier.getblackcolor),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Container(width: 1, height: height / 25, color: notifier.getgrey),
          SizedBox(width: width / 100),
          Container(
            color: Colors.transparent,
            height: 80,
            width: 190,
            child: TextField(
              style: TextStyle(color: notifier.getblackcolor),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 50,
                      fontFamily: 'GilroyMedium'),
                  border: InputBorder.none,
                  hintText: LanguageEn.enteryournumber),
            ),
          ),
        ],
      ),
    );
  }
}
