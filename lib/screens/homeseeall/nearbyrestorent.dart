import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtomrestorent.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/all_nearby_restaurants_services.dart';

class NearByRestorent extends StatefulWidget {
  static const routeName = '/all-nearby-restaurant';

  @override
  State<NearByRestorent> createState() => _NearByRestorentState();
}

class _NearByRestorentState extends State<NearByRestorent> {
  late ColorNotifier notifier;
  final scrollController = ScrollController();
  final RestaurantServices restaurantServices = RestaurantServices();

  List restaurants = [];
  bool isLoadingMore = false;

  int page = 0;

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
    scrollController.addListener(_scrollListener);
    fetchNearByRestaurants();
  }

  Future<void> fetchNearByRestaurants() async {
    restaurants = restaurants +
        await restaurantServices.fetchAllNearbyRestaurantsList(context);
    print("restaurants: $restaurants");
    setState(() {});
  }

  void _scrollListener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page++;
      setState(() {
        isLoadingMore = true;
      });
      await fetchNearByRestaurants();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
        backgroundColor: notifier.getwhite,
        appBar: AppBar(
          backgroundColor: notifier.getwhite,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: notifier.getblackcolor,
              size: height / 30,
            ),
          ),
          title: Text(
            LanguageEn.nearbyrestorent,
            style: TextStyle(
                color: notifier.getblackcolor,
                fontSize: height / 45,
                fontFamily: 'GilroyBold'),
          ),
        ),
        body: restaurants.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount:
                    isLoadingMore ? restaurants.length + 1 : restaurants.length,
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < restaurants.length) {
                    return Column(
                      children: [
                        CusttomRestorent(
                            id: restaurants[index]['_id'],
                            address: restaurants[index]['address']['locality'] +
                                ',' +
                                restaurants[index]['address']['city'],
                            title: restaurants[index]['businessName'],
                            subtitle: restaurants[index]['businessType']),
                        SizedBox(
                          height: height / 50,
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }));
  }
}
// CusttomRestorent(
//                         "assets/foodmenu.png",
//                         restaurants[index]['businessName'],
//                         restaurants[index]['businessType']);

// SingleChildScrollView(
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// children: [
// SizedBox(height: height/50),
// CusttomRestorent("assets/foodmenu.png",
// LanguageEn.savorbread, LanguageEn.banhmimilk),
// SizedBox(height: height / 50),
// CusttomRestorent("assets/burgerking.png",
// LanguageEn.burgerkingg, LanguageEn.vietnamese),
// SizedBox(height: height / 50),
// CusttomRestorent("assets/papajogn.png",
// LanguageEn.papajohn, LanguageEn.banhmimilk),
// SizedBox(height: height / 50),
// CusttomRestorent("assets/todayfoodmenu.png",
// LanguageEn.cocahouse, LanguageEn.vietnamese),
// SizedBox(height: height / 50),
// CusttomRestorent("assets/foodmenu.png",
// LanguageEn.savorbread, LanguageEn.banhmimilk),
// SizedBox(height: height / 50),
// CusttomRestorent("assets/burgerking.png",
// LanguageEn.burgerkingg, LanguageEn.vietnamese),
// SizedBox(height: height / 50),
// CusttomRestorent("assets/papajogn.png",
// LanguageEn.papajohn, LanguageEn.banhmimilk),
// SizedBox(height: height / 50),
// CusttomRestorent("assets/todayfoodmenu.png",
// LanguageEn.cocahouse, LanguageEn.vietnamese),
// SizedBox(height: height / 50),
// ],
// ),
// ),
// ),
