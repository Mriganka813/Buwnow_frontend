import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtomdeliverdorder.dart';
import 'package:gofoods/screens/myorder.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deliverytabs extends StatefulWidget {
  const Deliverytabs({Key? key}) : super(key: key);

  @override
  State<Deliverytabs> createState() => _DeliverytabsState();
}

class _DeliverytabsState extends State<Deliverytabs> {
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
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyOrder(),
            ),
          ),
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(height: height / 30),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Icon(Icons.receipt_long,
                        color: notifier.getstarcolor, size: height / 35),
                    SizedBox(width: width / 35),
                    Text(
                      "#12312534",
                      style: TextStyle(
                        color: notifier.getblackcolor,
                        fontFamily: 'GilroyBold',
                        fontSize: height / 55,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "17/04/2022",
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontFamily: 'GilroyMedium',
                        fontSize: height / 55,
                      ),
                    ),
                    SizedBox(width: width / 20),
                  ],
                ),
                SizedBox(height: height / 50),
                CusttomDeliverdOrder(
                  id: '',
                  image: "assets/foodmenu.png",
                  txt: LanguageEn.steakbeet,
                  rate: "\$230",
                  qty: 1,
                  totalAmount: '20',
                ),
                SizedBox(height: height / 50),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    estbutton(),
                  ],
                ),
                SizedBox(height: height / 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(color: notifier.getgrey),
                ),
                SizedBox(height: height / 50),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Icon(Icons.receipt_long,
                        color: notifier.getstarcolor, size: height / 35),
                    SizedBox(width: width / 35),
                    Text(
                      "#12312534",
                      style: TextStyle(
                        color: notifier.getblackcolor,
                        fontFamily: 'GilroyBold',
                        fontSize: height / 55,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "17/04/2022",
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontFamily: 'GilroyMedium',
                        fontSize: height / 55,
                      ),
                    ),
                    SizedBox(width: width / 20),
                  ],
                ),
                SizedBox(height: height / 50),
                CusttomDeliverdOrder(
                  id: '',
                  image: "assets/pizzachicago.jpg",
                  txt: LanguageEn.hambuger,
                  rate: "\$230",
                  qty: 1,
                  totalAmount: '20',
                ),
                SizedBox(height: height / 50),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    estbutton(),
                  ],
                ),
                SizedBox(height: height / 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(color: notifier.getgrey),
                ),
                SizedBox(height: height / 50),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Icon(Icons.receipt_long,
                        color: notifier.getstarcolor, size: height / 35),
                    SizedBox(width: width / 35),
                    Text(
                      "#12312534",
                      style: TextStyle(
                        color: notifier.getblackcolor,
                        fontFamily: 'GilroyBold',
                        fontSize: height / 55,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "17/04/2022",
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontFamily: 'GilroyMedium',
                        fontSize: height / 55,
                      ),
                    ),
                    SizedBox(width: width / 20),
                  ],
                ),
                SizedBox(height: height / 50),
                CusttomDeliverdOrder(
                  id: '',
                  image: "assets/foodmenu.png",
                  txt: LanguageEn.steakbeet,
                  rate: "\$230",
                  qty: 1,
                  totalAmount: '20',
                ),
                SizedBox(height: height / 50),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    estbutton(),
                  ],
                ),
                SizedBox(height: height / 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget estbutton() {
    return Container(
      height: height / 28,
      width: width / 2.9,
      decoration: BoxDecoration(
        color: notifier.getred,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Center(
        child: Text(
          "Est, Time 13:45",
          style: TextStyle(
            color: notifier.getwhite,
            fontSize: height / 60,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }
}
