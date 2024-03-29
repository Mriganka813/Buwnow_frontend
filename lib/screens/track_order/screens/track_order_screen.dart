import 'package:buynow/models/trip_order.dart';
import 'package:buynow/screens/ordertabs/pay_now.dart';
import 'package:buynow/screens/track_order/screens/track_order.dart';
import 'package:buynow/services/product_services.dart';
import 'package:buynow/services/trip_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:buynow/custtomscreens/custtombutton.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';

class TrackOrderScreen extends StatefulWidget {
  static const routeName = '/track-order';
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  late ColorNotifier notifier;
  int? _ratingLength;
  bool _ispending = false;
  bool _isconfirm = false;
  bool _isontheway = false;
  bool _isdeliver = false;

  bool _isLoading = false;

  ProductServices _productServices = ProductServices();
  TripServices _getAllTripsService = TripServices();
  List<TripModel> _order = [];

  TripServices tripService = TripServices();

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
    getAllTrips();
    getdarkmodepreviousstate();
  }

  // get all trips
  getAllTrips() async {
    setState(() {
      _isLoading = true;
    });
    await tripService.getNewToken().then((value) async {
      _order = await _getAllTripsService.getAllTrips('activeOrder');
    });

    setState(() {
      _isLoading = false;
    });
  }

  List _statusList = [
    'Order pending',
    'Order confirmed',
    'Order dispatched',
    'Order delivered',
  ];

  List _statusIndex = [
    'pending',
    'confirmed',
    'on the way',
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
    final prodId = args['prodId'].toString();

    TripModel? trip = _order.firstWhere(
      (element) {
        print('trip:${element.orderId}');
        return element.orderId == orderId;
      },
      orElse: () {
        return TripModel(orderId: null);
      },
    );

    //
    if (_statusIndex.indexOf(status) < 1) {
      _ispending = true;
    } else if (_statusIndex.indexOf(status) < 2) {
      _ispending = true;
      _isconfirm = true;
    } else if (_statusIndex.indexOf(status) < 3) {
      _ispending = true;
      _isconfirm = true;
      _isontheway = true;
    } else if (_statusIndex.indexOf(status) < 4) {
      _ispending = true;
      _isconfirm = true;
      _isontheway = true;
      _isdeliver = true;
    }

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
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
                                (_ispending)
                                    ? Icons.check
                                    : Icons.radio_button_checked,
                                color: notifier.getwhite),
                            Icon(
                                (_isconfirm)
                                    ? Icons.check
                                    : Icons.radio_button_checked,
                                color: notifier.getwhite),
                            Icon(
                                (_isontheway)
                                    ? Icons.check
                                    : Icons.radio_button_checked,
                                color: notifier.getwhite),
                            Icon(
                                (_isdeliver)
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: height / 40,
                                    ),
                                    title: Text(
                                      _statusList[index],
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
                                // Text(
                                //   '10:00 AM',
                                //   style: TextStyle(
                                //       color: notifier.getred,
                                //       fontSize: height / 55,
                                //       fontFamily: 'GilroyMedium'),
                                // ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: height / 40,
                  ),
                  // Center(
                  //   child: button(notifier.getred, notifier.getwhite, 'Return',
                  //       width / 1.1),
                  // ),
                  // SizedBox(
                  //   height: height / 40,
                  // ),

                  // SizedBox(
                  //   height: height / 40,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(PayNow.routeName);
                          },
                          child: button(notifier.getred, notifier.getwhite,
                              'Pay Now', width / 2.3),
                        ),
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      trip.orderId != null
                          ? Center(
                              child: GestureDetector(
                                  onTap: () async {
                                    print('trip1:${trip.orderId}');
                                    print(trip.status);
                                    if (trip.status != 'WAITING FOR DRIVER') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TrackOrder(order: trip),
                                          ));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              title: Text("Alert"),
                                              content: Text(
                                                  "Driver has not been assigned yet"),
                                              actions: [
                                                TextButton(
                                                  child: Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: button(
                                      notifier.getred,
                                      notifier.getwhite,
                                      'Track Order',
                                      width / 2.3)),
                            )
                          :
                          // if product is delivered then
                          _isdeliver
                              ? Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      _showDialog(prodId);
                                    },
                                    child: button(
                                        notifier.getred,
                                        notifier.getwhite,
                                        'Rate Product',
                                        width / 2.3),
                                  ),
                                )
                              : Container()
                    ],
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  trip.driverNumber != null
                      ? InkWell(
                          onTap: () => _launchDialer(trip.driverNumber!),
                          child: Center(
                            child: button(notifier.getred, notifier.getwhite,
                                'Call Driver', width / 1.1),
                          ))
                      : Container(),
                ],
              ),
            ),
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

  Future<bool?> _showDialog(String prodId) {
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
                  _ratingLength = rating.toInt();
                  print(_ratingLength);
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
                      onTap: () async {
                        if (_ratingLength == null) {
                          return;
                        }
                        print(prodId); //64b7e5e42aef5e451d77e252
                        await _productServices.rating(
                            prodId, context, _ratingLength!);
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
            fontSize: height / 40,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }
}
