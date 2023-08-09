// import 'package:buynow/models/product.dart';
// import 'package:buynow/screens/specific_shop/screens/show_all_products.dart';
// import 'package:flutter/material.dart';
// import 'package:buynow/providers/user_provider.dart';
// import 'package:buynow/screens/delivrystatustabbar/delivery.dart';
// import 'package:buynow/screens/search_screen/screens/search_products_details_screen.dart';
// import 'package:buynow/screens/search_screen/widgets/food_item.dart';
// import 'package:buynow/services/specific_shop_details.dart';
// import 'package:buynow/utils/enstring.dart';
// import 'package:buynow/utils/mediaqury.dart';
// import 'package:buynow/utils/notifirecolor.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RestorentDeal extends StatefulWidget {
//   static const routeName = '/restaurant-deal';
//   const RestorentDeal({Key? key}) : super(key: key);

//   @override
//   State<RestorentDeal> createState() => _RestorentDealState();
// }

// class _RestorentDealState extends State<RestorentDeal>
//     with TickerProviderStateMixin {
//   late ColorNotifier notifier;
//   TabController? controller;

//   bool isLoading = false;
//   List<Product> products = [];
//   Map<String, dynamic> args = {};
//   String shopId = '';

//   int page = 1;

//   final SpecificShopDetails shopDetails = SpecificShopDetails();

//   getdarkmodepreviousstate() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? previusstate = prefs.getBool("setIsDark");
//     if (previusstate == null) {
//       notifier.setIsDark = false;
//     } else {
//       notifier.setIsDark = previusstate;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getdarkmodepreviousstate();
//     getShopDetails();
//     controller =
//         TabController(length: 1, vsync: this, animationDuration: Duration.zero);
//   }

//   getShopDetails() {
//     setState(() {
//       isLoading = true;
//     });
//     Future.delayed(Duration.zero, () async {
//       args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//       shopId = args['id'];
//       products = await shopDetails.getShopProducts(context, shopId, page);
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     notifier = Provider.of<ColorNotifier>(context);

//     final shopName = args['name'];
//     final shopCategory = args['category'];
//     final String address = args['address'] ?? '';

//     return Scaffold(
//       backgroundColor: notifier.getwhite,
//       floatingActionButton: SizedBox(
//         height: height / 15,
//         width: width / 1.1,
//         // child: Container(color: notifier.getred),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       body: isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : SafeArea(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: height / 2,
//                       width: width,
//                       child: Stack(children: [
//                         Image.asset(
//                           'assets/bfood.jpg',
//                           height: height / 3,
//                           fit: BoxFit.cover,
//                         ),
//                         Positioned(
//                           top: height / 10,
//                           left: width / 30,
//                           right: width / 30,
//                           child: restorentstatuscard(
//                             width / 1.1,
//                             height / 2.8,
//                             Container(
//                               width: width / 1.1,
//                               height: height / 2.8,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   TabBar(
//                                     padding: EdgeInsets.all(5),
//                                     labelStyle: TextStyle(
//                                       fontSize: height / 45,
//                                       fontFamily: 'GilroyBold',
//                                     ),
//                                     labelColor: notifier.getred,
//                                     controller: controller,
//                                     indicatorColor: notifier.getred,
//                                     tabs: [
//                                       Tab(
//                                         text: LanguageEn.products,
//                                       ),
//                                       // Tab(text: LanguageEn.menu),
//                                       // Tab(text: LanguageEn.review),
//                                     ],
//                                   ),
//                                   Expanded(
//                                     child: TabBarView(
//                                       controller: controller,
//                                       children: [
//                                         Delivery(
//                                           shopName: shopName,
//                                           shopCategory: shopCategory,
//                                           shopAddress: address.isEmpty
//                                               ? Provider.of<UserProvider>(
//                                                       context,
//                                                       listen: false)
//                                                   .result
//                                               : address,
//                                         ),
//                                         // Menu(),
//                                         // Review(),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(width: width / 20),
//                         Text(
//                           LanguageEn.products,
//                           style: TextStyle(
//                               color: notifier.getblackcolor,
//                               fontSize: height / 45,
//                               fontFamily: 'GilroyBold'),
//                         ),
//                         const Spacer(),
//                         products.length != 0
//                             ? GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         SpecificAllProductScreen(
//                                       shopId,
//                                       shopName,
//                                     ),
//                                   ));
//                                 },
//                                 child: Text(
//                                   LanguageEn.showall,
//                                   style: TextStyle(
//                                       color: notifier.getred,
//                                       fontSize: height / 55,
//                                       fontFamily: 'GilroyMedium'),
//                                 ),
//                               )
//                             : Container(),
//                         SizedBox(width: width / 18),
//                       ],
//                     ),
//                     SizedBox(
//                       height: height / 80,
//                     ),
//                     products.length == 0
//                         ? Center(
//                             child: Text('No products found'),
//                           )
//                         : ListView.builder(
//                             itemCount: products.length,
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               if (index < products.length) {
//                                 final product = products[index];

//                                 final prodName = product.name;
//                                 final sellingPrice = product.sellingPrice;

//                                 final image = product.image ?? '';

//                                 final sellerName = product.sellerName;

//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height: height / 80,
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         Navigator.of(context).pushNamed(
//                                           SearchProductDetailsScreen.routeName,
//                                           arguments: products[index],
//                                         );
//                                       },
//                                       child: FoodItem(
//                                           i: index,
//                                           prodName: prodName ?? '',
//                                           prodPrice: sellingPrice!.toInt() ?? 0,
//                                           sellerName: sellerName ?? '',
//                                           desc: 'This is a test description',
//                                           notifier: notifier,
//                                           image: image,
//                                           isShopProduct: true),
//                                     ),
//                                     SizedBox(
//                                       height: height / 80,
//                                     ),
//                                   ],
//                                 );
//                               } else {
//                                 return Center(
//                                   child: CircularProgressIndicator(),
//                                 );
//                               }
//                             })
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget restorentstatuscard(
//     double wi,
//     double h,
//     Widget child,
//   ) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Container(
//         child: child,
//       ),
//     );
//   }
// }
