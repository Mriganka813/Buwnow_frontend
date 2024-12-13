import 'package:buynow/constants/utils.dart';
import 'package:buynow/models/near_by_restorent.dart';
import 'package:buynow/models/product.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:buynow/services/cart_services.dart';
import 'package:buynow/services/search_by_city_services.dart';
import 'package:flutter/material.dart';
import 'package:buynow/screens/search_screen/screens/search_products_details_screen.dart';
import 'package:buynow/screens/search_screen/widgets/food_item.dart';
import 'package:buynow/services/search_product_services.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/cart_item.dart';
import '../../../utils/notifirecolor.dart';
import '../../order_confirmation.dart/screens/orderconfirmation.dart';

class SearchProductListScreen extends StatefulWidget {
  static const routeName = '/search-product-list-screen';

  const SearchProductListScreen({required this.title});

  final String title;

  @override
  State<SearchProductListScreen> createState() =>
      _SearchProductListScreenState();
}

class _SearchProductListScreenState extends State<SearchProductListScreen> {
  late ColorNotifier notifier;
  final scrollController = ScrollController();
  final SearchProductServices _searchProductServices = SearchProductServices();

  List<Product> _prodList = [];
  bool _isLoadingMore = false;

  CartServices _cartServices = CartServices();
  List<CartItem> _cartData = [];

  final SearchServices _searchServices = SearchServices();
  List<NearbyRestorentModel> _productShop = [];

  int _page = 1;

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
    getShopDetails();
    getCartData();
    scrollController.addListener(_scrollListener);
    fetchSearchedProducts();
  }

  // get shop details for opening and closing time
  getShopDetails() async {
    final location = Provider.of<UserProvider>(context, listen: false).result;
    _productShop = await _searchServices.sendCityName(location, context);
  }

  // get cart data for restricted the added items of different seller
  getCartData() async {
    _cartData = await _cartServices.getCartItems(context);
  }

  // get product details
  goToProductDetails(BuildContext context, int idx) async {
    NearbyRestorentModel? shopdetail;
    try {
      shopdetail = _productShop
          .firstWhere((element) => _prodList[idx].user == element.sId);
    } catch (e) {
      shopdetail = null;
    }

    if (shopdetail != null) {
      if (!(shopdetail.shopOpen!)) {
        showSnackBar('This shop is not available right now');
        return;
      }

      DateTime optime =
          DateFormat.Hm().parse(shopdetail.openingTime ?? '10:00');
      DateTime cltime =
          DateFormat.Hm().parse(shopdetail.closingTime ?? '22:00');

      // final ophour = optime.hour;
      // final opminute = optime.minute;

      // final clhour = cltime.hour;
      // final clminute = cltime.minute;

      print(optime);
      print(cltime);

      // Synchronize with an NTP server
      DateTime currentTime = await NTP.now();

      if (currentTime.hour < optime.hour ||
          (currentTime.hour == optime.hour &&
              currentTime.minute < optime.minute)) {
        showSnackBar(
            'This shop\'s product is available from ${optime.hour}:${optime.minute} to ${cltime.hour}:${cltime.minute}');
        return;
      } else if (currentTime.hour > cltime.hour ||
          (currentTime.hour == cltime.hour &&
              currentTime.minute > cltime.minute)) {
        showSnackBar(
            'This product shop\'s product is available from ${optime.hour}:${optime.minute} to ${cltime.hour}:${cltime.minute}');
        return;
      }
    }

    Navigator.of(context).pushNamed(SearchProductDetailsScreen.routeName,
        arguments: _prodList[idx]);
  }

  Future<void> fetchSearchedProducts() async {
    _prodList = _prodList +
        await _searchProductServices.getProducts(widget.title, context, _page);
    print("searched products: $_prodList");
    if (_prodList.length == 0) {
      showSnackBar('No products found');
    }
    setState(() {});
  }

  // this is for pagination
  void _scrollListener() async {
    if (_isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _page++;
      setState(() {
        _isLoadingMore = true;
      });
      await fetchSearchedProducts();
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context);
    return Scaffold(
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
            widget.title,
            style: TextStyle(
                color: notifier.getblackcolor,
                fontSize: height / 45,
                fontFamily: 'GilroyBold'),
          ),
        ),
        body: _prodList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                physics: AlwaysScrollableScrollPhysics(),
                itemCount:
                    _isLoadingMore ? _prodList.length + 1 : _prodList.length,
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < _prodList.length) {
                    final product = _prodList[index];

                    final discount = product.discount ?? 0;

                    final sellingPrice = product.sellingPrice!.toInt();

                    final discountPrice = (sellingPrice * discount) / 100;

                    final priceAfterDiscount = sellingPrice - discountPrice;

                    return InkWell(
                      onTap: () => goToProductDetails(context, index),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height / 80,
                          ),
                          FoodItem(
                            i: index,
                            prodName: _prodList[index].name!,
                            priceAfterDiscount: priceAfterDiscount.toInt(),
                            prodPrice: _prodList[index].sellingPrice!,
                            sellerName: _prodList[index].sellerName ?? '',
                            desc: 'No description available',
                            notifier: notifier,
                            image: _prodList[index].image ?? '',
                            onAddTap: () async {
                              // if cart has items and ensure that current item is not of different seller
                              if (_cartData.length > 0) {
                                if (_prodList[index].user ==
                                    _cartData[0].sellerId) {
                                  await _cartServices.addToCart(
                                      context, _prodList[index].sId!, '1');
                                  showSnackBar('Item added successfully.');
                                  Navigator.of(context)
                                      .pushNamed(OrderConformation.routeName);
                                } else {
                                  _showMyDialog(
                                      "You can not buy products from different seller at a time.");
                                }

                                // if cart has no items.
                              } else {
                                await _cartServices.addToCart(
                                    context, _prodList[index].sId!, '1');
                                showSnackBar('Item added successfully.');
                                Navigator.of(context)
                                    .pushNamed(OrderConformation.routeName);
                              }
                              setState(() {
                                // refresh cart data to check efficiently.
                                getCartData();
                              });
                            },
                          ),
                          SizedBox(
                            height: height / 80,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }));
  }

  _showMyDialog(String txt) async {
    return showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifier.getwhite,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: height / 5,
                child: Column(
                  children: [
                    SizedBox(height: height / 130),
                    Text(
                      'Warning',
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 30,
                        fontFamily: 'GilroyBold',
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Text(
                      txt,
                      style: TextStyle(
                        color: notifier.getblackcolor,
                        fontSize: height / 50,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                    context, OrderConformation.routeName)
                                .then((value) => getCartData());
                          },
                          child: dailogbutton(Colors.transparent, 'Go to cart',
                              notifier.getred),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        );
      },
    );
  }

  Widget dailogbutton(buttoncolor, txt, textcolor) {
    return Container(
      height: height / 16,
      width: width / 3.8,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        // border: Border.all(color: bordercolor),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
            color: textcolor,
            fontSize: height / 50,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }
}
