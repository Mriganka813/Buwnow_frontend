import 'package:buynow/constants/utils.dart';
import 'package:buynow/custtomscreens/textfild.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:buynow/screens/payment_details/screens/payment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../custtomscreens/custtombutton.dart';
import '../../../services/cute_services.dart';
import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = '/order-details';
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late ColorNotifier notifier;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final additionalController = TextEditingController();

  CuteServices cuteServices = CuteServices();

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

  orderConfirmed() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final additional = additionalController.text.trim();

    // validation
    if (name.isEmpty) {
      showSnackBar('Please enter name');
      return;
    } else if (phone.isEmpty) {
      showSnackBar('please enter phone number');
      return;
    }

    // cute login(for token) for calculating delivery charge
    int statuscode = await cuteServices.cuteLogin(context, phone);

    if (statuscode > 300) {
      return;
    }

    Navigator.of(context).pushNamed(PaymentDetailsScreen.routeName, arguments: {
      'name': name,
      'phone': phone,
      'additional': additional,
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    final provider = Provider.of<UserProvider>(context, listen: false);

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
          'Order Details',
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: height / 3.5,
            width: width,

            // static google map to show choosed location
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      provider.consumerLatitude!, provider.consumerLongitude!),
                  zoom: 14),
              scrollGesturesEnabled: false,
              minMaxZoomPreference: MinMaxZoomPreference.unbounded,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
              markers: Set<Marker>.of([
                Marker(
                  markerId: MarkerId('user_marker'),
                  position: LatLng(
                      provider.consumerLatitude!, provider.consumerLongitude!),
                )
              ]),
            ),
          ),
          SizedBox(
            height: height / 20,
          ),

          // enter your name
          Customtextfild.textField(
              'Enter your name',
              notifier.getblackcolor,
              width / 1.1,
              Icons.abc,
              notifier.getbgfildcolor,
              nameController,
              false),
          SizedBox(
            height: height / 50,
          ),

          // enter phone number to login in cute and order place
          Customtextfild.textField(
              'Enter your phone number',
              notifier.getblackcolor,
              width / 1.1,
              Icons.phone,
              notifier.getbgfildcolor,
              phoneController,
              false),
          SizedBox(
            height: height / 50,
          ),

          // additional field data
          Row(
            children: [
              SizedBox(width: width / 20),
              Text(
                'How to reach (optional)',
                style: TextStyle(
                  color: notifier.getgrey,
                  fontSize: height / 50,
                  fontFamily: 'GilroyMedium',
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 80,
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            color: Colors.grey.shade300,
            child: TextField(
              maxLines: 7,
              controller: additionalController,
            ),
          )
        ]),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: orderConfirmed,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: button(
            notifier.getred,
            notifier.getwhite,
            "Confirm Order",
            width / 1.1,
          ),
        ),
      ),
    );
  }
}
