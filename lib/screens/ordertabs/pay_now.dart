import 'package:buynow/models/upi.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:buynow/services/upi_services.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import '../../utils/mediaqury.dart';

class PayNow extends StatefulWidget {
  static const routeName = '/pay-now';
  const PayNow({Key? key}) : super(key: key);

  @override
  State<PayNow> createState() => _PayNowState();
}

class _PayNowState extends State<PayNow> {
  late ColorNotifier notifier;
  bool isLoading = false;
  UPIModel upi = UPIModel();
  UPIServices upiServices = UPIServices();

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

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context);
    final blackStyle = TextStyle(
      color: notifier.getblackcolor,
      fontFamily: 'GilroyMedium',
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

                  // qr code image
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

                      // to copy upi id
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
                  Text('Follow the instructions given below:',
                      style: blackStyle.copyWith(fontFamily: 'GilroyBold')),
                  SizedBox(
                    height: height / 60,
                  ),

                  // instructions
                  Container(
                    margin: EdgeInsets.only(left: 40),
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
                          '2. Open your UPI payment app (Google pay, Phonepe)',
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
    );
  }
}
