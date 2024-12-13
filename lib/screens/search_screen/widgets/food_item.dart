import 'package:flutter/material.dart';

import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';

Widget FoodItem({
  required int i,
  required String prodName,
  required int priceAfterDiscount,
  required int prodPrice,
  required String sellerName,
  required String desc,
  required ColorNotifier notifier,
  required String image,
  VoidCallback? onAddTap,
  bool isShopProduct = false,
}) {
  return Column(
    children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Flexible(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: image.isEmpty
                      ? Container()
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
                image.isEmpty
                    ? Center(
                        child: InkWell(
                          onTap: onAddTap,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: notifier.getred,
                            ),
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                  color: notifier.getwhite,
                                  fontSize: height / 45,
                                  fontFamily: 'GilroyBold'),
                            ),
                          ),
                        ),
                      )
                    : Positioned(
                        bottom: 10,
                        right: width / 25,
                        left: width / 25,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: onAddTap,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: notifier.getred,
                              ),
                              child: Text(
                                'ADD',
                                style: TextStyle(
                                    color: notifier.getwhite,
                                    fontSize: height / 45,
                                    fontFamily: 'GilroyBold'),
                              ),
                            ),
                          ),
                        ),
                      )
              ],
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
                    "₹$priceAfterDiscount",
                    style: TextStyle(
                        color: notifier.getred,
                        fontSize: height / 50,
                        fontFamily: 'GilroyMedium'),
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                  priceAfterDiscount != prodPrice
                      ? Text(
                          "₹$prodPrice",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2,
                              color: notifier.getgrey,
                              fontSize: height / 55,
                              fontFamily: 'GilroyMedium'),
                        )
                      : Container()
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
              !isShopProduct
                  ? Container(
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
                  : Container()
            ],
          ),
        ),
      ]),
      Divider(),
    ],
  );
}
