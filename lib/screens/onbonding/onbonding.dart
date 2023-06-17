// import 'package:flutter/material.dart';
// import 'package:gofoods/screens/authscreen/selectlogintype.dart';
// import 'package:gofoods/screens/onbonding/model.dart';
// import 'package:gofoods/utils/enstring.dart';
// import 'package:gofoods/utils/mediaqury.dart';
// import 'package:gofoods/utils/notifirecolor.dart';
// import 'package:provider/provider.dart';
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   List<SliderModel> mySLides = <SliderModel>[];
//   int slideIndex = 0;
//   PageController? controller;
// late ColorNotifier notifier;
//   Widget _buildPageIndicator(bool isCurrentPage) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 2.0),
//       height: isCurrentPage ? 10.0 : 6.0,
//       width: isCurrentPage ? 10.0 : 6.0,
//       decoration: BoxDecoration(
//         color: isCurrentPage ? Colors.grey : Colors.grey[300],
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     mySLides = getSlides();
//     controller = PageController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     notifier = Provider.of<ColorNotifier>(context, listen: true);
//     return Container(
//       decoration: const BoxDecoration(
//           gradient:
//               LinearGradient(colors: [Color(0xff3C8CE7), Color(0xff00EAFF)])),
//       child: Scaffold(
//         // backgroundColor: Colors.white,
//         body: Container(
//           color: Colors.transparent,
//           height: MediaQuery.of(context).size.height - 100,
//           child: PageView(
//             controller: controller,
//             onPageChanged: (index) {
//               setState(() {
//                 slideIndex = index;
//               });
//             },
//             children: <Widget>[
//               SlideTile(
//                 imagePath: mySLides[0].getImageAssetPath(),
//                 title: mySLides[0].getTitle(),
//                 desc: mySLides[0].getDesc(),
//               ),
//               SlideTile(
//                 imagePath: mySLides[1].getImageAssetPath(),
//                 title: mySLides[1].getTitle(),
//                 desc: mySLides[1].getDesc(),
//               ),
//               SlideTile(
//                 imagePath: mySLides[2].getImageAssetPath(),
//                 title: mySLides[2].getTitle(),
//                 desc: mySLides[2].getDesc(),
//               )
//             ],
//           ),
//         ),
//         bottomSheet: slideIndex != 2
//             ? Container(
//                 margin: const EdgeInsets.symmetric(vertical: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     // FlatButton(
//                     //   onPressed: (){
//                     //     controller!.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
//                     //   },
//                     //   splashColor: Colors.blue[50],
//                     //   child: Text(
//                     //     "SKIP",
//                     //     style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
//                     //   ),
//                     // ),
//                     SizedBox(width: width / 700),
//                     Container(
//                       color: Colors.transparent,
//                       child: Row(
//                         children: [
//                           for (int i = 0; i < 3; i++)
//                             i == slideIndex
//                                 ? _buildPageIndicator(true)
//                                 : _buildPageIndicator(false),
//                         ],
//                       ),
//                     ),
//                     FlatButton(
//                       onPressed: () {
//                         controller!.animateToPage(slideIndex + 1,
//                             duration: const Duration(milliseconds: 500),
//                             curve: Curves.linear);
//                       },
//                       splashColor: Colors.blue[50],
//                       child: Container(
//                         height: height / 15,
//                         width: width / 3,
//                         decoration:   BoxDecoration(
//                           color: notifier.getred,
//                           borderRadius: const BorderRadius.all(Radius.circular(12)),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "Next",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const SelectLogin(),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: height / 15,
//                         width: width / 1.1,
//                         decoration:   BoxDecoration(
//                           color: notifier.getred,
//                           borderRadius: const BorderRadius.all(Radius.circular(12)),
//                         ),
//                         child:   Center(
//                           child: Text(
//                            LanguageEn.getstarted,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
//
// class SlideTile extends StatelessWidget {
//   String imagePath, title, desc;
//
//   SlideTile(
//       {Key? key,
//       required this.imagePath,
//       required this.title,
//       required this.desc})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Image.asset(imagePath, height: 450, width: 500),
//           const SizedBox(
//             height: 40,
//           ),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(desc,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofoods/screens/authscreen/phonenumber.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onbonding extends StatefulWidget {
  const Onbonding({Key? key}) : super(key: key);

  @override
  _OnbondingState createState() => _OnbondingState();
}

