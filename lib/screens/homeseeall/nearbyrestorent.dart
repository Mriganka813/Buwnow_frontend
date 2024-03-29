import 'package:buynow/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:buynow/custtomscreens/custtomrestorent.dart';
import 'package:buynow/models/near_by_restorent.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
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

  List<NearbyRestorentModel> restaurants = [];
  bool isLoadingMore = false;

  int page = 1;

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

  // fetch all nearby restaurants
  Future<void> fetchNearByRestaurants() async {
    restaurants = restaurants +
        await restaurantServices.fetchAllNearbyRestaurantsList(context, page);
    if (restaurants.length == 0) {
      showSnackBar('No shops found');
    }
    print("restaurants: $restaurants");
    setState(() {});
  }

  // this is for pagination
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
                    final rt = restaurants[index];
                    return Column(
                      children: [
                        CusttomRestorent(
                          openTime: rt.openingTime,
                          closeTime: rt.closingTime,
                          shopOpen: rt.shopOpen!,
                          id: rt.sId!,
                          address:
                              rt.address!.locality! + ',' + rt.address!.city!,
                          title: rt.businessName!,
                          subtitle: rt.businessType!,
                          image: rt.image ?? '',
                          discount: rt.discount!,
                        ),
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
