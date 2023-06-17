import 'package:flutter/material.dart';
import 'package:gofoods/screens/order_confirmation.dart/screens/orderconfirmation.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CusttomGriadeFoodIteam extends StatefulWidget {
  final String? image;
  final String? name;

  const CusttomGriadeFoodIteam(this.image, this.name, {Key? key})
      : super(key: key);

  @override
  State<CusttomGriadeFoodIteam> createState() => _CusttomGriadeFoodIteamState();
}

class _CusttomGriadeFoodIteamState extends State<CusttomGriadeFoodIteam> {
  late ColorNotifier notifier;
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool check5 = false;
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
      height: height / 3.24,
      width: width / 2.45,
      decoration: BoxDecoration(
        color: notifier.getbgfildcolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: height / 50),
          Container(
            height: height / 11,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(
                    widget.image!,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: height / 70),
          Text(
            widget.name!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 60,
              fontFamily: 'GilroyBold',
            ),
          ),
          SizedBox(height: height / 100),
          Text(
            LanguageEn.shrimponion,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: notifier.getgrey,
              fontSize: height / 73,
              fontFamily: 'GilroyMedium',
            ),
          ),
          SizedBox(height: height / 55),
          Row(
            children: [
              SizedBox(width: width / 25),
              Text(
                "\$8.60",
                style: TextStyle(
                  color: notifier.getred,
                  fontFamily: 'GilroyExtraBold',
                  fontSize: height / 45,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showmodelbottomsheet();
                },
                child: Container(
                  height: height / 20,
                  width: width / 10,
                  decoration: BoxDecoration(
                    color: notifier.getred,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.add,
                        size: height / 30, color: notifier.getwhite),
                  ),
                ),
              ),
              SizedBox(width: width / 35),
            ],
          )
        ],
      ),
    );
  }

  Future showmodelbottomsheet() {
    return showModalBottomSheet(
      backgroundColor: notifier.getwhite,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Column(
                  children: [
                    SizedBox(height: height / 40),
                    Row(
                      children: [
                        SizedBox(width: width / 2.4),
                        Text(
                          LanguageEn.adnew,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontSize: height / 47,
                              fontFamily: "GilroyBold"),
                        ),
                        SizedBox(width: width / 3.5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.clear,
                              color: notifier.getblackcolor, size: height / 40),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 30),
                    Row(
                      children: [
                        SizedBox(width: width / 25),
                        Text(
                          LanguageEn.choiceofsize,
                          style: TextStyle(
                              color: notifier.getgrey,
                              fontSize: height / 60,
                              fontFamily: 'GilroyMedium'),
                        )
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Size L",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$4.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check1,
                          onChanged: (bool? value) {
                            setState(() {
                              check1 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 80),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Size M",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$3.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check2,
                          onChanged: (bool? value) {
                            setState(() {
                              check2 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 80),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Size S",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$1.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check3,
                          onChanged: (bool? value) {
                            setState(() {
                              check3 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        SizedBox(width: width / 25),
                        Text(
                          LanguageEn.choiceoftopping,
                          style: TextStyle(
                              color: notifier.getgrey,
                              fontSize: height / 60,
                              fontFamily: 'GilroyMedium'),
                        )
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Topping Fish (4 pieces)",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$4.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check4,
                          onChanged: (bool? value) {
                            setState(() {
                              check4 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 80),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Topping Meat(5 pieces)",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$3.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check5,
                          onChanged: (bool? value) {
                            setState(() {
                              check5 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderConformation(),
                          ),
                        );
                      },
                      child: Container(
                        height: height / 17,
                        width: width / 1.1,
                        decoration: BoxDecoration(
                          color: notifier.getred,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: notifier.getwhite,
                              fontFamily: 'GilroyMedium',
                              fontSize: height / 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