class _OnbondingState extends State<Onbonding> {
  final int _numPages = 3;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  late ColorNotifier notifire;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  late bool isLoading;

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 8.0,
      width: isActive ? 8.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: const Color(0xff2792f5),
                    height: height,
                    child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/onimage.png"),
                                      fit: BoxFit.cover),
                                  color: Colors.transparent,
                                  // borderRadius: BorderRadius.only(
                                  //   topRight: Radius.circular(50),
                                  //   topLeft: Radius.circular(50),
                                  // ),
                                ),
                                height: height,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: height / 1.4),
                                      Text(
                                        LanguageEn.orderfood,
                                        style: TextStyle(
                                            fontFamily: 'GilroyBold',
                                            color: notifire.getwhite,
                                            fontSize: height / 32),
                                      ),
                                      SizedBox(height: height / 40),
                                      // Text(
                                      //   LanguageEn
                                      //       .shake,
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //       fontFamily: 'Gilroy_Medium',
                                      //       color: notifire.getwhite,
                                      //       fontSize: 14),
                                      // ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/onbondingtwo.png"),
                                      fit: BoxFit.fill),
                                  // color: const Color(0xff2792f5),
                                  // borderRadius: BorderRadius.only(
                                  //   topRight: Radius.circular(50),
                                  //   topLeft: Radius.circular(50),
                                  // ),
                                ),
                                height: height,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: height / 1.4),
                                      Text(
                                        LanguageEn.finddeals,
                                        style: TextStyle(
                                            fontFamily: 'GilroyBold',
                                            color: notifire.getwhite,
                                            fontSize: height / 32),
                                      ),
                                      // SizedBox(height: height / 40),
                                      // Text(
                                      //   LanguageEn
                                      //       .burgerking,
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //       fontFamily: 'Gilroy_Medium',
                                      //       color: notifire.getwhite,
                                      //       fontSize: 14),
                                      // ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/onbondingthree.png"),
                                      fit: BoxFit.fill),
                                  // color: const Color(0xff2792f5),
                                  // borderRadius: BorderRadius.only(
                                  //   topRight: Radius.circular(50),
                                  //   topLeft: Radius.circular(50),
                                  // ),
                                ),
                                height: height,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: height / 1.4),
                                      Text(
                                        LanguageEn.showthemyoucare,
                                        style: TextStyle(
                                            fontFamily: 'GilroyBold',
                                            color: notifire.getwhite,
                                            fontSize: height / 32),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _currentPage != _numPages - 1
                ? Column(
                    children: [
                      SizedBox(height: height / 1.12),
                      Container(
                        color: Colors.transparent,
                        height: height / 11,
                        child: Align(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            PhoneNumber.routeName,
                                            (route) => false);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    height: height / 20,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Center(
                                        child: Text(
                                          'Skip',
                                          style: TextStyle(
                                              fontFamily: 'GilroyMedium',
                                              color: notifire.getwhite,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _buildPageIndicator(),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _pageController.nextPage(
                                        duration:
                                            const Duration(microseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  child: Container(
                                      height: height / 16,
                                      width: width / 7,
                                      decoration: BoxDecoration(
                                          color: notifire.getwhite,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_forward,
                                          size: height / 30,
                                          color: notifire.getred,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(height: height / 1.12),
                      Container(
                        color: Colors.transparent,
                        height: height / 11,
                        child: Align(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            PhoneNumber.routeName,
                                            (route) => false);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    height: height / 20,
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Center(
                                        child: Text(
                                          'Skip',
                                          style: TextStyle(
                                              fontFamily: 'GilroyMedium',
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _buildPageIndicator(),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            PhoneNumber.routeName,
                                            (route) => false);
                                  },
                                  child: Container(
                                      height: height / 16,
                                      width: width / 7,
                                      decoration: BoxDecoration(
                                        color: notifire.getwhite,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.done,
                                          size: height / 30,
                                          color: notifire.getred,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
