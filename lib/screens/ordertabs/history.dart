import 'package:buynow/constants/utils.dart';
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
import '../../services/cute_services.dart';
import '../../services/order_services.dart';

class Historytabs extends StatefulWidget {
  const Historytabs({Key? key}) : super(key: key);

  @override
  State<Historytabs> createState() => _HistorytabsState();
}

class _HistorytabsState extends State<Historytabs> {
  late ColorNotifier notifier;

  bool _isLoading = false;
  final OrderServices _orderServices = OrderServices();
  List<Order> _orderHistory = [];
  int _orderLength = 0;

  final _phoneController = TextEditingController();

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

  // get orders history
  getOrderHistory() async {
    setState(() {
      _isLoading = true;
    });
    _orderHistory = await _orderServices.orderHistory();
    _orderLength = _orderHistory.length;

    if (_orderLength == 0) {
      showSnackBar('No Orders');
      return;
    }

    if (mounted)
      setState(() {
        _isLoading = false;
      });
  }

  getItemsLength() {
    for (int i = 0; i < _orderHistory.length; i++) {
      List<Items>? items = _orderHistory[i].items;
      _orderLength += items!.length;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getwhite,
      body: _isLoading
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
                        itemCount: _orderLength,
                        itemBuilder: (context, index) {
                          final order = _orderHistory[index];
                          final orderId = order.sId;
                          final date =
                              order.createdAt.toString().substring(0, 10);
                          final List<Items>? items = _orderHistory[index].items;
                          final phoneNo = order.sellerNum;

                          return Column(
                            children: [
                              ListView.builder(
                                itemCount: items!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  // final prodId = items[i].productId;
                                  final qty = items[i].quantity!.toInt();
                                  // final prodName = items[i].productName;
                                  final prodPrice =
                                      items[i].productPrice!.toInt();
                                  final totalAmount = qty * prodPrice;
                                  // final status = items[i].status;
                                  // final prodImage = items[i].productImage ?? '';
                                  // final sellerId = items[i].sellerId;

                                  return historyItem(
                                    orderId!,
                                    date,
                                    totalAmount,
                                    phoneNo!,
                                    items[i],
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
    // int qty,
    // String prodName,
    // int prodPrice,
    int totalAmount,
    // String status,
    // String prodId,
    String phoneNo,
    // String image,
    // String sellerId,
    Items items,
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
          onTap: () async {
            Provider.of<UserProvider>(context, listen: false)
                .setTotalPriceOfCartItems(totalAmount);
            Provider.of<UserProvider>(context, listen: false)
                .setSellerId(items.sellerId!);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? token = prefs.getString('cuteToken');

            if (token == null) {
              await phoneDialog(
                  items.productId!, orderId, items.status!, context);
            } else {
              Navigator.of(context)
                  .pushNamed(TrackOrderScreen.routeName, arguments: {
                'prodId': items.productId,
                'orderId': orderId,
                'status': items.status,
              });
            }
          },
          child: CusttomDeliverdOrder(
            id: '',
            image: items.productImage ?? '',
            txt: items.productName!,
            rate: '₹' + items.productPrice.toString(),
            qty: items.quantity!,
            totalAmount: totalAmount.toString(),
          ),
        ),
        SizedBox(height: height / 50),
        Row(
          children: [
            SizedBox(width: width / 20),

            // status button
            estbutton(items.status!, false),
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

  // to launch dialer pad
  void _launchDialer(String phoneNo) async {
    int phone = int.parse(phoneNo);
    var phoneNumber = '+91$phone'; // Replace with your desired phone number

    final uri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  // if cuteToken is null then first it take phone number to store cuteToken and refresh token
  phoneDialog(String prodId, String orderId, String status, BuildContext ctx) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 200.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Phone number",
                  style: TextStyle(
                    color: notifier.getblackcolor,
                    fontFamily: 'GilroyBold',
                    fontSize: height / 55,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Your phone number',
                    hintStyle: TextStyle(
                      color: notifier.getgrey,
                      fontFamily: 'GilroyMedium',
                      fontSize: height / 55,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        CuteServices cuteServices = CuteServices();
                        int statuscode = await cuteServices.cuteLogin(
                            context, _phoneController.text);

                        if (statuscode == 200) {
                          Navigator.of(ctx).pushNamed(
                              TrackOrderScreen.routeName,
                              arguments: {
                                'prodId': prodId,
                                'orderId': orderId,
                                'status': status,
                              });
                        } else {
                          return;
                        }
                      },
                      child: Container(
                        width: (width / 3.5),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: notifier.getred,
                            fontFamily: 'GilroyBold',
                            fontSize: height / 55,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
