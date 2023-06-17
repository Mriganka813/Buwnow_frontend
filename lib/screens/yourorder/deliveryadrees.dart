import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/screens/yourorder/adress.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressUpdates extends StatefulWidget {
  static const routeName = '/old-addresses';
  const AddressUpdates({Key? key}) : super(key: key);

  @override
  State<AddressUpdates> createState() => _AddressUpdatesState();
}

class _AddressUpdatesState extends State<AddressUpdates> {
  late ColorNotifier notifire;
  bool isChecked = false;
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
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifier>(context, listen: true);

    return Scaffold(
      backgroundColor: notifire.getwhite,
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
          LanguageEn.deliveryadd,
          style: TextStyle(
              color: notifire.getblackcolor,
              fontFamily: 'GilroyBold',
              fontSize: height / 43),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Address.routeName);
          },
          child: button(notifire.getred, notifire.getwhite,
              LanguageEn.newaddress, width / 1.1),
        ),
      ),
    );
  }

  Widget con(name) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Address(),
          ),
        );
      },
      child: Container(
        height: height / 9,
        width: width,
        decoration: BoxDecoration(
          color: notifire.getbgfildcolor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: height / 80,
            ),
            Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: width / 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: notifire.getblackcolor,
                              fontFamily: 'GilroyBold',
                              fontSize: height / 50),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Text(
                          LanguageEn.road,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'GilroyMedium',
                              fontSize: height / 65),
                        ),
                        SizedBox(
                          height: height / 200,
                        ),
                        Text(
                          "+88 012 356 870",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'GilroyMedium',
                              fontSize: height / 65),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: height / 20),
                  child: Image.asset(
                    "assets/edit.png",
                    height: height / 40,
                  ),
                ),
                SizedBox(
                  width: width / 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
