import 'package:buynow/constants/utils.dart';
import 'package:buynow/models/upi.dart';
import 'package:buynow/providers/user_provider.dart';

import 'package:buynow/services/delivery_charges_services.dart';
import 'package:buynow/services/order_services.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import '../../../custtomscreens/custtombutton.dart';
import '../../../models/new_trip_input.dart';
import '../../../models/vehicle.dart';
import '../../../services/background_service.dart';

import '../../../services/trip_services.dart';
import '../../../services/upi_services.dart';
import '../../../utils/enstring.dart';
import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';
import '../../order_confirmation.dart/widgets/show_model_bottom_sheet.dart';
import '../../ordersucsess.dart';

class PaymentDetailsScreen extends StatefulWidget {
  static const routeName = '/payment-details';

  PaymentDetailsScreen(
      {required this.name, required this.phoneNo, this.additional = ''});

  final name;
  final phoneNo;
  final additional;

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  late ColorNotifier notifier;
  bool isLoading = false;
  // int _groupValue = -1;
  int deliveryGroupValue = -1;
  int deliveryCharge = 0;
  List<Vehicle> vehicles = [];
  int total = 0;

  UPIServices upiServices = UPIServices();
  UPIModel upi = UPIModel();

  // static const MethodChannel _channel = MethodChannel('upi_payment');

  var sellerupiDetails;
  var myupiDetails;

  NewTripInput input = NewTripInput();
  // final upiPaymentHandler = UpiPaymentHandler();

  TripServices trip = TripServices();

