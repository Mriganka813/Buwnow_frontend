import 'package:flutter/material.dart';
import 'package:buynow/screens/specific_shop/screens/restorentdeal.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/specific_shop/screens/show_all_products.dart';

class CusttomRecommended extends StatefulWidget {
  final String? bgimage;
  final String? name;
  final String? adressredto;
  final String id;
  final String category;
  final int discount;
  const CusttomRecommended({
    required this.bgimage,
    required this.name,
    required this.adressredto,
    required this.id,
    required this.category,
    required this.discount,
  });

  @override
  State<CusttomRecommended> createState() => _CusttomRecommendedState();
}

class _CusttomRecommendedState extends State<CusttomRecommended> {
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
        Navigator.of(context)
            .pushNamed(SpecificAllProductScreen.routeName, arguments: {
          'id': widget.id,
          'name': widget.name,
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: height / 3,
          width: width / 2.3,
          decoration: BoxDecoration(
            color: notifier.getbgfildcolor,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                height: height / 9,
                width: width / 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: widget.bgimage!.isEmpty
                        ? Image.asset(
                            'assets/shop_image.png',
                            fit: BoxFit.contain,
                          )
                        : Image.network(
                            widget.bgimage!,
                            fit: BoxFit.contain,
                          )),
              ),
              Row(
                children: [
                  SizedBox(width: width / 30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height / 90),
                        Text(
                          widget.name!,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontSize: height / 45,
                              fontFamily: 'GilroyBold'),
                        ),
                        Text(
                          widget.adressredto!,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color: notifier.getgrey,
                              fontSize: height / 65,
                              fontFamily: 'GilroyBold'),
                        ),
                        SizedBox(height: height / 100),
                        widget.discount != 0
                            ? Text(
                                'Flat ${widget.discount}% off',
                                style: TextStyle(
                                    color: notifier.getred,
                                    fontSize: height / 45,
                                    fontFamily: 'GilroyBold'),
                              )
                            : Container()
                        // Row(
                        //   children: [
                        //     Icon(Icons.star,
                        //         size: height / 40,
                        //         color: notifier.getstarcolor),
                        //     Icon(Icons.star,
                        //         size: height / 40,
                        //         color: notifier.getstarcolor),
                        //     Icon(Icons.star,
                        //         size: height / 40,
                        //         color: notifier.getstarcolor),
                        //     Icon(Icons.star,
                        //         size: height / 40,
                        //         color: notifier.getstarcolor),
                        //   ],
                        // ),
                        // SizedBox(height: height / 50),
                        // Row(
                        //   children: [
                        //     kmtime(
                        //         width / 6, Icons.location_on_outlined, "254m"),
                        //     SizedBox(width: width / 50),
                        //     kmtime(width / 8, Icons.timer, "27'"),
                        //   ],
                        // ),
                      ],
                    ),
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const RestorentDeal(),
        //   ),
        // );
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
