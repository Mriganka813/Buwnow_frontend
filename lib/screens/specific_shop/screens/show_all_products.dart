import 'package:buynow/constants/utils.dart';
import 'package:buynow/models/product.dart';
import 'package:buynow/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:buynow/screens/search_screen/screens/search_products_details_screen.dart';
import 'package:buynow/screens/search_screen/widgets/food_item.dart';
import 'package:buynow/services/specific_shop_details.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/cart_item.dart';
import '../../order_confirmation.dart/screens/orderconfirmation.dart';

class SpecificAllProductScreen extends StatefulWidget {
  static const routeName = '/specific-shop-products';
  SpecificAllProductScreen(this.shopId, this.title);

  final String shopId;
  final String title;

  @override
  State<SpecificAllProductScreen> createState() =>
      _SpecificAllProductScreenState();
}

class _SpecificAllProductScreenState extends State<SpecificAllProductScreen>
    with TickerProviderStateMixin {
  late ColorNotifier notifier;
  TabController? controller;
  final scrollController = ScrollController();

  bool _isLoading = false;
  List<Product> _products = [];

  bool _isLoadingMore = false;
  int _page = 1;

  final SpecificShopDetails _shopDetails = SpecificShopDetails();
  CartServices _cartServices = CartServices();
  List<CartItem> _cartData = [];

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  getCartData() async {
    _cartData = await _cartServices.getCartItems(context);
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
    scrollController.addListener(_scrollListener);
    getShopDetails();
    getCartData();
    controller =
        TabController(length: 1, vsync: this, animationDuration: Duration.zero);
  }

  // get shop products
  getShopDetails() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero, () async {
      _products = _products +
          await _shopDetails.getShopProducts(context, widget.shopId, _page);
      if (_products.length == 0) {
        showSnackBar('No products found');
      }
      setState(() {
        _isLoading = false;
      });
    });
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
      await getShopDetails();
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
          widget.title,
          style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 45,
              fontFamily: 'GilroyBold'),
        ),
      ),
      body: _products.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount:
                  _isLoadingMore ? _products.length + 1 : _products.length,
              controller: scrollController,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < _products.length) {
                  final product = _products[index];
                  final prodId = product.sId;
                  final discount = product.discount ?? 0;
                  final prodName = product.name;
                  final sellingPrice = product.sellingPrice!.toInt();
                  final image = product.image ?? '';
                  final sellerName = product.sellerName;

                  final discountPrice = (sellingPrice * discount) / 100;
                  final priceAfterDiscount = sellingPrice - discountPrice;

                  return InkWell(
                    onTap: () {
                      if (!(product.available!)) {
                        showSnackBar('Product is not available right now');
                        return;
                      }
                      Navigator.of(context).pushNamed(
                        SearchProductDetailsScreen.routeName,
                        arguments: _products[index],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: FoodItem(
                        i: index,
                        prodName: prodName ?? '',
                        priceAfterDiscount: priceAfterDiscount.toInt(),
                        prodPrice: sellingPrice.toInt(),
                        sellerName: sellerName ?? '',
                        desc: 'No description available',
                        notifier: notifier,
                        image: image,
                        isShopProduct: true,
                        onAddTap: () async {
                          // check product availability
                          if (!(product.available!)) {
                            showSnackBar('Product is not available right now');
                            return;
                          }

                          // if cart has items and ensure that current item is not of different seller
                          if (_cartData.length > 0) {
                            if (widget.shopId == _cartData[0].sellerId) {
                              await _cartServices.addToCart(
                                  context, prodId!, '1');
                              showSnackBar('Item added successfully.');
                            } else {
                              _showMyDialog(
                                  "You can not buy products from different seller at a time.");
                              return;
                            }

                            // if cart has no items
                          } else {
                            await _cartServices.addToCart(
                                context, prodId!, '1');
                            showSnackBar('Item added successfully.');
                          }
                          Navigator.of(context)
                              .pushNamed(OrderConformation.routeName);
                        },
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
    );
  }

  Widget restorentstatuscard(
    double wi,
    double h,
    Widget child,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        child: child,
      ),
    );
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
