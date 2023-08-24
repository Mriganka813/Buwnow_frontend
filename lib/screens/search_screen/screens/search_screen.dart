import 'package:buynow/services/push_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:buynow/constants/utils.dart';
import 'package:buynow/custtomscreens/textfild.dart';
import 'package:buynow/screens/bottombar/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../custtomscreens/custtombutton.dart';
import '../../../providers/user_provider.dart';
import '../../../services/search_by_city_services.dart';
import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ColorNotifier notifier;
  final searchController = TextEditingController();
  bool isLoading = false;
  final SearchServices searchServices = SearchServices();
  List<dynamic> list = [];

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  // handle push notification
  void messageHandler() async {
    // for foreground message
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('started');
      print(message);
      if (message != null) {
        print('new notification');
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      print('onmessage listen');
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);

        PushNotifications.createanddisplaynotification(message);
      }
    });

    // when user tap on notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('onMessageOpenedApp');
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print('${message.data['_id']}');
        // Navigator.of(context).pushNamed(SearchScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();

    messageHandler();
  }

  void submit() async {
    final searchText = searchController.text.trim();
    if (searchText.isEmpty) {
      showSnackBar('Please enter city or country.');
      return;
    }
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    //
    Provider.of<UserProvider>(context, listen: false).setKeyword(searchText);
    await searchServices.sendCityName(searchText, context);

    //
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => BottomHome(),
    ))
        .then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getwhite,
      appBar: AppBar(
        title: Text(
          'Select location',
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        backgroundColor: notifier.getwhite,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Customsearchtextfild.textField(
                'Search by city, state or country',
                notifier.getblackcolor,
                width / 1.13,
                notifier.getwhite,
                searchController,
              ),
              SizedBox(
                height: height / 20,
              ),
              Image.asset(
                'assets/search_img.jpg',
                height: height / 2,
                width: width / 1.1,
              ),
              SizedBox(
                height: height / 15,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: InkWell(
                onTap: () {
                  submit();
                },
                child: button(
                    Colors.green, notifier.getwhite, 'Search', width / 1.13),
              ),
            ),
    );
  }
}
