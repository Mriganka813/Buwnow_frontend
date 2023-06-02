import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/custtomscreens/textfild.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  late ColorNotifier notifire;
  bool isChecked = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();


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
    address1Controller.dispose();
    address2Controller.dispose();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 50),
            Container(
              color: Colors.transparent,
              height: height / 1.6,
              width: width / 1.1,
              child: Column(
                children: [
                  Customtextfild.textField(LanguageEn.enteryourfullname,
                      notifire.getblackcolor, width / 1.13, Icons.person,notifire.getbgfildcolor,nameController),
                  SizedBox(height: height / 40),
                  Customtextfild.textField(LanguageEn.enteryourphonenumber,
                      notifire.getblackcolor, width / 1.13, Icons.call,notifire.getbgfildcolor,phoneController),
                  SizedBox(height: height / 40),
                  Customtextfild.textField(
                      LanguageEn.adresslineone,
                      notifire.getblackcolor,
                      width / 1.13,
                      Icons.location_on_outlined,notifire.getbgfildcolor,address1Controller),
                  SizedBox(height: height / 40),
                  Customtextfild.textField(
                      LanguageEn.adresslinetwo,
                      notifire.getblackcolor,
                      width / 1.13,
                      Icons.location_on_outlined,notifire.getbgfildcolor,address2Controller),
                  SizedBox(height: height / 60),
                  Row(
                    children: [
                      SizedBox(width: width / 50),
                      Transform.scale(
                        scale: 1,
                        child: Checkbox(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          activeColor: notifire.getred,
                          side: BorderSide(color: notifire.getred),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                LanguageEn.selects,
                                style: TextStyle(
                                    fontSize: height / 55, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height / 9.5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: button(notifire.getred, notifire.getwhite,
                      LanguageEn.confirm, width / 1.1)),
            ),
          ],
        ),
      ),
    );
  }
}
