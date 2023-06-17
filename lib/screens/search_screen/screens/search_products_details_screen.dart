import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/screens/order_confirmation.dart/screens/orderconfirmation.dart';
import 'package:gofoods/screens/restorentdeal.dart';
import 'package:gofoods/services/cart_services.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProductDetailsScreen extends StatefulWidget {
  static const routeName = '/search-products-screen';

  @override
  State<SearchProductDetailsScreen> createState() =>
      _SearchProductDetailsScreenState();
}

class _SearchProductDetailsScreenState
    extends State<SearchProductDetailsScreen> {
  late ColorNotifier notifier;

  final CartServices cartServices = CartServices();
  List<dynamic> cartData = [];

  bool isLoading = false;

  int userQuantity = 1;

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
    getCartData();
  }

  getCartData() async {
    setState(() {
      isLoading = true;
    });
    cartData = await cartServices.getCartItems(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    final prodId = args['_id'];
    final prodName = args['name'];
    final price = args['sellingPrice'];
    final quantity = args['quantity'].toString();
    final returnPeriod = args['returnPeriod'];
    final desc = args['description'] ?? 'This is a test description.';
    final String image = args['image'] ?? '';
    final sellerName = args['sellerName'];
    final sellerId = args['user'];
    final category = args['category'];
    final address = args['address'] ?? '';

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context);

    return SafeArea(
        child: Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: image.isEmpty
                        ? Image.asset(
                            'assets/pizza.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            image,
                            fit: BoxFit.cover,
                          )
                    // FadeInImage.assetNetwork(
                    //   placeholder: 'assets/pizza.png',
                    //   image: image,
                    //   fit: BoxFit.cover,
                    // ),
                    ),
                buttonArrow(context),
                scroll(prodId, prodName, sellerName, price, quantity,
                    returnPeriod, desc, sellerId, category, address),
              ],
            ),
    ));
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 5)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll(
    String prodId,
    String prodName,
    String sellerName,
    int price,
    String totalQuantity,
    int returnPeriod,
    String desc,
    String sellerId,
    String category,
    String address,
  ) {
    TextStyle heading = TextStyle(
        color: notifier.getblackcolor,
        fontSize: height / 45,
        fontFamily: 'GilroyBold');

    TextStyle text = TextStyle(
        color: notifier.getblackcolor,
        fontSize: height / 55,
        fontFamily: 'GilroyMedium');

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.7,
      minChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: notifier.getbgfildcolor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 35,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                ),
                Text(
                  prodName,
                  style: heading,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RestorentDeal.routeName, arguments: {
                          'id': sellerId,
                          'name': sellerName,
                          'category': category,
                          'address': address,
                        });
                      },
                      child: Text(
                        '~ by $sellerName',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: notifier.getred,
                            fontSize: height / 55,
                            fontFamily: 'GilroyMedium'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 80,
                ),
                Row(
                  children: [
                    Text(
                      "₹${price}",
                      style: TextStyle(
                          color: notifier.getblackcolor,
                          fontSize: height / 45,
                          fontFamily: 'GilroyMedium'),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 100,
                ),
                const Divider(),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  'Available quantity: $totalQuantity',
                  style: text,
                ),
                SizedBox(
                  height: height / 100,
                ),
                const Divider(),
                SizedBox(
                  height: height / 100,
                ),
                Row(
                  children: [
                    Text(
                      'Set quantity: ',
                      style: text,
                    ),
                    SizedBox(
                      width: width / 50,
                    ),
                    Container(
                      height: height / 23,
                      width: width / 4.5,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.black26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: NumberPicker(
                        minValue: 1,
                        maxValue: 10,
                        itemWidth: 30,
                        value: userQuantity,
                        axis: Axis.horizontal,
                        itemHeight: 30,
                        selectedTextStyle:
                            const TextStyle(fontSize: 25, color: Colors.black),
                        onChanged: (changedValue) {
                          setState(() {
                            userQuantity = changedValue;
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height / 100,
                ),
                const Divider(),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  '$returnPeriod days Return Policy',
                  style: text,
                ),
                SizedBox(
                  height: height / 100,
                ),
                const Divider(),
                Row(
                  children: [
                    Text(
                      '4.0 Ratings',
                      style: text.copyWith(color: notifier.getred),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Icon(
                        Icons.rate_review,
                        size: 27,
                      ),
                    ),
                    Text(
                      "80 reviews",
                      style: text.copyWith(color: notifier.getred),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: height / 80,
                  ),
                ),
                Text(
                  "Description",
                  style: heading,
                ),
                SizedBox(
                  height: height / 80,
                ),
                Text(
                  desc,
                  style: text,
                ),
                SizedBox(
                  height: height / 80,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: height / 80,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (userQuantity > int.parse(totalQuantity)) {
                      _showMyDialog('quantity not available');
                      return;
                    }
                    if (cartData.length > 0) {
                      if (sellerId == cartData[0]['product']['user']) {
                        await cartServices.addToCart(
                            context, prodId, userQuantity.toString());
                        Navigator.of(context)
                            .pushNamed(OrderConformation.routeName);
                      } else {
                        _showMyDialog(
                            "You can not buy products from different seller at a time.");
                      }
                    } else {
                      await cartServices.addToCart(
                          context, prodId, userQuantity.toString());
                      showSnackBar('Item added successfully.');
                      Navigator.of(context)
                          .pushNamed(OrderConformation.routeName);
                    }
                  },
                  child: button(notifier.getred, notifier.getwhite,
                      'Add to cart', width / 1.1),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showMyDialog(String txt) async {
    return showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifier.getwhite,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: height / 5,
                child: Column(
                  children: [
                    SizedBox(height: height / 130),
                    Text(
                      'Warning',
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 30,
                        fontFamily: 'GilroyBold',
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Text(
                      txt,
                      style: TextStyle(
                        color: notifier.getblackcolor,
                        fontSize: height / 50,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: dailogbutton(
                              Colors.transparent, 'Got it!', notifier.getred),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        );
      },
    );
  }

  Widget dailogbutton(buttoncolor, txt, textcolor) {
    return Container(
      height: height / 16,
      width: width / 3.8,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        // border: Border.all(color: bordercolor),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
            color: textcolor,
            fontSize: height / 50,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }
}
