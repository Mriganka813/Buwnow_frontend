import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/screens/enablelocation.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otp extends StatefulWidget {
  static const routeName = '/otp-screen';
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
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
      body: Column(
        children: [
          SizedBox(height: height / 6),
          Row(
            children: [
              SizedBox(width: width / 20),
              Text(
                LanguageEn.verificationcodeotp,
                style: TextStyle(
                    color: notifier.getblackcolor,
                    fontSize: height / 35,
                    fontFamily: 'GilroyBold'),
              ),
            ],
          ),
          SizedBox(height: height / 60),
          Row(
            children: [
              SizedBox(width: width / 20),
              Text(
                LanguageEn.averificationcodeshasbeensendto,
                style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium'),
              ),
            ],
          ),
          SizedBox(height: height / 100),
          Row(
            children: [
              SizedBox(width: width / 20),
              Text(
                "(+84)39 787 5256",
                style: TextStyle(
                  fontFamily: 'GilroyBold',
                  color: notifier.getblackcolor,
                  fontSize: height / 50,
                ),
              ),
            ],
          ),
          SizedBox(height: height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              otpfild(),
              otpfild(),
              otpfild(),
              otpfild(),
            ],
          ),
          SizedBox(height: height / 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EnableLocation(),
                ),
              );
            },
            child: button(
              notifier.getred,
              notifier.getwhite,
              LanguageEn.next,
              width / 1.13,
            ),
          ),
          SizedBox(height: height / 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LanguageEn.dontreceivedthecode,
                style: TextStyle(
                    color: notifier.getgrey, fontFamily: 'GilroyMedium'),
              ),
              SizedBox(width: width / 200),
              Text(
                "Resend(42 S)",
                style: TextStyle(
                    color: notifier.getred, fontFamily: 'GilroyMedium'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget otpfild() {
    return Container(
      height: height / 15,
      width: width / 5,
      decoration:   BoxDecoration(
        color: notifier.getbgfildcolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: height / 40,
            color: notifier.getblackcolor,
            fontFamily: 'Gilroy Bold'),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
