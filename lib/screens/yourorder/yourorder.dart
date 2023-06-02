import 'package:flutter/material.dart';
import 'package:gofoods/screens/ordertabs/deliverytabs.dart';
import 'package:gofoods/screens/ordertabs/history.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourOrder extends StatefulWidget {
  static const routeName = '/your-order';
  const YourOrder({Key? key}) : super(key: key);

  @override
  State<YourOrder> createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.getwhite,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,
              color: notifier.getblackcolor, size: height / 40),
        ),
        centerTitle: true,
        title: Text(
          LanguageEn.yourorder,
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
        actions: [
          Icon(Icons.search_rounded,
              color: notifier.getblackcolor, size: height / 28),
          SizedBox(width: width / 40),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: height / 50),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.transparent,
                    ),
                    width: width / 1.1,
                    child: TabBar(
                      unselectedLabelColor: notifier.getblackcolor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: notifier.getred,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              LanguageEn.delivery,
                              style: TextStyle(
                                  fontSize: height / 50,
                                  fontFamily: 'GilroyBold'),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              LanguageEn.history,
                              style: TextStyle(
                                  fontSize: height / 50,
                                  fontFamily: 'GilroyBold'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: <Widget>[Deliverytabs(), Historytabs()],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
