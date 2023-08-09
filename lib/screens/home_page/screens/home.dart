import 'package:flutter/material.dart';
import 'package:buynow/custtomscreens/custtomexplorecaterories.dart';
import 'package:buynow/custtomscreens/custtomrestorent.dart';
import 'package:buynow/models/near_by_restorent.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:buynow/screens/bottombar/profilesetting.dart';
import 'package:buynow/screens/homeseeall/explorecategories.dart';
import 'package:buynow/screens/homeseeall/nearbyrestorent.dart';
import 'package:buynow/screens/search_screen/screens/search_screen.dart';
import 'package:buynow/services/all_nearby_restaurants_services.dart';
import 'package:buynow/services/search_by_city_services.dart';
import 'package:buynow/services/user_services.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/category_products_services.dart';
import '../../../services/search_product_services.dart';
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
  final searchController = TextEditingController();
  bool isLoading = false;
  final UserServices userServices = UserServices();
  final SearchServices searchServices = SearchServices();
  final RestaurantServices restaurantServices = RestaurantServices();
  final SearchProductServices searchProductServices = SearchProductServices();
  final CategoryProductServices categoryProductServices =
      CategoryProductServices();

  List<dynamic> prodList = [];
  List<NearbyRestorentModel> nearbyRestaurants = [];

  List<String> catName = [
    'Food',
    'Grocery',
    'Medical',
    'Fashion',
    'Stationary',
    'Electrical',
  ];
  List<String> catImages = [
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

  getNearByRestaurants() async {
    setState(() {
      isLoading = true;
    });
    final location =
        await Provider.of<UserProvider>(context, listen: false).result;
    nearbyRestaurants = await searchServices.sendCityName(location, context);
    setState(() {
      isLoading = false;
    });
  }

  void goToCategories(String category) async {
    Navigator.of(context)
        .pushNamed(RecommendedSeeall.routeName, arguments: category);
  }

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
      body: isLoading
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
                              customTextField(
                                wi: width / 1.13,
                                textbgcolor: notifier.getbgfildcolor,
                                controller: searchController,
                                textcolor: notifier.getblackcolor,
                                name1: LanguageEn.searchfordish,
                                context: context,
                                prodList: prodList,
                              ),
                              SizedBox(height: height / 40),
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
                                          Image.asset("assets/d.png"),
                                          SizedBox(width: width / 20),
                                          Image.asset("assets/e.png"),
                                          SizedBox(width: width / 20),
                                          Image.asset("assets/d1.png"),
                                          SizedBox(width: width / 20),
                                          Image.asset("assets/s.png"),
                                          SizedBox(width: width / 20),
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        Categories.routeName,
                                        arguments: catName,
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
                              Container(
                                color: Colors.transparent,
                                height: height / 5,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        goToCategories(catName[index]);
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
                                          ExploreCategories(catImages[index],
                                              catName[index], height / 9),
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

                              nearbyRestaurants.length == 0
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
                                      itemCount: nearbyRestaurants.length,
                                      itemBuilder: (context, index) => Column(
                                        children: [
                                          CusttomRestorent(
                                            id: nearbyRestaurants[index].sId!,
                                            address: nearbyRestaurants[index]
                                                    .address!
                                                    .locality! +
                                                ',' +
                                                nearbyRestaurants[index]
                                                    .address!
                                                    .city!,
                                            title: nearbyRestaurants[index]
                                                .businessName!,
                                            subtitle: nearbyRestaurants[index]
                                                .businessType!,
                                            image: nearbyRestaurants[index]
                                                    .image ??
                                                '',
                                            discount: nearbyRestaurants[index]
                                                .discount!,
                                          ),
                                          SizedBox(height: height / 50),
                                        ],
                                      ),
                                    ),

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
