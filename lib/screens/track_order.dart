import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/mediaqury.dart';
import '../utils/notifirecolor.dart';

class TrackOrder extends StatefulWidget {
  static const routeName = '/track-order';
  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  late ColorNotifier notifier;
  var ratingLength;

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

  List statusList = [
    'Order pending',
    'Order confirmed',
    'Order dispatched',
    'Order delivered',
  ];

  List statusIndex = [
    'pending',
    'confirmed',
    'dispatched',
    'delivered',
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final orderId = args['orderId'];
    final status = args['status'].toString().toLowerCase();
    return Scaffold(
      backgroundColor: notifier.getwhite,
      appBar: AppBar(
        backgroundColor: notifier.getwhite,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: notifier.getblackcolor,
            size: height / 30,
          ),
        ),
        title: Text(
          'Track orders',
          style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 45,
              fontFamily: 'GilroyBold'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Order ID : $orderId",
              style: TextStyle(
                color: notifier.getblackcolor,
                fontFamily: 'GilroyBold',
                fontSize: height / 55,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Text(
              "Orders",
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 45,
                  fontFamily: 'GilroyBold'),
            ),
          ),
          Row(
            children: [
              Container(
                height: height / 2,
                width: width / 7,
                child: IconStepper(
                  direction: Axis.vertical,
                  enableNextPreviousButtons: false,
                  enableStepTapping: false,
                  stepColor: Colors.green,
                  activeStepBorderColor: notifier.getwhite,
                  activeStepBorderWidth: 0.0,
                  activeStepBorderPadding: 0.0,
                  lineColor: Colors.green,
                  lineLength: height / 11,
                  lineDotRadius: 2.0,
                  stepRadius: height / 50,
                  icons: [
                    Icon(
                        (status == statusIndex[0] ||
                                statusIndex.indexOf(status) < 3)
                            ? Icons.check
                            : Icons.radio_button_checked,
                        color: notifier.getwhite),
                    Icon(
                        (status == statusIndex[1] ||
                                statusIndex.indexOf(status) > 2)
                            ? Icons.check
                            : Icons.radio_button_checked,
                        color: notifier.getwhite),
                    Icon(
                        (status == statusIndex[2] ||
                                statusIndex.indexOf(status) > 3)
                            ? Icons.check
                            : Icons.radio_button_checked,
                        color: notifier.getwhite),
                    Icon(
                        (status == statusIndex[3] ||
                                statusIndex.indexOf(status) > 4)
                            ? Icons.check
                            : Icons.radio_button_checked,
                        color: notifier.getwhite),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: height / 40,
                            ),
                            title: Text(
                              statusList[index],
                              style: TextStyle(
                                  color: notifier.getblackcolor,
                                  fontSize: height / 45,
                                  fontFamily: 'GilroyBold'),
                            ),
                            subtitle: Text(
                              'We are preparing your order',
                              style: TextStyle(
                                  color: notifier.getgrey,
                                  fontSize: height / 55,
                                  fontFamily: 'GilroyMedium'),
                            ),
                          ),
                        ),
                        Text(
                          '10:00 AM',
                          style: TextStyle(
                              color: notifier.getred,
                              fontSize: height / 55,
                              fontFamily: 'GilroyMedium'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showDialog();
              },
              child: button(notifier.getred, notifier.getwhite, 'Rate Product',
                  width / 1.1),
            ),
          ),
          SizedBox(
            height: height / 40,
          ),
          Center(
            child: button(
                notifier.getred, notifier.getwhite, 'Return', width / 1.1),
          )
        ],
      ),
    );
  }

  Future<bool?> _showDialog() {
    return showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: notifier.getwhite,
        content: Container(
          color: Colors.transparent,
          height: height / 5.2,
          child: Column(
            children: [
              SizedBox(height: height / 130),
              Text(
                'Rate the product',
                style: TextStyle(
                  color: notifier.getgrey,
                  fontSize: height / 40,
                  fontFamily: 'GilroyBold',
                ),
              ),
              SizedBox(height: height / 50),
              // Text(
              //   'Are you sure?',
              //   style: TextStyle(
              //     color: notifier.getblackcolor,
              //     fontSize: height / 50,
              //     fontFamily: 'GilroyMedium',
              //   ),
              // ),
              // SizedBox(height: height / 50),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.pop(ctx, false);
              //       },
              //       child:
              //           dailogbutton(Colors.transparent, 'No', notifier.getred),
              //     ),
              //     GestureDetector(
              //       onTap: () async {
              //         Navigator.pop(ctx, true);
              //       },
              //       child: dailogbutton(
              //           Colors.transparent, 'Yes', notifier.getred),
              //     ),
              //   ],
              // )
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: notifier.getstarcolor,
                ),
                onRatingUpdate: (rating) {
                  ratingLength = rating;
                  print(ratingLength);
                },
                glow: false,
              ),
              SizedBox(
                height: height / 50,
              ),
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: dailogbutton(
                          Colors.transparent, 'Submit', notifier.getred)),
                ],
              )
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
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
