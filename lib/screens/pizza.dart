import 'package:flutter/material.dart';
import 'package:buynow/custtomscreens/custtombutton.dart';
import 'package:buynow/custtomscreens/custtomfooditeam.dart';
import 'package:buynow/custtomscreens/custtomgriadeiteam.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pizza extends StatefulWidget {
  const Pizza({Key? key}) : super(key: key);

  @override
  State<Pizza> createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
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

  int selectedindex = -1;
  String dropdownvalue = 'Best match';
  String filterbydropdownvalue = 'Open';
  double _currentSliderValue = 20;
  bool hide = false;
  var items = [
    'Best match',
    'Low match',
    'High match',
  ];
  var filterbyitems = [
    'Open',
    'Close',
  ];
  List locationlist = [
    "Bronx",
    "Brooklyn",
    "Samara river city",
    "Manhattan",
    "Staten island",
    "near me",
  ];
  bool like = false;
  bool count = false;
  bool counttwo = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            SizedBox(height: height / 70),
            Row(
              children: [
                SizedBox(width: width / 20),
                Container(
                  height: height / 20,
                  width: width / 3.4,
                  decoration: BoxDecoration(
                    color: notifier.getbgfildcolor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: DropdownButton(
                    dropdownColor: notifier.getbgfildcolor,
                    underline: const SizedBox(),
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: EdgeInsets.only(left: width / 50),
                          child: Text(
                            items,
                            style: TextStyle(
                                color: notifier.getblackcolor,
                                fontSize: height / 60),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      hide = !hide;
                    });
                  },
                  child: Container(
                    height: height / 20,
                    width: width / 10,
                    decoration: BoxDecoration(
                      color: notifier.getbgfildcolor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(11),
                      ),
                    ),
                    child: hide == true
                        ? Icon(
                            Icons.widgets_outlined,
                            color: notifier.getblackcolor,
                            size: height / 35,
                          )
                        : Icon(
                            Icons.list,
                            color: notifier.getblackcolor,
                            size: height / 35,
                          ),
                  ),
                ),
                SizedBox(width: width / 40),
                GestureDetector(
                  onTap: () {
                    filtershowmodelbottomsheet();
                  },
                  child: Container(
                    height: height / 20,
                    width: width / 10,
                    decoration: BoxDecoration(
                      color: notifier.getbgfildcolor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(11),
                      ),
                    ),
                    child: Icon(
                      Icons.filter_list_sharp,
                      color: notifier.getblackcolor,
                      size: height / 35,
                    ),
                  ),
                ),
                SizedBox(width: width / 20),
              ],
            ),
            SizedBox(height: height / 50),
            if (hide == true)
              Container(
                  color: Colors.transparent,
                  child: Container(
                    color: Colors.transparent,
                    height: height,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width / 20),
                            CusttomGriadeFoodIteam(
                                "assets/pizzachicago.jpg", LanguageEn.cheesy),
                            SizedBox(width: width / 20),
                            CusttomGriadeFoodIteam("assets/pizzachicago.jpg",
                                LanguageEn.sevenchess),
                            SizedBox(width: width / 20),
                          ],
                        ),
                        SizedBox(height: height / 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width / 20),
                            CusttomGriadeFoodIteam(
                                "assets/pizzachicago.jpg", LanguageEn.calzne),
                            SizedBox(width: width / 20),
                            CusttomGriadeFoodIteam("assets/pizzachicago.jpg",
                                LanguageEn.margarita),
                            SizedBox(width: width / 20),
                          ],
                        ),
                        SizedBox(height: height / 3),
                      ],
                    ),
                  ))
            else
              Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SizedBox(height: height / 50),
                    CusttomFoodIteam(
                        "assets/pizzachicago.jpg", LanguageEn.cheesy),
                    SizedBox(height: height / 100),
                    CusttomFoodIteam("assets/Salad.png", LanguageEn.margarita),
                    SizedBox(height: height / 100),
                    CusttomFoodIteam(
                        "assets/pizzachicago.jpg", LanguageEn.sevenchess),
                    SizedBox(height: height / 100),
                    CusttomFoodIteam("assets/Salad.png", LanguageEn.calzne),
                    SizedBox(height: height / 5),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget sortBy() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: height / 15,
              mainAxisExtent: height / 7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 7),
          itemCount: locationlist.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedindex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedindex == index
                      ? notifier.getred
                      : Colors.transparent,
                  border: Border.all(color: notifier.getgrey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    locationlist[index],
                    style: TextStyle(
                        fontFamily: 'GilroyMedium',
                        color: selectedindex == index
                            ? notifier.getwhite
                            : notifier.getblackcolor,
                        fontWeight: FontWeight.normal,
                        fontSize: height / 60),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future filtershowmodelbottomsheet() {
    return showModalBottomSheet(
      backgroundColor: notifier.getwhite,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Column(
                  children: [
                    SizedBox(height: height / 30),
                    Row(
                      children: [
                        SizedBox(width: width / 12),
                        Text(
                          LanguageEn.location,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontFamily: 'GilroyBold',
                              fontSize: height / 35),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        SizedBox(width: width / 17),
                        SizedBox(
                          height: height / 8,
                          width: width / 1.1,
                          child: sortBy(),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 35),
                    Row(
                      children: [
                        SizedBox(width: width / 12),
                        Text(
                          LanguageEn.filterby,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontFamily: 'GilroyBold',
                              fontSize: height / 35),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 70,
                    ),
                    Container(
                      height: height / 15,
                      width: width / 1.22,
                      decoration: BoxDecoration(
                        color: notifier.getbgfildcolor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: DropdownButton(
                        dropdownColor: notifier.getbgfildcolor,
                        underline: const SizedBox(),
                        value: filterbydropdownvalue,
                        icon: Row(
                          children: [
                            SizedBox(width: width / 1.7),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                        items: filterbyitems.map((String filterbyitems) {
                          return DropdownMenuItem(
                            value: filterbyitems,
                            child: Padding(
                              padding: EdgeInsets.only(left: width / 40),
                              child: Text(
                                filterbyitems,
                                style: TextStyle(
                                    color: notifier.getblackcolor,
                                    fontSize: height / 50),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            filterbydropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: height / 35),
                    Row(
                      children: [
                        SizedBox(width: width / 12),
                        Text(
                          LanguageEn.price,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontFamily: 'GilroyBold',
                              fontSize: height / 35),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Slider(
                        activeColor: notifier.getred,
                        inactiveColor: const Color(0xff9ceabd),
                        value: _currentSliderValue,
                        max: 100,
                        divisions: 5,
                        label: _currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: button(notifier.getred, notifier.getwhite,
                          LanguageEn.apply, width / 1.2),
                    ),
                    SizedBox(height: height / 30)
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
