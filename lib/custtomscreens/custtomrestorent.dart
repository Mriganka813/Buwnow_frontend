import 'package:buynow/screens/specific_shop/screens/show_all_products.dart';
import 'package:flutter/material.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/utils.dart';

class CusttomRestorent extends StatefulWidget {
  final String id;
  final String address;
  final String title;
  final String subtitle;
  final String image;
  final int discount;
  final bool shopOpen;
  String? openTime;
  String? closeTime;
  CusttomRestorent({
    required this.id,
    required this.address,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.discount,
    required this.shopOpen,
    this.openTime,
    this.closeTime,
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
      onTap: () async {
        if (!widget.shopOpen) {
          showSnackBar('This shop is not available right now');
          return;
        }

        DateTime optime = DateFormat.Hm().parse(widget.openTime ?? '10:15');
        DateTime cltime = DateFormat.Hm().parse(widget.closeTime ?? '23:30');

        // final ophour = optime.hour;
        // final opminute = optime.minute;

        // final clhour = cltime.hour;
        // final clminute = cltime.minute;

        print(optime);
        print(cltime);

        // Synchronize with an NTP server
        DateTime currentTime;
        try {
          currentTime = await NTP.now();
        } catch (e) {
          currentTime = DateTime.now();
        }

        if (currentTime.hour < optime.hour ||
            (currentTime.hour == optime.hour &&
                currentTime.minute < optime.minute)) {
          showSnackBar(
              'This shop is available from ${optime.hour}:${optime.minute} to ${cltime.hour}:${cltime.minute}');
          return;
        } else if (currentTime.hour > cltime.hour ||
            (currentTime.hour == cltime.hour &&
                currentTime.minute > cltime.minute)) {
          showSnackBar(
              'This shop is available from ${optime.hour}:${optime.minute} to ${cltime.hour}:${cltime.minute}');
          return;
        }

        Navigator.of(context)
            .pushNamed(SpecificAllProductScreen.routeName, arguments: {
          'id': widget.id,
          'name': widget.title,
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
                child: widget.image.isEmpty
                    ? Image.asset(
                        'assets/shop_image.png',
                        fit: BoxFit.contain,
                        height: height / 4,
                        width: width / 5,
                      )
                    : Image.network(
                        widget.image,
                        height: height / 4,
                        width: width / 5,
                        fit: BoxFit.cover,
                      )),
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
                    SizedBox(width: width / 8),

                    // kmtime(width / 6, Icons.location_on_outlined, "254m"),
                    // SizedBox(width: width / 50),
                    // kmtime(width / 8, Icons.timer, "27'"),
                    widget.discount != 0
                        ? Text(
                            'Flat ${widget.discount}% off',
                            style: TextStyle(
                                color: notifier.getred,
                                fontSize: height / 45,
                                fontFamily: 'GilroyBold'),
                          )
                        : Container()
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
