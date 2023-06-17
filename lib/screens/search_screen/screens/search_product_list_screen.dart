import 'package:flutter/material.dart';
import 'package:gofoods/screens/search_screen/screens/search_products_details_screen.dart';
import 'package:gofoods/screens/search_screen/widgets/food_item.dart';
import 'package:gofoods/services/search_product_services.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/notifirecolor.dart';

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
  List<dynamic> prodList = [];
  bool isLoadingMore = false;

  int page = 0;

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
    scrollController.addListener(_scrollListener);
    fetchSearchedProducts();
  }

  goToProductDetails(BuildContext context, int idx) {
    Navigator.of(context).pushNamed(SearchProductDetailsScreen.routeName,
        arguments: prodList[idx]);
  }

  Future<void> fetchSearchedProducts() async {
    prodList = prodList +
        await searchProductServices.getProducts(widget.title, context);
    print("searched products: $prodList");
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
                    return InkWell(
                      onTap: () => goToProductDetails(context, index),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height / 80,
                          ),
                          FoodItem(
                            i: index,
                            prodName: prodList[index]['name'],
                            prodPrice: prodList[index]['sellingPrice'],
                            sellerName: prodList[index]['sellerName'],
                            desc: prodList[index]['description'] ??
                                'This is a test description.',
                            notifier: notifier,
                            image: prodList[index]['image'] ?? '',
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
}
