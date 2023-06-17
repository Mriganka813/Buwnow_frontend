import 'package:flutter/material.dart';
import 'package:gofoods/services/cart_services.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CusttomDeliverdOrder extends StatefulWidget {
  final String? image;
  final String txt;
  final String rate;
  final int qty;
  final String totalAmount;
  final String id;

  const CusttomDeliverdOrder({
    required this.id,
    required this.image,
    required this.txt,
    required this.rate,
    required this.qty,
    required this.totalAmount,
  });

  @override
  State<CusttomDeliverdOrder> createState() => _CusttomDeliverdOrderState();
}

class _CusttomDeliverdOrderState extends State<CusttomDeliverdOrder> {
  late ColorNotifier notifier;

  final CartServices cartServices = CartServices();

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
    return Row(
      children: [
        Container(
          height: height / 13,
          width: width / 6,
          margin: EdgeInsets.only(left: width / 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
                image: AssetImage(widget.image!), fit: BoxFit.fill),
          ),
        ),
        SizedBox(width: width / 30),
        Text(
          "${widget.qty} x",
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
        SizedBox(width: width / 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.txt,
              style: TextStyle(
                color: notifier.getblackcolor,
                fontSize: height / 50,
                fontFamily: 'GilroyBold',
              ),
            ),
            Text(
              LanguageEn.pieces,
              style: TextStyle(
                color: notifier.getgrey,
                fontSize: height / 60,
                fontFamily: 'GilroyMedium',
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "₹${widget.totalAmount}",
              style: TextStyle(
                color: notifier.getblackcolor,
                fontSize: height / 50,
                fontFamily: 'GilroyBold',
              ),
            ),
            Text(
              "${widget.rate}",
              style: TextStyle(
                color: notifier.getgrey,
                fontSize: height / 70,
                fontFamily: 'GilroyMedium',
              ),
            )
          ],
        ),
        SizedBox(width: width / 20),
      ],
    );
  }
}
