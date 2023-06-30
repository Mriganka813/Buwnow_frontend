import 'package:flutter/material.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/services/address_services.dart';
import 'package:gofoods/services/order_services.dart';
import 'package:gofoods/utils/notifirecolor.dart';

import '../../ordersucsess.dart';
import '../../../utils/enstring.dart';
import '../../../utils/mediaqury.dart';

Future showmodelbottomsheet({
  required ColorNotifier notifier,
  required BuildContext context,
  required int groupValue,
  required OrderServices orderServices,
  required String name,
  required String phoneNo,
  required String street,
  required String city,
  required String state,
  required String pincode,
  required String additional,
  required String latitude,
  required String longitude,
  required AddressServices addressServices,
}) {
  return showModalBottomSheet(
    backgroundColor: notifier.getwhite,
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
                          groupValue = 0;
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
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value as int;
                            });
                          },
                        ),
                        notifier),
                  ),
                  SizedBox(height: height / 50),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          groupValue = 1;
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
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value as int;
                          });
                        },
                      ),
                      notifier,
                    ),
                  ),
                  SizedBox(height: height / 50),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          groupValue = 2;
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
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value as int;
                          });
                        },
                      ),
                      notifier,
                    ),
                  ),
                  SizedBox(height: height / 50),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          groupValue = 3;
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
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value as int;
                          });
                        },
                      ),
                      notifier,
                    ),
                  ),
                  SizedBox(height: height / 50),
                  GestureDetector(
                    onTap: () async {
                      if (groupValue == -1) {
                        showSnackBar('Please choose one option');
                        return;
                      }

                      await addressServices.addAddress(
                        context: context,
                        city: city,
                        state: state,
                        phoneNo: phoneNo,
                        pincode: pincode,
                        street: street,
                        additional: additional,
                        latitude: latitude,
                        longitude: longitude,
                      );

                      showSnackBar('Your order is being placed...');

                      await orderServices.orderPlace(
                        context: context,
                        name: name,
                        state: state,
                        city: city,
                        phoneNo: phoneNo,
                        pincode: pincode,
                        streetAddress: street,
                        additional: additional,
                        latitude: latitude,
                        longitude: longitude,
                      );

                      Navigator.popAndPushNamed(
                        context,
                        OrderSucsess.routeName,
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

Widget chashtype(name, image, imageheight, val, rado, notifier) {
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
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
