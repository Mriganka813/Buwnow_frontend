import 'package:flutter/material.dart';
import 'package:gofoods/screens/restorentdeal.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CusttomRestorent extends StatefulWidget {
  final String id;
  final String address;
  final String title;
  final String subtitle;
  const CusttomRestorent({
    required this.id,
    required this.address,
    required this.title,
    required this.subtitle,
  });

  @override
  State<CusttomRestorent> createState() => _CusttomRestorentState();
}

class _CusttomRestorentState extends State<CusttomRestorent> {
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RestorentDeal.routeName, arguments: {
          'id': widget.id,
          'name': widget.title,
          'category': widget.subtitle,
          'address': widget.address,
        });
      },
      child: Container(
        height: height / 9,
        width: width / 1.1,
        decoration: BoxDecoration(
          color: notifier.getwhite,
          borderRadius: const BorderRadius.all(
            Radius.circular(11),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: width / 60),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                "assets/foodmenu.png",
              ),
            ),
            SizedBox(width: width / 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 70),
                Text(
                  widget.title,
                  style: TextStyle(
                      color: notifier.getblackcolor,
                      fontSize: height / 50,
                      fontFamily: 'GilroyBold'),
                ),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 60,
                      fontFamily: 'GilroyMedium'),
                ),
                SizedBox(height: height / 70),
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
                    SizedBox(width: width / 12),
                    kmtime(width / 6, Icons.location_on_outlined, "254m"),
                    SizedBox(width: width / 50),
                    kmtime(width / 8, Icons.timer, "27'"),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget kmtime(w, icon, txt) {
    return Container(
      height: height / 30,
      width: w,
      decoration: const BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: height / 70,
            color: notifier.getred,
          ),
          Text(
            txt,
            style: TextStyle(
              fontSize: height / 70,
              color: notifier.getred,
            ),
          )
        ],
      ),
    );
  }
}
