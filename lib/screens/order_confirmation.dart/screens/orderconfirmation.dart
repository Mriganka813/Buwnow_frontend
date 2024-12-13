import 'package:buynow/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:buynow/custtomscreens/custtombutton.dart';
import 'package:buynow/screens/yourorder/deliveryadrees.dart';
import 'package:buynow/services/cart_services.dart';
import 'package:buynow/utils/enstring.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/cart_item.dart';

class OrderConformation extends StatefulWidget {
  static const routeName = '/order-confirmation';
  const OrderConformation({Key? key}) : super(key: key);

  @override
  State<OrderConformation> createState() => _OrderConformationState();
}

class _OrderConformationState extends State<OrderConformation> {
  late ColorNotifier notifier;

  final CartServices _cartServices = CartServices();
  // final AddressServices _addressServices = AddressServices();
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

  String address = '';

  bool _isLoading = false;
  int subTotal = 0;

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
    getCartData();
  }

  // get cart data
  getCartData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    _cartData = await _cartServices.getCartItems(context);

    // calculate total from all cart items
    _cartData.forEach(
      (product) => subTotal += int.parse(product.discountedPrice.toString()) *
          int.parse(product.qty.toString()),
    );
    Provider.of<UserProvider>(context, listen: false)
        .setTotalPriceOfCartItems(subTotal);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // navigate to map page
  orderNow() async {
    if (_cartData.length == 0) {
      return;
    }

    // set seller id for get seller upi details at payment page
    Provider.of<UserProvider>(context, listen: false)
        .setSellerId(_cartData[0].sellerId!);
    Navigator.of(context).pushNamed(AddressUpdates.routeName);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    return Scaffold(
      backgroundColor: notifier.getwhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.getwhite,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,
              color: notifier.getblackcolor, size: height / 50),
        ),
        centerTitle: true,
        title: Text(
          LanguageEn.orderconfirmation,
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height / 40),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const AddressUpdates(),
                  //       ),
                  //     );
                  //   },
                  // child: Center(
                  //   child: Container(
                  //     color: Colors.transparent,
                  //     height: height / 13,
                  //     width: width / 1.1,
                  //     child: Row(
                  //       children: [
                  //         Icon(Icons.location_on_outlined,
                  //             color: notifier.getstarcolor,
                  //             size: height / 25),
                  //         SizedBox(width: width / 40),
                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               SizedBox(height: height / 70),
                  //               Text(
                  //                 LanguageEn.deliveryto,
                  //                 style: TextStyle(
                  //                     color: notifier.getgrey,
                  //                     fontFamily: 'GilroyMedium',
                  //                     fontSize: height / 50),
                  //               ),
                  //               if (address.isNotEmpty)
                  //                 Text(
                  //                   address,
                  //                   maxLines: 1,
                  //                   softWrap: false,
                  //                   overflow: TextOverflow.ellipsis,
                  //                   style: TextStyle(
                  //                       color: notifier.getblackcolor,
                  //                       fontFamily: 'GilroyBold',
                  //                       fontSize: height / 50),
                  //                 )
                  //             ],
                  //           ),
                  //         ),
                  //         Align(
                  //           alignment: Alignment.centerRight,
                  //           child: Icon(Icons.arrow_forward_ios,
                  //               color: notifier.getblackcolor,
                  //               size: height / 50),
                  //         ),
                  //         SizedBox(width: width / 30),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // ),
                  // SizedBox(height: height / 50),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: width / 20),
                  //   child: Divider(color: notifier.getgrey),
                  // ),
                  // SizedBox(height: height / 50),
                  Row(
                    children: [
                      SizedBox(width: width / 20),
                      Text(
                        LanguageEn.yourorder,
                        style: TextStyle(
                            color: notifier.getgrey,
                            fontFamily: 'GilroyBold',
                            fontSize: height / 50),
                      )
                    ],
                  ),
                  SizedBox(height: height / 50),

                  // show cart items
                  _cartData.length == 0
                      ? Container(
                          height: height / 4,
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            'You have not added any products in your cart',
                            maxLines: 2,
                            style: TextStyle(
                                color: notifier.getgrey,
                                fontFamily: 'GilroyMedium',
                                fontSize: height / 50),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _cartData.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final name = _cartData[index].name;
                            final price = _cartData[index].discountedPrice!;
                            final quantity = _cartData[index].qty!;
                            final totalAmount = price * quantity;
                            final id = _cartData[index].productId;
                            final String image = _cartData[index].image!;

                            return Column(
                              children: [
                                Dismissible(
                                    key: ValueKey(DateTime.now()),
                                    background: Container(
                                      width: width,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          const Icon(
                                            Icons.delete,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    confirmDismiss: (direction) {
                                      return _showDialog();
                                    },
                                    onDismissed: (direction) async {
                                      await _cartServices.removeFromCart(
                                          context, id!);
                                      _cartData.removeAt(index);

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      if (_cartData.length == 0) {
                                        prefs.remove('lat');
                                        prefs.remove('long');
                                      }
                                      setState(() {});

                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => super.widget,
                                      //     ));
                                    },
                                    child: cartItem(quantity, name!,
                                        totalAmount, price, image)),
                                SizedBox(height: height / 60),
                              ],
                            );
                          }),

                  // SizedBox(height: height / 100),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: width / 20),
                  //   child: Divider(color: notifier.getgrey),
                  // ),
                  // SizedBox(height: height / 100),
                  // Row(
                  //   children: [
                  //     SizedBox(width: width / 20),
                  //     Text(
                  //       LanguageEn.subtotals,
                  //       style: TextStyle(
                  //         color: notifier.getgrey,
                  //         fontSize: height / 60,
                  //         fontFamily: 'GilroyMedium',
                  //       ),
                  //     ),
                  //     const Spacer(),
                  //     Text(
                  //       "₹${subTotal}",
                  //       style: TextStyle(
                  //         color: notifier.getgrey,
                  //         fontSize: height / 60,
                  //         fontFamily: 'GilroyMedium',
                  //       ),
                  //     ),
                  //     SizedBox(width: width / 20),
                  //   ],
                  // ),
                  // SizedBox(height: height / 100),
                  // Row(
                  //   children: [
                  //     SizedBox(width: width / 20),
                  //     Text(
                  //       LanguageEn.deliverycharges,
                  //       style: TextStyle(
                  //         color: notifier.getgrey,
                  //         fontSize: height / 60,
                  //         fontFamily: 'GilroyMedium',
                  //       ),
                  //     ),
                  //     const Spacer(),
                  //     Text(
                  //       "₹40",
                  //       style: TextStyle(
                  //         color: notifier.getgrey,
                  //         fontSize: height / 60,
                  //         fontFamily: 'GilroyMedium',
                  //       ),
                  //     ),
                  //     SizedBox(width: width / 20),
                  //   ],
                  // ),
                  // SizedBox(height: height / 100),
                  // Row(
                  //   children: [
                  //     SizedBox(width: width / 20),
                  //     Text(
                  //       LanguageEn.total,
                  //       style: TextStyle(
                  //         color: notifier.getblackcolor,
                  //         fontSize: height / 60,
                  //         fontFamily: 'GilroyBold',
                  //       ),
                  //     ),
                  //     const Spacer(),
                  //     Text(
                  //       "₹${subTotal + 40}",
                  //       style: TextStyle(
                  //         color: notifier.getblackcolor,
                  //         fontSize: height / 60,
                  //         fontFamily: 'GilroyBold',
                  //       ),
                  //     ),
                  //     SizedBox(width: width / 20),
                  //   ],
                  // ),
                  // SizedBox(height: height / 5),
                ],
              ),
            ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          orderNow();
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: button(
            _cartData.length == 0 ? notifier.getgrey : notifier.getred,
            notifier.getwhite,
            "Order now",
            width / 1.1,
          ),
        ),
      ),
    );
  }

  Widget cartItem(
      int qty, String name, int totalAmount, int price, String image) {
    return Row(
      children: [
        Container(
          height: height / 12,
          width: width / 6,
          margin: EdgeInsets.only(left: width / 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            image: image == 'unavailable'
                ? DecorationImage(
                    image: AssetImage('assets/product_image.png'),
                    fit: BoxFit.fill,
                  )
                : DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
          ),
        ),
        SizedBox(width: width / 30),
        Text(
          "${qty} x",
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
        SizedBox(width: width / 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 50,
                  fontFamily: 'GilroyBold',
                ),
              ),
              Text(
                LanguageEn.pieces,
                style: TextStyle(
                  color: notifier.getgrey,
                  fontSize: height / 60,
                  fontFamily: 'GilroyMedium',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FittedBox(
                child: Text(
                  "₹${totalAmount}",
                  style: TextStyle(
                    color: notifier.getblackcolor,
                    fontSize: height / 50,
                    fontFamily: 'GilroyBold',
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  "₹${price}",
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 70,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(width: width / 20),
      ],
    );
  }

  Future<bool?> _showDialog() {
    return showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: notifier.getwhite,
        content: Container(
          color: Colors.transparent,
          height: height / 3.8,
          child: Column(
            children: [
              SizedBox(height: height / 130),
              Text(
                'Do you want to remove items from the cart?',
                style: TextStyle(
                  color: notifier.getgrey,
                  fontSize: height / 30,
                  fontFamily: 'GilroyBold',
                ),
              ),
              SizedBox(height: height / 50),
              // Text(
              //   'Are you sure?',
              //   style: TextStyle(
              //     color: notifier.getblackcolor,
              //     fontSize: height / 50,
              //     fontFamily: 'GilroyMedium',
              //   ),
              // ),
              SizedBox(height: height / 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx, false);
                    },
                    child:
                        dailogbutton(Colors.transparent, 'No', notifier.getred),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(ctx, true);
                    },
                    child: dailogbutton(
                        Colors.transparent, 'Yes', notifier.getred),
                  ),
                ],
              )
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
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
            fontSize: height / 40,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }
}
