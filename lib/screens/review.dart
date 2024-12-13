import 'package:flutter/material.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
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
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(height: height / 40),
          review("assets/p3.png", LanguageEn.harrydaniels),
          SizedBox(height: height / 100),
          review("assets/p4.png", LanguageEn.harrydaniels),
        ],
      ),
    );
  }

  Widget review(image, name) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: height / 10,
        width: width / 1.2,
        decoration: BoxDecoration(
          color: notifier.getbgfildcolor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: width / 30),
            Image.asset(image, height: height / 15),
            SizedBox(width: width / 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 60),
                Text(
                  name,
                  style: TextStyle(
                      color: notifier.getblackcolor,
                      fontSize: height / 55,
                      fontFamily: 'GilroyBold'),
                ),
                Row(
                  children: [
                    Icon(Icons.star,
                        size: height / 40, color: notifier.getstarcolor),
                    Icon(Icons.star,
                        size: height / 40, color: notifier.getstarcolor),
                    Icon(Icons.star,
                        size: height / 40, color: notifier.getstarcolor),
                    Icon(Icons.star,
                        size: height / 40, color: notifier.getstarcolor),
                  ],
                ),
                SizedBox(height: height / 100),
                Text(
                  "29x.53618 - Lamborgini",
                  style: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 60,
                      fontFamily: 'GilroyMedium'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
