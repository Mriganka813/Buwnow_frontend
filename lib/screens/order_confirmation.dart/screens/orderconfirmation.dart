import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/custtomscreens/custtombutton.dart';
import 'package:gofoods/screens/yourorder/deliveryadrees.dart';
import 'package:gofoods/services/address_services.dart';
import 'package:gofoods/services/cart_services.dart';
import 'package:gofoods/services/order_services.dart';
import 'package:gofoods/utils/enstring.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/show_model_bottom_sheet.dart';

class OrderConformation extends StatefulWidget {
  static const routeName = '/order-confirmation';
  const OrderConformation({Key? key}) : super(key: key);

  @override
  State<OrderConformation> createState() => _OrderConformationState();
}

class _OrderConformationState extends State<OrderConformation> {
  late ColorNotifier notifier;

  final CartServices cartServices = CartServices();
  final OrderServices orderServices = OrderServices();
  final AddressServices addressServices = AddressServices();
  List<dynamic> cartData = [];

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

  bool isLoading = false;
  int subTotal = 0;
  Map<String, dynamic>? args = {};
  String userName = '';
  String phoneNumber = '';
  String street = '';
  String city = '';
  String state = '';
  String pincode = '';
  String additional = '';

  String latitude = '';
  String longitude = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (args != null) {
        args = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic> ??
            {};
        userName = args!['phoneNumber'] ?? '';
        street = args!['street'] ?? '';
        city = args!['city'] ?? '';
        state = args!['state'] ?? '';
        pincode = args!['pincode'] ?? '';
        additional = args!['additional'] ?? '';

        address = street + ',' + city + "," + state + "," + pincode;
        print(address);
      }
    });
    getdarkmodepreviousstate();
    getCartData();
  }

  getCartData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    cartData = await cartServices.getCartItems(context);
    cartData.forEach(
      (product) => subTotal +=
          int.parse(product['product']['sellingPrice'].toString()) *
              int.parse(product['quantity'].toString()),
    );

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  int _groupValue = -1;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((_) {
      showSnackBar('Please wait while we are fetching live location.');
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  orderNow() async {
    if (cartData.length == 0) {
      return;
    } else if (address.isEmpty) {
      showSnackBar('Please enter address');
      return;
    }
    await getUserCurrentLocation().then((value) async {
      latitude = value.latitude.toString();
      longitude = value.longitude.toString();
      print(latitude);
      print(longitude);
    });

    showmodelbottomsheet(
      notifier: notifier,
      context: context,
      groupValue: _groupValue,
      orderServices: orderServices,
      name: userName,
      phoneNo: phoneNumber,
      street: street,
      city: city,
      state: state,
      pincode: pincode,
      additional: additional,
      latitude: latitude,
      longitude: longitude,
      addressServices: addressServices,
    );
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height / 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressUpdates(),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        color: Colors.transparent,
                        height: height / 13,
                        width: width / 1.1,
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: notifier.getstarcolor,
                                size: height / 25),
                            SizedBox(width: width / 40),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height / 70),
                                  Text(
                                    LanguageEn.deliveryto,
                                    style: TextStyle(
                                        color: notifier.getgrey,
                                        fontFamily: 'GilroyMedium',
                                        fontSize: height / 50),
                                  ),
                                  if (address.isNotEmpty)
                                    Text(
                                      address,
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: notifier.getblackcolor,
                                          fontFamily: 'GilroyBold',
                                          fontSize: height / 50),
                                    )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_forward_ios,
                                  color: notifier.getblackcolor,
                                  size: height / 50),
                            ),
                            SizedBox(width: width / 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: height / 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 20),
                    child: Divider(color: notifier.getgrey),
                  ),
                  SizedBox(height: height / 50),
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
                  cartData.length == 0
                      ? Container(
                          height: height / 4,
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            'You have not added any products in your cart',
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartData.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final name = cartData[index]['product']['name'];
                            final price =
                                cartData[index]['product']['sellingPrice'];
                            final qty = cartData[index]['quantity'];
                            final totalAmount = price * qty;
                            final id = cartData[index]['product']['_id'];

                            return Column(
                              children: [
                                Dismissible(
                                    key: ValueKey(DateTime.now()),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 20),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      child: const Icon(
                                        Icons.delete,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    confirmDismiss: (direction) {
                                      return _showDialog();
                                    },
                                    onDismissed: (direction) async {
                                      await cartServices.removeFromCart(
                                          context, id);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => super.widget,
                                          ));
                                    },
                                    child: cartItem(
                                        qty, name, totalAmount, price)),
                                SizedBox(height: height / 80),
                              ],
                            );
                          }),

                  SizedBox(height: height / 100),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 20),
                    child: Divider(color: notifier.getgrey),
                  ),
                  SizedBox(height: height / 100),
                  Row(
                    children: [
                      SizedBox(width: width / 20),
                      Text(
                        LanguageEn.subtotals,
                        style: TextStyle(
                          color: notifier.getgrey,
                          fontSize: height / 60,
                          fontFamily: 'GilroyMedium',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "₹${subTotal}",
                        style: TextStyle(
                          color: notifier.getgrey,
                          fontSize: height / 60,
                          fontFamily: 'GilroyMedium',
                        ),
                      ),
                      SizedBox(width: width / 20),
                    ],
                  ),
                  SizedBox(height: height / 100),
                  Row(
                    children: [
                      SizedBox(width: width / 20),
                      Text(
                        LanguageEn.deliverycharges,
                        style: TextStyle(
                          color: notifier.getgrey,
                          fontSize: height / 60,
                          fontFamily: 'GilroyMedium',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "₹40",
                        style: TextStyle(
                          color: notifier.getgrey,
                          fontSize: height / 60,
                          fontFamily: 'GilroyMedium',
                        ),
                      ),
                      SizedBox(width: width / 20),
                    ],
                  ),
                  SizedBox(height: height / 100),
                  Row(
                    children: [
                      SizedBox(width: width / 20),
                      Text(
                        LanguageEn.total,
                        style: TextStyle(
                          color: notifier.getblackcolor,
                          fontSize: height / 60,
                          fontFamily: 'GilroyBold',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "₹${subTotal + 40}",
                        style: TextStyle(
                          color: notifier.getblackcolor,
                          fontSize: height / 60,
                          fontFamily: 'GilroyBold',
                        ),
                      ),
                      SizedBox(width: width / 20),
                    ],
                  ),
                  SizedBox(height: height / 5),
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
            notifier.getred,
            notifier.getwhite,
            "Order now",
            width / 1.1,
          ),
        ),
      ),
    );
  }

  Widget cartItem(int qty, String name, int totalAmount, int price) {
    return Row(
      children: [
        Container(
          height: height / 13,
          width: width / 6,
          margin: EdgeInsets.only(left: width / 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            image: DecorationImage(
                image: AssetImage('assets/foods.png'), fit: BoxFit.fill),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
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
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "₹${totalAmount}",
              style: TextStyle(
                color: notifier.getblackcolor,
                fontSize: height / 50,
                fontFamily: 'GilroyBold',
              ),
            ),
            Text(
              "₹${price}",
              style: TextStyle(
                color: notifier.getgrey,
                fontSize: height / 70,
                fontFamily: 'GilroyMedium',
              ),
            )
          ],
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
                'Do you want to remove item from the cart?',
                style: TextStyle(
                  color: notifier.getgrey,
                  fontSize: height / 30,
                  fontFamily: 'GilroyBold',
                ),
              ),
              SizedBox(height: height / 50),
              Text(
                'Are you sure?',
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
            fontSize: height / 50,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }
}