  final OrderServices orderServices = OrderServices();
  DeliveryServices deliveryServices = DeliveryServices();

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
    getUPIData();
  }

  getUPIData() async {
    setState(() {
      isLoading = true;
    });
    upi = await upiServices.getUpiDetails(context);
    int subtotal = Provider.of<UserProvider>(context, listen: false).subtotal;
    sellerupiDetails = UPIDetails(
        upiID: upi.upi!,
        payeeName: upi.businessName!,
        amount: subtotal.toDouble());

    myupiDetails = UPIDetails(
      upiID: "6388415501@ybl",
      payeeName: "Sachin Patel",
      amount: subtotal.toDouble(),
      transactionNote: 'Testing payment',
    );

    setState(() {
      isLoading = false;
    });
  }

  // void _initiateTransaction(double amount) async {
  //   try {
  //     bool success = await upiPaymentHandler.initiateTransaction(
  //       payeeVpa: 'Magicstep.in@oksbi',
  //       payeeName: 'Magic step',
  //       transactionRefId: 'TXN123456',
  //       transactionNote: 'Test transaction',
  //       amount: amount,
  //     );
  //     print('success = $success');
  //     if (success) {
  //       // Handle successful transaction initiation
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Transaction initiated successfully!')));
  //     } else {
  //       // Handle unsuccessful transaction initiation
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text('Transaction initiated not successfully!')));
  //     }
  //   } on PlatformException catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.toString())));
  //     // Handle errors when UPI is not supported on the user's device
  //   }
  // }

  // Future<TransactionDetailModel?> initiateTransaction(int amount) async {
  //   TransactionDetailModel? res;
  //   try {
  //     res = await EasyUpiPaymentPlatform.instance.startPayment(
  //       EasyUpiPaymentModel(
  //         payeeVpa: 'Magicstep.in@oksbi',
  //         payeeName: 'Magic step',
  //         amount: amount.toDouble(),
  //         description: 'Testing payment',
  //         transactionRefId: 'TXN123456',
  //       ),
  //     );
  //
  //     print("res=$res");
  //   } on EasyUpiPaymentException catch (e) {
  //     showSnackBar(e.toString());
  //
  //   }
  //   print("response=$res");
  //   return res;
  // }

  // static Future<void> initiateTransaction({
  //   required String merchantVpa,
  //   required String merchantName,
  //   required String merchantCode,
  //   required String transactionRefId,
  //   required String transactionNote,
  //   required String orderAmount,
  //   required String transactionUrl,
  // }) async {
  //   final Map<String, dynamic> arguments = {
  //     'merchantVpa': merchantVpa,
  //     'merchantName': merchantName,
  //     'merchantCode': merchantCode,
  //     'transactionRefId': transactionRefId,
  //     'transactionNote': transactionNote,
  //     'orderAmount': orderAmount,
  //     'transactionUrl': transactionUrl,
  //   };
  //   await _channel.invokeMethod('initiateTransaction', arguments);
  // }

  deliveryChargeCalculation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lat = prefs.getString('lat');
    String? long = prefs.getString('long');
    final provider = Provider.of<UserProvider>(context, listen: false);
    if (lat == null ||
        long == null ||
        provider.consumerLatitude == null ||
        provider.consumerLongitude == null) {
      showSnackBar('Please add items to cart');
      return;
    }
    // print('$lat' +
    //     '$long' +
    //     '${provider.consumerLatitude}' +
    //     '${provider.consumerLongitude}');
    vehicles = await deliveryServices.deliveryFairCharges(
        double.parse(lat),
        double.parse(long),
        provider.consumerLatitude!,
        provider.consumerLongitude!,
        context);
  }

  void checkout(double lat, double long, int amount) async {
    if (deliveryGroupValue == -1 || deliveryCharge == 0) {
      showSnackBar('Please choose delivery method');
      return;
    }
    // if (_groupValue == -1) {
    //   showSnackBar('Please choose your payment method');
    //   return;
    // }

    Placemark first = await latlngToAddress(lat, long);
    print(first);
    print(lat.toString());
    print(long.toString());

    // store vehicle info for background trip create

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('serviceAreaId', vehicles[0].serviceAreaId!);
    await prefs.setString('vehicleId', vehicles[0].id!);
    await prefs.setDouble('price', vehicles[0].price!);

    // if (_groupValue == 0) {
    // } else if (_groupValue == 1) {
    //   print(total);
    // await initiateTransaction(
    //   merchantVpa: '6000637319-1@okbizaxis',
    //   merchantName: 'Urban fast food',
    //   merchantCode: 'BCR2DN4T4SUJ7PBX',
    //   transactionRefId: 'TXN638841',
    //   transactionNote: 'Testing payment',
    //   orderAmount: '1',
    //   transactionUrl: OrderSucsess.routeName,
    // );
    // }

    // // order place
    showSnackBar('your order is sending to seller');
    await orderServices.orderPlace(
      context: context,
      name: widget.name,
      state: first.administrativeArea.toString(),
      city: first.subAdministrativeArea.toString(),
      phoneNo: widget.phoneNo,
      pincode: first.postalCode.toString(),
      streetAddress: first.street.toString(),
      latitude: lat.toString(),
      longitude: long.toString(),
      additional: widget.additional,
    );

    // prefs.setInt('orderAmount', amount);

    // initialize background service
    initializeService();

    prefs.setString('upi', upi.upi!);

    Navigator.pushNamed(context, OrderSucsess.routeName);
  }

  Future<Placemark> latlngToAddress(double latitude, double longitude) async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(latitude, longitude);
    var first = addresses.first;
    print(first.name! +
        ',' +
        first.subAdministrativeArea! +
        ',' +
        first.locality! +
        ',' +
        first.country! +
        ',' +
        first.postalCode!);
    return first;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    final provider = Provider.of<UserProvider>(context, listen: false);

    total = provider.subtotal + deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.getwhite,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,
              color: notifier.getblackcolor, size: height / 50),
        ),
        centerTitle: true,
        title: Text(
          'Payment Details',
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: height / 50,
                ),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      LanguageEn.subtotals,
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 50,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '₹' + provider.subtotal.toString(),
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 50,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(width: width / 20),
                  ],
                ),
                SizedBox(height: height / 100),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      LanguageEn.deliverycharges,
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 50,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '₹${deliveryCharge}',
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 50,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(width: width / 20),
                  ],
                ),
                SizedBox(height: height / 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Row(children: [
                  SizedBox(width: width / 20),
                  Text(
                    LanguageEn.total,
                    style: TextStyle(
                      color: notifier.getblackcolor,
                      fontSize: height / 50,
                      fontFamily: 'GilroyBold',
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹${total}',
                    style: TextStyle(
                      color: notifier.getblackcolor,
                      fontSize: height / 50,
                      fontFamily: 'GilroyBold',
                    ),
                  ),
                  SizedBox(
                    width: width / 20,
                  )
                ]),
                SizedBox(height: height / 30),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      'Choose your delivery method',
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 50,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 30),
                chashtype(
                    '₹${deliveryCharge}',
                    "assets/motorcycle.png",
                    height / 29,
                    0,
                    Radio(
                      activeColor: notifier.getred,
                      value: 0,
                      groupValue: deliveryGroupValue,
                      onChanged: (value) async {
                        deliveryGroupValue = 0;

                        await deliveryChargeCalculation();
                        vehicles = vehicles
                            .where((vh) => vh.name == 'Motorcycle')
                            .toList();
                        print("vehicles=$vehicles");
                        deliveryCharge = vehicles[0].price!.toDouble().ceil();

                        setState(() {
                          deliveryGroupValue = value as int;
                        });
                      },
                    ),
                    notifier),
                SizedBox(height: height / 15),
                // Row(
                //   children: [
                //     SizedBox(width: width / 20),
                //     Text(
                //       'Choose your payment method',
                //       style: TextStyle(
                //         color: notifier.getgrey,
                //         fontSize: height / 50,
                //         fontFamily: 'GilroyMedium',
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: height / 30),
                // GestureDetector(
                //   onTap: () {
                //     setState(
                //       () {
                //         _groupValue = 0;
                //       },
                //     );
                //   },
                //   child: chashtype(
                //       LanguageEn.cash,
                //       "assets/cash.png",
                //       height / 29,
                //       0,
                //       Radio(
                //         activeColor: notifier.getred,
                //         value: 0,
                //         groupValue: _groupValue,
                //         onChanged: (value) {
                //           setState(() {
                //             _groupValue = value as int;
                //           });
                //         },
                //       ),
                //       notifier),
                // ),
                // SizedBox(height: height / 50),
                // GestureDetector(
                //   onTap: () {
                //     setState(
                //       () {
                //         _groupValue = 1;
                //       },
                //     );
                //   },
                //   child: chashtype(
                //     LanguageEn.cardvisa,
                //     "assets/visa.png",
                //     height / 32,
                //     1,
                //     Radio(
                //       activeColor: notifier.getred,
                //       value: 1,
                //       groupValue: _groupValue,
                //       onChanged: (value) {
                //         setState(() {
                //           _groupValue = value as int;
                //         });
                //       },
                //     ),
                //     notifier,
                //   ),
                // ),

                // QR code widget

                upi.upi == ''
                    ? UPIPaymentQRCode(
                        upiDetails: myupiDetails,
                        size: 200,
                        embeddedImagePath: 'assets/buynow.png',
                        embeddedImageSize: const Size(60, 60),
                        upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.high,
                        qrCodeLoader:
                            Center(child: CircularProgressIndicator()),
                      )
                    : UPIPaymentQRCode(
                        upiDetails: sellerupiDetails,
                        size: 200,
                        embeddedImagePath: 'assets/buynow.png',
                        embeddedImageSize: const Size(60, 60),
                        upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.high,
                        qrCodeLoader:
                            Center(child: CircularProgressIndicator()),
                      ),
                SizedBox(
                  height: height / 40,
                ),

                upi.upi == ''
                    ? Text('Upi id: ' + myupiDetails.upiID)
                    : Text('Upi id: ' + upi.upi!),
              ],
            ),
      bottomNavigationBar: GestureDetector(
        onTap: () => checkout(provider.consumerLatitude!,
            provider.consumerLongitude!, provider.subtotal),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: button(
            notifier.getred,
            notifier.getwhite,
            "Checkout",
            width / 1.1,
          ),
        ),
      ),
    );
  }
}
