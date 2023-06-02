import 'package:flutter/material.dart';
import 'package:gofoods/screens/restorentdeal.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CusttomPopularfoodlist extends StatefulWidget {
  final String? bgimage;
  final double? bh;
  final double? bw;
  final double? eh;
  final double? ew;
  final double? sw;
  final String? name;

  const CusttomPopularfoodlist(
      this.bgimage, this.bh, this.bw, this.eh, this.ew, this.sw,this.name,
      {Key? key})
      : super(key: key);

  @override
  State<CusttomPopularfoodlist> createState() => _CusttomPopularfoodlistState();
}

class _CusttomPopularfoodlistState extends State<CusttomPopularfoodlist> {
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RestorentDeal(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: widget.bh!,
          width: widget.bw!,
          decoration:   BoxDecoration(color: notifier.getbgfildcolor,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                height: widget.eh!,
                width: widget.ew!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(widget.bgimage!, fit: BoxFit.fill),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: width / 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height / 90),
                      Text(
                        widget.name!,
                        style: TextStyle(
                            color: notifier.getblackcolor,
                            fontSize: height / 45,
                            fontFamily: 'GilroyBold'),
                      ),
                      Text(
                        LanguageEn.westernburger,
                        style: TextStyle(
                            color: notifier.getgrey,
                            fontSize: height / 65,
                            fontFamily: 'GilroyBold'),
                      ),
                      SizedBox(height: height / 100),
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
                          SizedBox(width: widget.sw!),
                          kmtime(width / 6, Icons.location_on_outlined, "254m"),
                          SizedBox(width: width / 70),
                          kmtime(width / 8, Icons.timer, "27'"),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget kmtime(w, icon, txt) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RestorentDeal(),
          ),
        );
      },
      child: Container(
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
      ),
    );
  }
}
