import 'package:flutter/material.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestorentDeal extends StatefulWidget {
  const RestorentDeal({Key? key}) : super(key: key);

  @override
  State<RestorentDeal> createState() => _RestorentDealState();
}

class _RestorentDealState extends State<RestorentDeal>
    with TickerProviderStateMixin {
  late ColorNotifier notifier;
  TabController? controller;
  TabController? restorentcontroller;

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
    controller = TabController(length: 3, vsync: this);
    restorentcontroller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    return Scaffold(
      backgroundColor: notifier.getwhite,
      floatingActionButton: SizedBox(
        height: height / 15,
        width: width / 1.1,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  Widget restorentstatuscard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),

    );
  }
}
