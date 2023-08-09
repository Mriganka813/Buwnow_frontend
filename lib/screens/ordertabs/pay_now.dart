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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UPIPaymentQRCode(
                    upiDetails: myupiDetails,
                    size: 200,
                    embeddedImagePath: 'assets/buynow.png',
                    embeddedImageSize: const Size(60, 60),
                    upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.high,
                    qrCodeLoader: Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Text('Upi id: ' + myupiDetails.upiID)
                ],
              ),
            ),
    );
  }
}
