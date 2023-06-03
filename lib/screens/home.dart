import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtomexplorecaterories.dart';
import 'package:gofoods/custtomscreens/custtompopularfoodlist.dart';
import 'package:gofoods/custtomscreens/custtomrecommended.dart';
import 'package:gofoods/custtomscreens/custtomrestorent.dart';
import 'package:gofoods/custtomscreens/textfild.dart';
import 'package:gofoods/providers/user_provider.dart';
import 'package:gofoods/screens/bottombar/profilesetting.dart';
import 'package:gofoods/screens/homeseeall/explorecategories.dart';
import 'package:gofoods/screens/homeseeall/nearbyrestorent.dart';
import 'package:gofoods/screens/homeseeall/popularviewmore.dart';
import 'package:gofoods/screens/homeseeall/recommendedshowall.dart';
import 'package:gofoods/screens/restorentdeal.dart';
import 'package:gofoods/screens/search_screen/search_screen.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ColorNotifier notifier;
  final searchController = TextEditingController();

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
    return Scaffold(
      backgroundColor: notifier.getbgcolor,
      body: Column(
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
                      Text(
                        LanguageEn.showresult,
                        style: TextStyle(
                          fontFamily: 'GilroyBold',
                          color: notifier.getblackcolor,
                          fontSize: height / 50,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: width / 10),
                      // Icon(Icons.location_on_outlined,
                      //     color: notifier.getgrey, size: height / 40),
                      Consumer<UserProvider>(
                        builder: (context, value, child) => InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(SearchScreen.routeName);
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileSetting(),
                    ),
                  );
                },
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
                        Customsearchtextfild.textField(
                          LanguageEn.searchfordish,
                          notifier.getblackcolor,
                          width / 1.13,notifier.getbgfildcolor,
                          searchController
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RestorentDeal(),
                                    ),
                                  );
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
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Categories(),
                                ),
                              ),
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
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  SizedBox(width: width / 20),
                                  ExploreCategories("assets/f1.png",
                                      LanguageEn.milkshake, height / 9),
                                  SizedBox(width: width / 60),
                                  ExploreCategories("assets/f2.png",
                                      LanguageEn.omelette, height / 9),
                                  SizedBox(width: width / 60),
                                  ExploreCategories("assets/f3.png",
                                      LanguageEn.tomatosup, height / 9),
                                  SizedBox(width: width / 60),
                                  ExploreCategories("assets/pizza.png",
                                      LanguageEn.shake, height / 9),
                                  SizedBox(width: width / 60),
                                ],
                              );
                            },
                          ),
                        ),
                        // SizedBox(height: height / 100),
                        Row(
                          children: [
                            SizedBox(width: width / 20),
                            Text(
                              LanguageEn.popularnearyou,
                              style: TextStyle(
                                  color: notifier.getblackcolor,
                                  fontSize: height / 45,
                                  fontFamily: 'GilroyBold'),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const PopularViewMore(),
                                  ),
                                );
                              },
                              child: Text(
                                LanguageEn.viewmore,
                                style: TextStyle(
                                    color: notifier.getred,
                                    fontSize: height / 55,
                                    fontFamily: 'GilroyMedium'),
                              ),
                            ),
                            SizedBox(width: width / 18),
                          ],
                        ),
                        SizedBox(height: height / 80),
                        Container(
                          color: Colors.transparent,
                          height: height / 3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  SizedBox(width: width / 20),
                                  CusttomPopularfoodlist(
                                      "assets/bfood.jpg",
                                      height / 3,
                                      width / 1.3,
                                      height / 5,
                                      width / 1.3,
                                      width / 5.7 ,LanguageEn.mayo),
                                  SizedBox(width: width / 31),
                                  CusttomPopularfoodlist(
                                      "assets/cake.jpg",
                                      height / 3,
                                      width / 1.3,
                                      height / 5,
                                      width / 1.3,
                                      width / 5.7,LanguageEn.atul),
                                  SizedBox(width: width / 31),
                                  CusttomPopularfoodlist(
                                      "assets/bfood.jpg",
                                      height / 3,
                                      width / 1.3,
                                      height / 5,
                                      width / 1.3,
                                      width / 5.7,LanguageEn.burgerking),
                                  SizedBox(width: width / 31),
                                  CusttomPopularfoodlist(
                                      "assets/cake.jpg",
                                      height / 3,
                                      width / 1.3,
                                      height / 5,
                                      width / 1.3,
                                      width / 5.7,LanguageEn.monginis),
                                  SizedBox(width: width / 31),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height / 80),
                        Row(
                          children: [
                            SizedBox(width: width / 20),
                            Text(
                              LanguageEn.recommended,
                              style: TextStyle(
                                  color: notifier.getblackcolor,
                                  fontSize: height / 45,
                                  fontFamily: 'GilroyBold'),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RecommendedSeeall(),
                                  ),
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
                        SizedBox(height: height / 80),
                        Container(
                          color: Colors.transparent,
                          height: height / 2.3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  SizedBox(width: width / 20),
                                    CusttomRecommended("assets/bfood.jpg",LanguageEn.burgerkings,LanguageEn.westernburgerfast),
                                  SizedBox(width: width / 31),
                                    CusttomRecommended("assets/cake.jpg",LanguageEn.monginis,LanguageEn.westernburgerfast),
                                  SizedBox(width: width / 31),
                                    CusttomRecommended("assets/bfood.jpg",LanguageEn.mayo,LanguageEn.westernburgerfast),
                                  SizedBox(width: width / 31),
                                    CusttomRecommended("assets/cake.jpg",LanguageEn.atul,LanguageEn.westernburgerfast),
                                  SizedBox(width: width / 31),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height / 55),
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
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NearByRestorent(),
                                ),
                              ),
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
                        CusttomRestorent("assets/foodmenu.png",
                            LanguageEn.savorbread, LanguageEn.banhmimilk),
                        SizedBox(height: height / 50),
                        CusttomRestorent("assets/burgerking.png",
                            LanguageEn.burgerkingg, LanguageEn.vietnamese),
                        SizedBox(height: height / 50),
                        CusttomRestorent("assets/papajogn.png",
                            LanguageEn.papajohn, LanguageEn.banhmimilk),
                        SizedBox(height: height / 50),
                        CusttomRestorent("assets/todayfoodmenu.png",
                            LanguageEn.cocahouse, LanguageEn.vietnamese),
                        SizedBox(height: height / 50),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RestorentDeal(),
          ),
        );
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
