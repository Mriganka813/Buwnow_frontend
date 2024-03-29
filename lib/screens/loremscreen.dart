import 'package:flutter/material.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loream extends StatefulWidget {
  final String? apptitle;
  final String? loreamm;

  const Loream(this.apptitle, this.loreamm, {Key? key}) : super(key: key);

  @override
  State<Loream> createState() => _LoreamState();
}

class _LoreamState extends State<Loream> {
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
        backgroundColor: notifier.getwhite,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: height / 32,
            color: notifier.getblackcolor,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.apptitle!,
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
      ),
      body: Column(
        children: [
          // SizedBox(height: height/5),
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 22),
            child: Text(
              widget.loreamm!,
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 45,
                  fontFamily: 'GilroyMedium'),
            ),
          )
        ],
      ),
    );
  }
}
