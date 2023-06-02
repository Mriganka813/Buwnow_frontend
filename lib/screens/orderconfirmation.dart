import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/custtomscreens/custtomdeliverdorder.dart';
import 'package:gofoods/screens/ordersucsess.dart';
import 'package:gofoods/screens/yourorder/deliveryadrees.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderConformation extends StatefulWidget {
  static const routeName = '/order-confirmation';
  const OrderConformation({Key? key}) : super(key: key);

  @override
  State<OrderConformation> createState() => _OrderConformationState();
}

class _OrderConformationState extends State<OrderConformation> {
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
  int _groupValue = -1;

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
              color: notifier.getblackcolor, size: height / 50),
        ),
        centerTitle: true,
        title: Text(
          LanguageEn.orderconfirmation,
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressUpdates(),
                  ),
                );
              },
              child: Center(
                child: Container(
                  color: Colors.transparent,
                  height: height / 13,
                  width: width / 1.1,
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: notifier.getstarcolor, size: height / 25),
                      SizedBox(width: width / 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height / 70),
                          Text(
                            LanguageEn.deliveryto,
                            style: TextStyle(
                                color: notifier.getgrey,
                                fontFamily: 'GilroyMedium',
                                fontSize: height / 50),
                          ),
                          Text(
                            "92 Hang Trong, Hoan Kiem",
                            style: TextStyle(
                                color: notifier.getblackcolor,
                                fontFamily: 'GilroyBold',
                                fontSize: height / 50),
                          )
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          color: notifier.getblackcolor, size: height / 50),
                      SizedBox(width: width / 30),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height / 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Divider(color: notifier.getgrey),
            ),
            SizedBox(height: height / 50),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.yourorder,
                  style: TextStyle(
                      color: notifier.getgrey,
                      fontFamily: 'GilroyBold',
                      fontSize: height / 50),
                )
              ],
            ),
            SizedBox(height: height / 50),
            CusttomDeliverdOrder(
                "assets/foodmenu.png", LanguageEn.steakbeet, "\$230"),
            SizedBox(height: height / 50),
            CusttomDeliverdOrder(
                "assets/pizzachicago.jpg", LanguageEn.hambuger, "\$120"),
            SizedBox(height: height / 100),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Divider(color: notifier.getgrey),
            ),
            SizedBox(height: height / 100),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.subtotal,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 60,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
                const Spacer(),
                Text(
                  "\$330",
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 60,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
                SizedBox(width: width / 20),
              ],
            ),
            SizedBox(height: height / 100),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.deliverycharges,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 60,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
                const Spacer(),
                Text(
                  "\$2",
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 60,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
                SizedBox(width: width / 20),
              ],
            ),
            SizedBox(height: height / 100),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.total,
                  style: TextStyle(
                    color: notifier.getblackcolor,
                    fontSize: height / 60,
                    fontFamily: 'GilroyBold',
                  ),
                ),
                const Spacer(),
                Text(
                  "\$332",
                  style: TextStyle(
                    color: notifier.getblackcolor,
                    fontSize: height / 60,
                    fontFamily: 'GilroyBold',
                  ),
                ),
                SizedBox(width: width / 20),
              ],
            ),
            SizedBox(height: height / 5),
            GestureDetector(
              onTap: () {
                setState(() {
                  showmodelbottomsheet();
                });
              },
              child: button(
                notifier.getred,
                notifier.getwhite,
                "Order . 230\$",
                width / 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showmodelbottomsheet() {
    return showModalBottomSheet(backgroundColor: notifier.getwhite,
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
            return Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height / 40),
                    Row(
                      children: [
                        SizedBox(width: width / 2.4),
                        Text(
                          LanguageEn.payment,
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
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _groupValue = 0;
                          },
                        );
                      },
                      child: chashtype(
                        LanguageEn.cash,
                        "assets/cash.png",
                        height / 29,
                        0,
                        Radio(
                          activeColor: notifier.getred,
                          value: 0,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _groupValue = 1;
                          },
                        );
                      },
                      child: chashtype(
                        LanguageEn.cardvisa,
                        "assets/visa.png",
                        height / 32,
                        1,
                        Radio(
                          activeColor: notifier.getred,
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _groupValue = 2;
                          },
                        );
                      },
                      child: chashtype(
                        LanguageEn.cardmaster,
                        "assets/master.png",
                        height / 20,
                        2,
                        Radio(
                          activeColor: notifier.getred,
                          value: 2,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _groupValue = 3;
                          },
                        );
                      },
                      child: chashtype(
                        LanguageEn.yummywallet,
                        "assets/yummy.png",
                        height / 25,
                        3,
                        Radio(
                          activeColor: notifier.getred,
                          value: 3,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const
                                // MyOrder()
                                OrderSucsess(),
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
                            LanguageEn.completeorder,
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
              ),
            );
          },
        );
      },
    );
  }

  Widget chashtype(name, image, imageheight, val, rado) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        color: Colors.transparent,
        child: Row(
          children: [
            rado,
            SizedBox(width: width / 25),
            Image.asset(image, height: imageheight),
            const Spacer(),
            Text(
              name,
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 50,
                  fontFamily: 'GilroyMedium'),
            ),
            SizedBox(width: width / 15),
          ],
        ),
      );
    });
  }
}
