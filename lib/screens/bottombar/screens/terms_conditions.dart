import 'package:buynow/utils/notifirecolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/enstring.dart';
import '../../../utils/mediaqury.dart';

class TermsConditionScreen extends StatefulWidget {
  static const routeName = '/terms-conditions';
  const TermsConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
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
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    final headingStyle = TextStyle(
        color: notifier.getblackcolor,
        fontFamily: 'GilroyMedium',
        fontSize: height / 50);

    final style = TextStyle(
        color: notifier.getgrey,
        fontFamily: 'GilroyMedium',
        fontSize: height / 60);

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
          LanguageEn.teamsandcontiotion,
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 80,
              ),
              Text(
                ' 1. Introduction',
                style: headingStyle,
              ),
              Text(
                '- These Terms & Conditions ("T&C") govern the use of the BuyNow app ("the App"), a hyperlocal delivery application developed and managed by Magicstep Solutions Private Limited ("Magicstep", "we", "our", or "us").',
                style: style,
              ),
              SizedBox(
                height: height / 60,
              ),
              Text(
                '2. Content & Products',
                style: headingStyle,
              ),
              Text(
                '- All content, including product listings, descriptions, and images, are provided solely by the sellers registered on the App. Magicstep does not verify, endorse, or take responsibility for the accuracy, completeness, or quality of the content provided by the sellers.',
                style: style,
              ),
              SizedBox(
                height: height / 60,
              ),
              Text(
                ' 3. Seller\'s Responsibility',
                style: headingStyle,
              ),
              Text(
                '- Sellers are solely responsible for the quality, safety, and legality of the products they list and sell through the App.',
                style: style,
              ),
              SizedBox(
                height: height / 80,
              ),
              Text(
                '- Sellers must ensure that their products comply with all local, state, and national regulations and laws.',
                style: style,
              ),
              SizedBox(
                height: height / 80,
              ),
              Text(
                '- Sellers are required to provide accurate and truthful information about their products.',
                style: style,
              ),
              SizedBox(
                height: height / 60,
              ),
              Text(
                '4. User Complaints & Interventions',
                style: headingStyle,
              ),
              Text(
                ' - If a user lodges a serious complaint against a seller, Magicstep reserves the right to investigate the matter.',
                style: style,
              ),
              SizedBox(
                height: height / 80,
              ),
              Text(
                '- Based on the findings of the investigation, Magicstep may take appropriate actions, including but not limited to, issuing warnings to the seller, suspending the seller\'s account, or delisting the seller from the App.',
                style: style,
              ),
              SizedBox(
                height: height / 60,
              ),
              Text(
                ' 5. Limitation of Liability',
                style: headingStyle,
              ),
              Text(
                ' - While Magicstep strives to offer a seamless user experience, we shall not be held liable for any damages, losses, or inconveniences arising from the use of the App or from transactions between users and sellers.',
                style: style,
              ),
              SizedBox(
                height: height / 80,
              ),
              Text(
                '- Users are advised to exercise caution and conduct their own due diligence before making any purchase through the App.',
                style: style,
              ),
              SizedBox(
                height: height / 60,
              ),
              Text(
                '6. Legal Jurisdiction',
                style: headingStyle,
              ),
              Text(
                '- Any disputes arising out of or in connection with the use of the App shall be subject to the exclusive jurisdiction of the Court of North Lakhimpur, Assam.',
                style: style,
              ),
              SizedBox(
                height: height / 60,
              ),
              Text(
                '  7. Amendments to T&C',
                style: headingStyle,
              ),
              Text(
                '- Magicstep reserves the right to modify, amend, or replace these T&C at any time. Users are advised to regularly check this page for any updates. Continued use of the App following any changes to the T&C constitutes acceptance of those changes.',
                style: style,
              ),
              SizedBox(
                height: height / 60,
              ),
              Text(
                '8. Contact',
                style: headingStyle,
              ),
              Text(
                ' - For any queries, concerns, or feedback regarding these T&C or the App, users can reach out to Magicstep Solutions Private Limited through the contact details provided in the App.',
                style: style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
