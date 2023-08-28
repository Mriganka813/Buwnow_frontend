import 'package:flutter/material.dart';
import 'package:buynow/custtomscreens/custtomexplorecaterories.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget {
  static const routeName = '/categories';

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late ColorNotifier notifire;
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

  // category images
  List<String> _catImages = [
    'assets/food.png',
    'assets/shopping_bag.png',
    'assets/medicine.png',
    'assets/cloth.png',
    'assets/stationary_product.png',
    'assets/electronic.png',
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifier>(context, listen: true);
    final catName = ModalRoute.of(context)!.settings.arguments as List<String>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: notifire.getwhite,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: notifire.getblackcolor,
            size: height / 30,
          ),
        ),
        title: Text(
          LanguageEn.explorecategories,
          style: TextStyle(
              color: notifire.getblackcolor,
              fontSize: height / 45,
              fontFamily: 'GilroyBold'),
        ),
      ),
      backgroundColor: notifire.getwhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              height: height / 1,

              // shops
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                itemCount: catName.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: height / 40),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: notifire.getwhite),
                    ),
                    child: ExploreCategories(
                      _catImages[index],
                      catName[index],
                      height / 10,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
