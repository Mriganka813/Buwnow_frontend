import 'package:buynow/constants/utils.dart';
import 'package:buynow/models/product.dart';
import 'package:buynow/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:buynow/screens/search_screen/screens/search_products_details_screen.dart';
import 'package:buynow/screens/search_screen/widgets/food_item.dart';
import 'package:buynow/services/search_product_services.dart';
import 'package:buynow/utils/mediaqury.dart';
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
  final SearchProductServices searchProductServices = SearchProductServices();
  List<Product> prodList = [];
  bool isLoadingMore = false;

  CartServices cartServices = CartServices();
  List<CartItem> cartData = [];

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
    getCartData();
    scrollController.addListener(_scrollListener);
    fetchSearchedProducts();
  }

  getCartData() async {
    cartServices.getCartItems(context);
  }

  goToProductDetails(BuildContext context, int idx) {
    Navigator.of(context).pushNamed(SearchProductDetailsScreen.routeName,
        arguments: prodList[idx]);
  }

  Future<void> fetchSearchedProducts() async {
    prodList = prodList +
        await searchProductServices.getProducts(widget.title, context, page);
    print("searched products: $prodList");
    if (prodList.length == 0) {
      showSnackBar('No products found');
    }
    setState(() {});
  }

  void _scrollListener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page++;
      setState(() {
        isLoadingMore = true;
      });
      await fetchSearchedProducts();
      setState(() {
        isLoadingMore = false;
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
        body: prodList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                physics: AlwaysScrollableScrollPhysics(),
                itemCount:
                    isLoadingMore ? prodList.length + 1 : prodList.length,
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < prodList.length) {
                    final product = prodList[index];

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
                            prodName: prodList[index].name!,
                            priceAfterDiscount: priceAfterDiscount.toInt(),
                            prodPrice: prodList[index].sellingPrice!,
                            sellerName: prodList[index].sellerName ?? '',
                            desc: 'No description available',
                            notifier: notifier,
                            image: prodList[index].image ?? '',
                            onAddTap: () async {
                              if (cartData.length > 0) {
                                if (prodList[index].user ==
                                    cartData[0].sellerId) {
                                  await cartServices.addToCart(
                                      context, prodList[index].sId!, '1');
                                } else {
                                  _showMyDialog(
                                      "You can not buy products from different seller at a time.");
                                }
                              } else {
                                await cartServices.addToCart(
                                    context, prodList[index].sId!, '1');
                                showSnackBar('Item added successfully.');
                              }
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
