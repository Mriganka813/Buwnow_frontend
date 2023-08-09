import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
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
      backgroundColor: notifier.getwhite,
    );
  }

  Widget dot() {
    return DottedLine(
      direction: Axis.vertical,
      lineLength: height / 15,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: Colors.grey,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
    );
  }

  Widget status(name2, clr, img, name) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: clr,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: height / 16,
          width: width / 7,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(height / 130),
              child: Image.asset(img),
            ),
          ),
        ),
        SizedBox(
          width: width / 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontFamily: 'GilroyBold',
                  fontSize: height / 50),
            ),
            SizedBox(
              height: height / 200,
            ),
            Text(
              name2,
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontFamily: 'GilroyMedium',
                  fontSize: height / 65),
            ),
          ],
        ),
      ],
    );
  }
}
