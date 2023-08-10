import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import '../../../constants/utils.dart';
import '../../../custtomscreens/custtombutton.dart';
import '../../../models/upi.dart';
import '../../../providers/user_provider.dart';
import '../../../services/background_service.dart';
import '../../../services/order_services.dart';
import '../../../services/upi_services.dart';
import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';
import '../../ordersucsess.dart';

class ShowQRScreen extends StatefulWidget {
  static const routeName = '/show-qr';
  ShowQRScreen(
      {required this.name, required this.phone, required this.additional});

  final name;
  final phone;
  final additional;

  @override
  State<ShowQRScreen> createState() => _ShowQRScreenState();
}

class _ShowQRScreenState extends State<ShowQRScreen> {
  late ColorNotifier notifier;
  bool isLoading = false;
  UPIModel upi = UPIModel();
  UPIServices upiServices = UPIServices();

  final OrderServices orderServices = OrderServices();

  var myupiDetails;

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
    getUpiDetails();
  }

  getUpiDetails() async {
    setState(() {
      isLoading = true;
    });
    upi = await upiServices.getUpiDetails(context);
    int amount = Provider.of<UserProvider>(context, listen: false).subtotal;
    myupiDetails = UPIDetails(
      upiID: upi.upi!,
      payeeName: upi.businessName!,
      amount: amount.toDouble(),
      transactionNote: 'Testing payment',
    );

    setState(() {
      isLoading = false;
    });
  }

  void checkout(double lat, double long, int amount) async {
    Placemark first = await latlngToAddress(lat, long);
    print(first);
    print(lat.toString());
    print(long.toString());

    // store vehicle info for background trip create

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // // order place
    showSnackBar('your order is sending to seller');
    await orderServices.orderPlace(
      context: context,
      name: widget.name,
      state: first.administrativeArea.toString(),
      city: first.subAdministrativeArea.toString(),
      phoneNo: widget.phone,
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
    notifier = Provider.of<ColorNotifier>(context);
    final provider = Provider.of<UserProvider>(context, listen: false);
    final blackStyle = TextStyle(
      color: notifier.getblackcolor,
      fontFamily: 'GilroyBold',
      fontSize: height / 55,
    );

    final greenStyle = TextStyle(
      color: notifier.getred,
      fontFamily: 'GilroyBold',
      fontSize: height / 55,
    );
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
          'QR Code',
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
          : Center(
              child: Column(
                children: [
                  SizedBox(
                    height: height / 20,
                  ),
                  UPIPaymentQRCode(
                    upiDetails: myupiDetails,
                    size: 300,
                    embeddedImagePath: 'assets/buynow.png',
                    embeddedImageSize: const Size(60, 60),
                    upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.high,
                    qrCodeLoader: Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Upi id: ',
                        style: blackStyle,
                      ),
                      SelectableText(
                        '${myupiDetails.upiID}',
                        style: greenStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  Text('OR', style: blackStyle),
                  SizedBox(
                    height: height / 60,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1. Hold the above given upi id to copy it.',
                          textDirection: TextDirection.ltr,
                          style: blackStyle,
                        ),
                        SizedBox(
                          height: height / 100,
                        ),
                        Text(
                          '2. Open your UPI payment app (Gpay, Phonepe)',
                          textDirection: TextDirection.ltr,
                          style: blackStyle,
                        ),
                        SizedBox(
                          height: height / 100,
                        ),
                        Text(
                          '3. Click on Pay UPI ID',
                          textDirection: TextDirection.ltr,
                          style: blackStyle,
                        ),
                        SizedBox(
                          height: height / 100,
                        ),
                        Text(
                          '4. Paste the UPI ID you have copied before',
                          textDirection: TextDirection.ltr,
                          style: blackStyle,
                        ),
                        SizedBox(
                          height: height / 100,
                        ),
                        Text(
                          '5. Click on verify to whom you are paying',
                          textDirection: TextDirection.ltr,
                          style: blackStyle,
                        ),
                        SizedBox(
                          height: height / 100,
                        ),
                        Text(
                          '6. Enter amount and pay',
                          textDirection: TextDirection.ltr,
                          style: blackStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
      bottomNavigationBar: GestureDetector(
        onTap: () => checkout(provider.consumerLatitude!,
            provider.consumerLongitude!, provider.subtotal),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: button(
            notifier.getred,
            notifier.getwhite,
            "Confirm",
            width / 1.1,
          ),
        ),
      ),
    );
  }
}