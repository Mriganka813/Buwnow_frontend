import 'package:buynow/constants/utils.dart';
import 'package:buynow/screens/search_screen/screens/search_product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:buynow/custtomscreens/custtomexplorecaterories.dart';
import 'package:buynow/custtomscreens/custtomrestorent.dart';
import 'package:buynow/models/near_by_restorent.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:buynow/screens/bottombar/profilesetting.dart';
import 'package:buynow/screens/homeseeall/explorecategories.dart';
import 'package:buynow/screens/homeseeall/nearbyrestorent.dart';
import 'package:buynow/screens/search_screen/screens/search_screen.dart';
import 'package:buynow/services/search_by_city_services.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../homeseeall/recommendedshowall.dart';
import '../widgets/custom_text_field.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ColorNotifier notifier;
  final _searchController = TextEditingController();
  bool _isLoading = false;
  final SearchServices _searchServices = SearchServices();

  List<dynamic> _prodList = [];
  List<NearbyRestorentModel> _nearbyRestaurants = [];

  // category name
  List<String> _catName = [
    'Food',
    'Grocery',
    'Medical',
    'Fashion',
    'Stationary',
    'Electrical',
  ];

  // category images
  List<String> _catImages = [
    'assets/food.png',
    'assets/shopping_bag.png',
    'assets/medicine.png',
    'assets/cloth.png',
    'assets/stationary_product.png',
    'assets/electronic.png',
  ];

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
    getNearByRestaurants();
  }

  // get nearby reataurants
  getNearByRestaurants() async {
    setState(() {
      _isLoading = true;
    });

    // get location provided by user at the beginning
    final location =
        await Provider.of<UserProvider>(context, listen: false).result;
    _nearbyRestaurants = await _searchServices.sendCityName(location, context);
    setState(() {
      _isLoading = false;
    });
  }

  // navigate to category page
  void goToCategories(String category) async {
    Navigator.of(context)
        .pushNamed(RecommendedSeeall.routeName, arguments: category);
  }

  // navigate to profile page
  void goToProfile() async {
    Navigator.pushNamed(context, ProfileSetting.routeName);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getbgcolor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(height: height / 20),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // show results for
                        Row(
                          children: [
                            SizedBox(width: width / 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(SearchScreen.routeName);
                              },
                              child: Text(
                                LanguageEn.showresult,
                                style: TextStyle(
                                  fontFamily: 'GilroyBold',
                                  color: notifier.getblackcolor,
                                  fontSize: height / 50,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // dynamic provided location
                        Row(
                          children: [
                            SizedBox(width: width / 20),
                            Consumer<UserProvider>(
                              builder: (context, value, child) => InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(SearchScreen.routeName);
                                },
                                child: Text(
                                  value.result,
                                  style: TextStyle(
                                    color: notifier.getgrey,
                                    fontSize: height / 60,
                                    fontFamily: 'GilroyMedium',
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const Spacer(),

                    // profile icon
                    GestureDetector(
                      onTap: goToProfile,
                      child: Image.asset("assets/p3.png", height: height / 17),
                    ),
                    SizedBox(width: width / 20),
                  ],
                ),
                SizedBox(height: height / 40),
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.transparent,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // search bar to search products
                              customTextField(
                                wi: width / 1.13,
                                textbgcolor: notifier.getbgfildcolor,
                                controller: _searchController,
                                textcolor: notifier.getblackcolor,
                                name1: LanguageEn.searchfordish,
                                context: context,
                                prodList: _prodList,
                                onSubmit: (value) async {
                                  if (value.isEmpty) {
                                    showSnackBar('Search Something.');
                                    return;
                                  }

                                  Navigator.of(context).pushNamed(
                                      SearchProductListScreen.routeName,
                                      arguments: value);
                                },
                              ),
                              SizedBox(height: height / 40),

                              // 30% off banners
                              Container(
                                color: Colors.transparent,
                                height: height / 5,
                                child: ListView.builder(
                                  itemCount: 1,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         const RestorentDeal(),
                                        //   ),
                                        // );
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(width: width / 18),
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.asset(
                                                  "assets/banner1.png")),
                                          SizedBox(width: width / 20),
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.asset(
                                                  "assets/banner2.png")),
                                          SizedBox(width: width / 20),
                                          // Image.asset("assets/d1.png"),
                                          // SizedBox(width: width / 20),
                                          // Image.asset("assets/s.png"),
                                          // SizedBox(width: width / 20),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SizedBox(height: height / 40),

                              Row(
                                children: [
                                  SizedBox(width: width / 20),
                                  Text(
                                    LanguageEn.explorecategories,
                                    style: TextStyle(
                                        color: notifier.getblackcolor,
                                        fontSize: height / 45,
                                        fontFamily: 'GilroyBold'),
                                  ),
                                  const Spacer(),

                                  // show all category
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        Categories.routeName,
                                        arguments: _catName,
                                      );
                                    },
                                    child: Text(
                                      LanguageEn.showall,
                                      style: TextStyle(
                                          color: notifier.getred,
                                          fontSize: height / 55,
                                          fontFamily: 'GilroyMedium'),
                                    ),
                                  ),
                                  SizedBox(width: width / 18),
                                ],
                              ),
                              SizedBox(height: height / 100),

                              // category list
                              Container(
                                color: Colors.transparent,
                                height: height / 5,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        goToCategories(_catName[index]);
                                      },
                                      child: Row(
                                        children: [
                                          index == 0
                                              ? SizedBox(
                                                  width: width / 20,
                                                )
                                              : SizedBox(
                                                  width: width / 60,
                                                ),
                                          ExploreCategories(_catImages[index],
                                              _catName[index], height / 9),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // SizedBox(height: height / 100),
                              // Row(
                              //   children: [
                              //     SizedBox(width: width / 20),
                              //     Text(
                              //       LanguageEn.popularnearyou,
                              //       style: TextStyle(
                              //           color: notifier.getblackcolor,
                              //           fontSize: height / 45,
                              //           fontFamily: 'GilroyBold'),
                              //     ),
                              //     const Spacer(),
                              //     GestureDetector(
                              //       onTap: () {
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) =>
                              //             const PopularViewMore(),
                              //           ),
                              //         );
                              //       },
                              //       child: Text(
                              //         LanguageEn.viewmore,
                              //         style: TextStyle(
                              //             color: notifier.getred,
                              //             fontSize: height / 55,
                              //             fontFamily: 'GilroyMedium'),
                              //       ),
                              //     ),
                              //     SizedBox(width: width / 18),
                              //   ],
                              // ),
                              // SizedBox(height: height / 80),
                              // Container(
                              //   color: Colors.transparent,
                              //   height: height / 3,
                              //   child: ListView.builder(
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: 1,
                              //     itemBuilder: (context, index) {
                              //       return Row(
                              //         children: [
                              //           SizedBox(width: width / 20),
                              //           CusttomPopularfoodlist(
                              //               "assets/bfood.jpg",
                              //               height / 3,
                              //               width / 1.3,
                              //               height / 5,
                              //               width / 1.3,
                              //               width / 5.7 ,LanguageEn.mayo),
                              //           SizedBox(width: width / 31),
                              //           CusttomPopularfoodlist(
                              //               "assets/cake.jpg",
                              //               height / 3,
                              //               width / 1.3,
                              //               height / 5,
                              //               width / 1.3,
                              //               width / 5.7,LanguageEn.atul),
                              //           SizedBox(width: width / 31),
                              //           CusttomPopularfoodlist(
                              //               "assets/bfood.jpg",
                              //               height / 3,
                              //               width / 1.3,
                              //               height / 5,
                              //               width / 1.3,
                              //               width / 5.7,LanguageEn.burgerking),
                              //           SizedBox(width: width / 31),
                              //           CusttomPopularfoodlist(
                              //               "assets/cake.jpg",
                              //               height / 3,
                              //               width / 1.3,
                              //               height / 5,
                              //               width / 1.3,
                              //               width / 5.7,LanguageEn.monginis),
                              //           SizedBox(width: width / 31),
                              //         ],
                              //       );
                              //     },
                              //   ),
                              // ),
                              // SizedBox(height: height / 80),
                              // Row(
                              //   children: [
                              //     SizedBox(width: width / 20),
                              //     Text(
                              //       LanguageEn.recommended,
                              //       style: TextStyle(
                              //           color: notifier.getblackcolor,
                              //           fontSize: height / 45,
                              //           fontFamily: 'GilroyBold'),
                              //     ),
                              //     const Spacer(),
                              //     GestureDetector(
                              //       onTap: () {
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) =>
                              //                 const RecommendedSeeall(),
                              //           ),
                              //         );
                              //       },
                              //       child: Text(
                              //         LanguageEn.showall,
                              //         style: TextStyle(
                              //             color: notifier.getred,
                              //             fontSize: height / 55,
                              //             fontFamily: 'GilroyMedium'),
                              //       ),
                              //     ),
                              //     SizedBox(width: width / 18),
                              //   ],
                              // ),
                              // SizedBox(height: height / 80),
                              // Container(
                              //   color: Colors.transparent,
                              //   height: height / 2.3,
                              //   child: ListView.builder(
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: 1,
                              //     itemBuilder: (context, index) {
                              //       return Row(
                              //         children: [
                              //           SizedBox(width: width / 20),
                              //             CusttomRecommended("assets/bfood.jpg",LanguageEn.burgerkings,LanguageEn.westernburgerfast),
                              //           SizedBox(width: width / 31),
                              //             CusttomRecommended("assets/cake.jpg",LanguageEn.monginis,LanguageEn.westernburgerfast),
                              //           SizedBox(width: width / 31),
                              //             CusttomRecommended("assets/bfood.jpg",LanguageEn.mayo,LanguageEn.westernburgerfast),
                              //           SizedBox(width: width / 31),
                              //             CusttomRecommended("assets/cake.jpg",LanguageEn.atul,LanguageEn.westernburgerfast),
                              //           SizedBox(width: width / 31),
                              //         ],
                              //       );
                              //     },
                              //   ),
                              // ),
                              // SizedBox(height: height / 55),
                              Row(
                                children: [
                                  SizedBox(width: width / 20),
                                  Text(
                                    LanguageEn.nearbyrestorent,
                                    style: TextStyle(
                                        color: notifier.getblackcolor,
                                        fontSize: height / 45,
                                        fontFamily: 'GilroyBold'),
                                  ),
                                  const Spacer(),

                                  // show all nearby restaurants
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        NearByRestorent.routeName,
                                      );
                                    },
                                    child: Text(
                                      LanguageEn.showall,
                                      style: TextStyle(
                                          color: notifier.getred,
                                          fontSize: height / 55,
                                          fontFamily: 'GilroyMedium'),
                                    ),
                                  ),
                                  SizedBox(width: width / 18),
                                ],
                              ),
                              SizedBox(height: height / 55),

                              // show 20 nearby restaurants
                              _nearbyRestaurants.length == 0
                                  ? Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: height / 20,
                                          ),
                                          Text(
                                            'No Nearby shops found',
                                            style: TextStyle(
                                                color: notifier.getgrey,
                                                fontSize: height / 55,
                                                fontFamily: 'GilroyMedium'),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: _nearbyRestaurants.length,
                                      itemBuilder: (context, index) {
                                        final nr = _nearbyRestaurants[index];

                                        return Column(
                                          children: [
                                            CusttomRestorent(
                                              openTime: nr.openingTime,
                                              closeTime: nr.closingTime,
                                              shopOpen: nr.shopOpen!,
                                              id: nr.sId!,
                                              address: nr.address!.locality! +
                                                  ',' +
                                                  nr.address!.city!,
                                              title: nr.businessName!,
                                              subtitle: nr.businessType!,
                                              image: nr.image ?? '',
                                              discount: nr.discount!,
                                            ),
                                            SizedBox(height: height / 50),
                                          ],
                                        );
                                      }),

                              // CusttomRestorent("assets/foodmenu.png",
                              //     LanguageEn.savorbread, LanguageEn.banhmimilk),
                              // SizedBox(height: height / 50),
                              // CusttomRestorent(
                              //     "assets/burgerking.png",
                              //     LanguageEn.burgerkingg,
                              //     LanguageEn.vietnamese),
                              // SizedBox(height: height / 50),
                              // CusttomRestorent("assets/papajogn.png",
                              //     LanguageEn.papajohn, LanguageEn.banhmimilk),
                              // SizedBox(height: height / 50),
                              // CusttomRestorent("assets/todayfoodmenu.png",
                              //     LanguageEn.cocahouse, LanguageEn.vietnamese),
                              // SizedBox(height: height / 50),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }

  Widget kmtime(w, icon, txt) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const RestorentDeal(),
        //   ),
        // );
      },
      child: Container(
        height: height / 30,
        width: w,
        decoration: const BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: height / 70,
              color: notifier.getred,
            ),
            Text(
              txt,
              style: TextStyle(
                fontSize: height / 70,
                color: notifier.getred,
              ),
            )
          ],
        ),
      ),
    );
  }
}
