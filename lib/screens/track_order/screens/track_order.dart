// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:buynow/models/trip_order.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';
import '../widgets/route_map.dart';

class TrackOrder extends StatefulWidget {
  TripModel order;
  TrackOrder({
    Key? key,
    required this.order,
  }) : super(key: key);
  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  late IO.Socket socket;
  late Set<String> notifications;
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
    connect();
    if (widget.order.status == 'STARTED') {
      notifications = Set<String>();
      notifications.add('Your trip has been started.');
    } else
      notifications = Set<String>();
  }

  /// Socket.io connection
  ///
  void connect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('cuteToken')!;
    print(token);
    print('custSocket = ${widget.order.customerSocket}');

    final socket = IO.io('http://65.0.7.20:8005/', <String, dynamic>{
      'transports': ['websocket'],
      'query': {
        'accessToken': '$token',
        'isReconnect': false,
        'previousId': widget.order.customerSocket,
        'role': 'CUSTOMER'
      }
    });
    setState(() {
      this.socket = socket;
    });

    // success
    socket.on('success', (data) {
      print(data);
    });

    // Driver location
    socket.on('driverLocation', (data) => print(data));

    // trip status
    socket.on('tripStatus', (data) => print(data));

    // driver at pickup
    socket.on('driverAtPickup', (data) {
      print(data);
      setState(() {
        notifications.add(data);
      });
    });

    // trip started
    socket.on('tripStarted', (data) {
      print(data);
      setState(() {
        notifications.add(data);
      });
    });

    // trip completed
    socket.on('tripCompleted', (data) {
      print(data);
      setState(() {
        notifications.add(data);
      });
    });

    socket.onError((data) => print(data));
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    return Scaffold(
      backgroundColor: notifier.getbgcolor,
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
          'Track Order',
          style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 45,
              fontFamily: 'GilroyBold'),
        ),
      ),
      bottomSheet: Wrap(
        children: [
          Material(
            elevation: 7.0,
            color: notifier.getwhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.query_stats_rounded,
                              color: notifier.getred, size: 25.0),
                          Text(
                            widget.order.status!,
                            style: TextStyle(
                              color: notifier.getred,
                              fontSize: height / 50,
                              fontFamily: 'GilroyBold',
                            ),
                          ),
                        ],
                      ),
                      // widthSpace,
                      // TextButton(
                      //     onPressed: () {
                      //       connect();
                      //     },
                      //     child: Icon(Icons.abc)),
                      // widthSpace,
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          strokeWidth: 1.2,
                          color: notifier.getblackcolor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              // width: 200.0,

                              decoration:
                                  BoxDecoration(color: notifier.getwhite),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: Text(
                                          'OTP : ',
                                          style: TextStyle(
                                            color: notifier.getred,
                                            fontSize: height / 50,
                                            fontFamily: 'GilroyMedium',
                                          ),
                                        )),
                                    Text(
                                      widget.order.otp ?? '',
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        color: notifier.getgrey,
                                        fontSize: height / 60,
                                        fontFamily: 'GilroyMedium',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Text(
                      //   'Delivery by',
                      //   style: greyNormalTextStyle,
                      // ),
                      // SizedBox(width: 5.0),
                      // Text(
                      //   '4:10 PM',
                      //   style: blackLargeTextStyle,
                      // ),
                      // Icon(Icons.keyboard_arrow_down,
                      //     color: notifier.getgrey, size: 24.0),
                    ],
                  ),
                ),
                getDevider(),

                SizedBox(
                  height: height / 60,
                ),
                StreamBuilder<Set<String>>(
                    stream: Stream.value(notifications),
                    builder: (context, AsyncSnapshot<Set<String>> snapshot) {
                      if (snapshot.hasData) {
                        Set<String>? updatedList = snapshot.data;

                        if (updatedList!.length > 0) {
                          return Container(
                            height: 60,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: updatedList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 60,
                                  child: Text(
                                    updatedList.elementAt(
                                        updatedList.length - index - 1),
                                    style: TextStyle(
                                      color: notifier.getred,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                          // Text(
                          //   updatedList.last,
                          //   style: blackHeadingTextStyle,
                          // );
                        } else {
                          notifications.add(
                              'Driver arriving at your location. \nPlease wait...');
                        }
                        return Text(
                          'Driver arriving at your location. \nPlease wait...',
                          style: TextStyle(
                            color: notifier.getgrey,
                            fontSize: height / 50,
                            fontFamily: 'GilroyMedium',
                          ),
                        );
                      } else {
                        return Text(
                          'Driver arriving at your location.\nPlease wait...',
                          style: TextStyle(
                            color: notifier.getgrey,
                            fontSize: height / 50,
                            fontFamily: 'GilroyMedium',
                          ),
                        );
                      }
                    }),

                getDevider(),
                // Container(
                //   padding: EdgeInsets.all(fixPadding * 2.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Container(
                //             width: 50.0,
                //             height: 50.0,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(25.0),
                //               image: DecorationImage(
                //                 image: AssetImage('assets/delivery_boy.jpg'),
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //           widthSpace,
                //           Text(
                //             'Peter Jones',
                //             style: blackLargeTextStyle,
                //           ),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           IconButton(
                //             icon: Icon(Icons.chat_bubble_outline,
                //                 color: greyColor, size: 28.0),
                //             onPressed: () {},
                //           ),
                //           IconButton(
                //             icon:
                //                 Icon(Icons.call, color: greyColor, size: 28.0),
                //             onPressed: () {},
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                getDevider(),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹ ${widget.order.price!.ceilToDouble().toInt()}',
                            style: TextStyle(
                              color: notifier.getred,
                              fontSize: height / 40,
                              fontFamily: 'GilroyBold',
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Order Details',
                          //       style: blueSmallTextStyle,
                          //     ),
                          //     SizedBox(width: 3.0),
                          //     Icon(Icons.arrow_forward_ios,
                          //         size: 10.0, color: greyColor),
                          //   ],
                          // ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Paid successfully',
                      //       style: greySmallTextStyle,
                      //     ),
                      //     SizedBox(width: 5.0),
                      //     Container(
                      //       width: 30.0,
                      //       height: 30.0,
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(15.0),
                      //         color: Colors.deepPurple.withOpacity(0.16),
                      //       ),
                      //       child: Icon(Icons.check,
                      //           color: Colors.deepPurple, size: 18.0),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: RouteMap(
          sourceLat: double.parse(widget.order.pickup!.lat!),
          sourceLang: double.parse(widget.order.pickup!.long!),
          destinationLat: double.parse(widget.order.drop!.lat!),
          destinationLang: double.parse(widget.order.drop!.long!),
          driverLat: double.parse(widget.order.subTrips![0].start!.lat!),
          driverLang: double.parse(widget.order.subTrips![0].start!.long!),
          socket: socket),
    );
  }

  getDevider() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 1.0,
      color: Colors.grey[200],
    );
  }
}
