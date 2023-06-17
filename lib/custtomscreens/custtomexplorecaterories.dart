import 'package:flutter/material.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExploreCategories extends StatefulWidget {
  final String? image;
  final String? txt;
  final double? imh;
  const ExploreCategories(this.image, this.txt, this.imh, {Key? key})
      : super(key: key);

  @override
  State<ExploreCategories> createState() => _ExploreCategoriesState();
}

class _ExploreCategoriesState extends State<ExploreCategories> {
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
      height: height / 6,
      width: width / 4,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          // SizedBox(height: height /  50),
          Image.asset(
            widget.image!, height: widget.imh,
            // color: notifier.getwhite,
            fit: BoxFit.fill,
          ),
          SizedBox(height: height / 90),
          Text(
            widget.txt!,
            style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 60,
              fontFamily: 'GilroyMedium',
            ),
          ),
        ],
      ),
    );
  }
}
