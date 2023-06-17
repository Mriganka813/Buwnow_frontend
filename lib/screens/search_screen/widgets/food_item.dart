import 'package:flutter/material.dart';

import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';

Widget FoodItem({
  required int i,
  required String prodName,
  required int prodPrice,
  required String sellerName,
  required String desc,
  required ColorNotifier notifier,
  required String image,
}) {
  return Column(
    children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Flexible(
          flex: 4,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: image.isEmpty
                  ? Image.asset(
                      'assets/foods.png',
                      height: 180,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      image,
                      height: 180,
                      width: 200,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : CircularProgressIndicator(),
                    ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                prodName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: notifier.getblackcolor,
                    fontSize: height / 45,
                    fontFamily: 'GilroyBold'),
              ),
              SizedBox(
                height: height / 100,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "₹$prodPrice",
                    style: TextStyle(
                        color: notifier.getred,
                        fontSize: height / 55,
                        fontFamily: 'GilroyMedium'),
                  ),
                ],
              ),
              SizedBox(
                height: height / 100,
              ),
              Text(
                desc,
                style: TextStyle(
                    color: notifier.getblackcolor,
                    fontSize: height / 55,
                    fontFamily: 'GilroyMedium'),
              ),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.bottomRight,
                child: Text(
                  '~by $sellerName',
                  style: TextStyle(
                      color: notifier.getred,
                      fontSize: height / 55,
                      fontFamily: 'GilroyMedium'),
                ),
              )
            ],
          ),
        ),
      ]),
    ],
  );
}
