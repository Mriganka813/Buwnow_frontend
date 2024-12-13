import 'package:flutter/material.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/custtomscreens/custtombutton.dart';
import 'package:buynow/custtomscreens/textfild.dart';
import 'package:buynow/screens/order_confirmation.dart/screens/orderconfirmation.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends StatefulWidget {
  static const routeName = '/address';
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  late ColorNotifier notifire;
  bool isLoading = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final flatController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  final pincodeController = TextEditingController();
  final additonalController = TextEditingController();

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    flatController.dispose();
    cityController.dispose();
    stateController.dispose();
    additonalController.dispose();
    pincodeController.dispose();
  }

  confirmAddress() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final street = flatController.text.trim();
    final city = cityController.text.trim();
    final state = stateController.text.trim();
    final pincode = pincodeController.text.trim();
    final additional = additonalController.text.trim();

    if (name.isEmpty ||
        phone.isEmpty ||
        street.isEmpty ||
        city.isEmpty ||
        state.isEmpty ||
        pincode.isEmpty) {
      showSnackBar('Please fill all the fields');
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
        context, OrderConformation.routeName, (route) => false,
        arguments: {
          'name': name,
          'phoneNumber': phone,
          'street': street,
          'city': city,
          'state': state,
          'pincode': pincode,
          'additonal': additional,
        });
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifire.getwhite,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: height / 33,
            color: notifire.getblackcolor,
          ),
        ),
        title: Text(
          LanguageEn.deliveryadds,
          style: TextStyle(
              color: notifire.getblackcolor,
              fontFamily: 'GilroyBold',
              fontSize: height / 43),
        ),
      ),
      backgroundColor: notifire.getwhite,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height / 50),
                  Container(
                    color: Colors.transparent,
                    width: width / 1.1,
                    child: Column(
                      children: [
                        Customtextfild.textField(
                            LanguageEn.enteryourfullname,
                            notifire.getblackcolor,
                            width / 1.13,
                            Icons.person,
                            notifire.getbgfildcolor,
                            nameController,
                            false),
                        SizedBox(height: height / 40),
                        Customtextfild.textField(
                            LanguageEn.enteryourphonenumber,
                            notifire.getblackcolor,
                            width / 1.13,
                            Icons.call,
                            notifire.getbgfildcolor,
                            phoneController,
                            false),
                        SizedBox(height: height / 40),
                        Customtextfild.textField(
                            LanguageEn.adresslineone,
                            notifire.getblackcolor,
                            width / 1.13,
                            Icons.location_on_outlined,
                            notifire.getbgfildcolor,
                            flatController,
                            false),
                        SizedBox(height: height / 40),
                        Customtextfild.textField(
                            LanguageEn.adresslinetwo,
                            notifire.getblackcolor,
                            width / 1.13,
                            Icons.location_on_outlined,
                            notifire.getbgfildcolor,
                            cityController,
                            false),
                        SizedBox(height: height / 40),
                        Customtextfild.textField(
                            LanguageEn.adresslinethree,
                            notifire.getblackcolor,
                            width / 1.13,
                            Icons.location_on_outlined,
                            notifire.getbgfildcolor,
                            stateController,
                            false),

                        SizedBox(height: height / 40),
                        Customtextfild.textField(
                            LanguageEn.pincode,
                            notifire.getblackcolor,
                            width / 1.13,
                            Icons.location_on_outlined,
                            notifire.getbgfildcolor,
                            pincodeController,
                            false),
                        SizedBox(height: height / 40),
                        Customtextfild.textField(
                            LanguageEn.additional,
                            notifire.getblackcolor,
                            width / 1.13,
                            Icons.location_on_outlined,
                            notifire.getbgfildcolor,
                            additonalController,
                            false),

                        // Row(
                        //   children: [
                        //     SizedBox(width: width / 50),
                        //     // Transform.scale(
                        //     //   scale: 1,
                        //     //   child: Checkbox(
                        //     //     shape: const RoundedRectangleBorder(
                        //     //       borderRadius: BorderRadius.all(
                        //     //         Radius.circular(5),
                        //     //       ),
                        //     //     ),
                        //     //     activeColor: notifire.getred,
                        //     //     side: BorderSide(color: notifire.getred),
                        //     //     value: isChecked,
                        //     //     onChanged: (bool? value) {
                        //     //       setState(() {
                        //     //         isChecked = value!;
                        //     //       });
                        //     //     },
                        //     //   ),
                        //     // ),
                        //     // Column(
                        //     //   crossAxisAlignment: CrossAxisAlignment.start,
                        //     //   children: [
                        //     //     Row(
                        //     //       children: [
                        //     //         Text(
                        //     //           LanguageEn.selects,
                        //     //           style: TextStyle(
                        //     //               fontSize: height / 55, color: Colors.grey),
                        //     //         ),
                        //     //       ],
                        //     //     ),
                        //     //   ],
                        //     // ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 9.5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 15),
                    child: GestureDetector(
                      onTap: confirmAddress,
                      child: button(notifire.getred, notifire.getwhite,
                          LanguageEn.confirm, width / 1.1),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
