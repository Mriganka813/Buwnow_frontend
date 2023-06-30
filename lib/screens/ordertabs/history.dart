import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtomdeliverdorder.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<dynamic> orderHistory = [];
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
    orderHistory = await orderServices.orderHistory(context);
    orderLength = orderHistory.length;

    setState(() {
      isLoading = false;
    });
  }

  getItemsLength() {
    for (int i = 0; i < orderHistory.length; i++) {
      List items = orderHistory[i]['items'];
      orderLength += items.length;
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
                          final orderId = order['_id'];
                          final date =
                              order['createdAt'].toString().substring(0, 10);
                          final List items = orderHistory[index]['items'];

                          return Column(
                            children: [
                              ListView.builder(
                                itemCount: items.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  final qty = items[i]['quantity'];
                                  final prodName = items[i]['productName'];
                                  final prodPrice = items[i]['productPrice'];
                                  final totalAmount = qty * prodPrice;
                                  final status = items[i]['status'];

                                  return historyItem(orderId, date, qty,
                                      prodName, prodPrice, totalAmount, status);
                                },
                              )
                            ],
                          );
                        })),
              ),
            ),
    );
  }

  Widget estbutton(String status) {
    return Container(
      height: height / 28,
      width: width / 2.9,
      decoration: BoxDecoration(
        color: notifier.getred,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Center(
        child: Text(
          status.toUpperCase(),
          style: TextStyle(
            color: notifier.getwhite,
            fontSize: height / 60,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }

  Widget historyItem(String orderId, String date, int qty, String prodName,
      int prodPrice, int totalAmount, String status) {
    return Column(
      children: [
        SizedBox(height: height / 40),
        Row(
          children: [
            SizedBox(width: width / 20),
            Icon(Icons.receipt_long,
                color: notifier.getstarcolor, size: height / 35),
            SizedBox(width: width / 35),
            Text(
              "#$orderId",
              style: TextStyle(
                color: notifier.getblackcolor,
                fontFamily: 'GilroyBold',
                fontSize: height / 55,
              ),
            ),
            const Spacer(),
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
        CusttomDeliverdOrder(
          id: '',
          image: "assets/foodmenu.png",
          txt: prodName,
          rate: '₹' + prodPrice.toString(),
          qty: qty,
          totalAmount: totalAmount.toString(),
        ),
        SizedBox(height: height / 50),
        Row(
          children: [
            SizedBox(width: width / 20),
            estbutton(status),
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
