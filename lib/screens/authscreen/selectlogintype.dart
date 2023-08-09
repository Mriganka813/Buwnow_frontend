import 'package:flutter/material.dart';
import 'package:buynow/screens/authscreen/phonenumber.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLogin extends StatefulWidget {
  const SelectLogin({Key? key}) : super(key: key);

  @override
  State<SelectLogin> createState() => _SelectLoginState();
}

class _SelectLoginState extends State<SelectLogin> {
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
      backgroundColor: notifier.getred,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 1.77),
            Container(
              height: height / 2.3,
              width: width,
              decoration: BoxDecoration(
                color: notifier.getwhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: height / 30),
                  Row(
                    children: [
                      SizedBox(width: width / 15),
                      Text(
                        "Hi, Nice to Meet You!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: height / 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 70),
                  Row(
                    children: [
                      SizedBox(width: width / 15),
                      Text(
                        "We've tried to find a way to add more\nfeedback and dynamics into process",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: height / 52,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 30),
                  conectiontype(notifier.getred, Icons.phone,
                      "Connect with Phone Number"),
                  SizedBox(height: height / 80),
                  conectiontype(const Color(0xff3c599a), Icons.facebook,
                      "Connect With Facebook"),
                  SizedBox(height: height / 80),
                  conectiontype(const Color(0xff518df9), Icons.g_mobiledata,
                      "Connect With Google"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget conectiontype(color, icon, txt) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PhoneNumber()
              // Otp()
              ),
        );
      },
      child: Container(
        height: height / 15,
        width: width / 1.15,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: width / 20),
            Icon(icon, color: notifier.getwhite),
            SizedBox(width: width / 20),
            Text(
              txt,
              style: TextStyle(
                  color: notifier.getwhite,
                  fontWeight: FontWeight.bold,
                  fontSize: height / 55),
            )
          ],
        ),
      ),
    );
  }
}
