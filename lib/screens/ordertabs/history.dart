import 'package:buynow/models/order_history.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:buynow/custtomscreens/custtomdeliverdorder.dart';
import 'package:buynow/screens/track_order/screens/track_order_screen.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/order.dart';
import '../../services/order_services.dart';

class Historytabs extends StatefulWidget {
  const Historytabs({Key? key}) : super(key: key);

  @override
  State<Historytabs> createState() => _HistorytabsState();
}

class _HistorytabsState extends State<Historytabs> {
  late ColorNotifier notifier;

  bool isLoading = false;
  final OrderServices orderServices = OrderServices();
  List<OrderHistory> orderHistory = [];
  int orderLength = 0;

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
    getOrderHistory();
    getItemsLength();
  }

  getOrderHistory() async {
    setState(() {
      isLoading = true;
    });
    orderHistory = await orderServices.orderHistory();
    orderLength = orderHistory.length;

    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  getItemsLength() {
    for (int i = 0; i < orderHistory.length; i++) {
      List<Items>? items = orderHistory[i].recentOrders!.items;
      orderLength += items!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getwhite,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                    color: Colors.transparent,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orderLength,
                        itemBuilder: (context, index) {
                          final order = orderHistory[index];
                          final orderId = order.recentOrders!.sId;
                          final date = order.recentOrders!.createdAt
                              .toString()
                              .substring(0, 10);
                          final List<Items>? items =
                              orderHistory[index].recentOrders!.items;
                          final phoneNo = order.sellerNumber;

                          return Column(
                            children: [
                              ListView.builder(
                                itemCount: items!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  final prodId = items[i].productId;
                                  final qty = items[i].quantity!.toInt();
                                  final prodName = items[i].productName;
                                  final prodPrice =
                                      items[i].productPrice!.toInt();
                                  final totalAmount = qty * prodPrice;
                                  final status = items[i].status;
                                  final prodImage = items[i].productImage ?? '';
                                  final sellerId = items[i].sellerId;

                                  return historyItem(
                                    orderId!,
                                    date,
                                    qty,
                                    prodName!,
                                    prodPrice,
                                    totalAmount,
                                    status!,
                                    prodId!,
                                    phoneNo!,
                                    prodImage,
                                    sellerId!,
                                  );
                                },
                              )
                            ],
                          );
                        })),
              ),
            ),
    );
  }

  Widget estbutton(String status, isCall) {
    return Container(
        height: height / 25,
        width: width / 2.9,
        decoration: BoxDecoration(
          color: notifier.getred,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: !isCall
            ? Center(
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    color: notifier.getwhite,
                    fontSize: height / 60,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: width / 60,
                  ),
                  Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: notifier.getwhite,
                      fontSize: height / 60,
                      fontFamily: 'GilroyMedium',
                    ),
                  ),
                ],
              ));
  }

  Widget historyItem(
    String orderId,
    String date,
    int qty,
    String prodName,
    int prodPrice,
    int totalAmount,
    String status,
    String prodId,
    int phoneNo,
    String image,
    String sellerId,
  ) {
    return Column(
      children: [
        SizedBox(height: height / 40),
        Row(
          children: [
            SizedBox(width: width / 20),
            Icon(Icons.receipt_long,
                color: notifier.getstarcolor, size: height / 35),
            SizedBox(width: width / 35),
            Expanded(
              child: Text(
                "#$orderId",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  color: notifier.getblackcolor,
                  fontFamily: 'GilroyBold',
                  fontSize: height / 55,
                ),
              ),
            ),
            SizedBox(
              width: width / 50,
            ),
            Text(
              date,
              style: TextStyle(
                color: notifier.getgrey,
                fontFamily: 'GilroyMedium',
                fontSize: height / 55,
              ),
            ),
            SizedBox(width: width / 20),
          ],
        ),
        SizedBox(height: height / 50),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(TrackOrderScreen.routeName, arguments: {
              'prodId': prodId,
              'orderId': orderId,
              'status': status,
            });
            Provider.of<UserProvider>(context, listen: false)
                .setTotalPriceOfCartItems(totalAmount);
            Provider.of<UserProvider>(context, listen: false)
                .setSellerId(sellerId);
          },
          child: CusttomDeliverdOrder(
            id: '',
            image: image,
            txt: prodName,
            rate: '₹' + prodPrice.toString(),
            qty: qty,
            totalAmount: totalAmount.toString(),
          ),
        ),
        SizedBox(height: height / 50),
        Row(
          children: [
            SizedBox(width: width / 20),
            estbutton(status, false),
            Spacer(),
            GestureDetector(
                onTap: () => _launchDialer(phoneNo),
                child: estbutton('Call Shop', true)),
            SizedBox(width: width / 20),
          ],
        ),
        SizedBox(height: height / 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Divider(color: notifier.getgrey),
        ),
      ],
    );
  }

  void _launchDialer(int phoneNo) async {
    var phoneNumber = '+91$phoneNo'; // Replace with your desired phone number

    final uri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

// SizedBox(height: height / 30),
// SizedBox(height: height / 50),
// Row(
//   children: [
//     SizedBox(width: width / 20),
//     Icon(Icons.receipt_long,
//         color: notifier.getstarcolor, size: height / 35),
//     SizedBox(width: width / 35),
//     Text(
//       "#12312534",
//       style: TextStyle(
//         color: notifier.getblackcolor,
//         fontFamily: 'GilroyBold',
//         fontSize: height / 55,
//       ),
//     ),
//     const Spacer(),
//     Text(
//       "17/04/2022",
//       style: TextStyle(
//         color: notifier.getgrey,
//         fontFamily: 'GilroyMedium',
//         fontSize: height / 55,
//       ),
//     ),
//     SizedBox(width: width / 20),
//   ],
// ),
// SizedBox(height: height / 50),
// CusttomDeliverdOrder(
//   id: '',
//   image: "assets/pizzachicago.jpg",
//   txt: LanguageEn.hambuger,
//   rate: "\$230",
//   qty: 1,
//   totalAmount: '20',
// ),
// SizedBox(height: height / 50),
// Row(
//   children: [
//     SizedBox(width: width / 20),
//     estbutton(),
//   ],
// ),
// SizedBox(height: height / 50),
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 14),
//   child: Divider(color: notifier.getgrey),
// ),
// SizedBox(height: height / 50),
// Row(
//   children: [
//     SizedBox(width: width / 20),
//     Icon(Icons.receipt_long,
//         color: notifier.getstarcolor, size: height / 35),
//     SizedBox(width: width / 35),
//     Text(
//       "#12312534",
//       style: TextStyle(
//         color: notifier.getblackcolor,
//         fontFamily: 'GilroyBold',
//         fontSize: height / 55,
//       ),
//     ),
//     const Spacer(),
//     Text(
//       "17/04/2022",
//       style: TextStyle(
//         color: notifier.getgrey,
//         fontFamily: 'GilroyMedium',
//         fontSize: height / 55,
//       ),
//     ),
//     SizedBox(width: width / 20),
//   ],
// ),
// SizedBox(height: height / 50),
// CusttomDeliverdOrder(
//   id: '',
//   image: "assets/foodmenu.png",
//   txt: LanguageEn.steakbeet,
//   rate: "\$230",
//   qty: 1,
//   totalAmount: '20',
// ),
// SizedBox(height: height / 50),
// Row(
//   children: [
//     SizedBox(width: width / 20),
//     estbutton(),
//   ],
// ),
// SizedBox(height: height / 40),
