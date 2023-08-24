import 'dart:async';
import 'dart:convert';

import 'package:buynow/constants/utils.dart';
import 'package:buynow/custtomscreens/custtombutton.dart';
import 'package:buynow/custtomscreens/textfild.dart';
import 'package:buynow/providers/user_provider.dart';
import 'package:buynow/screens/order_details/screens/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:buynow/utils/mediaqury.dart';
import 'package:buynow/utils/notifirecolor.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AddressUpdates extends StatefulWidget {
  static const routeName = '/old-addresses';
  const AddressUpdates({Key? key}) : super(key: key);

  static const _initialPostion =
      CameraPosition(target: LatLng(26.957760, 79.789900), zoom: 14);

  @override
  State<AddressUpdates> createState() => _AddressUpdatesState();
}

class _AddressUpdatesState extends State<AddressUpdates> {
  late ColorNotifier notifire;

  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  LatLng? markerLatLng;

  final searchController = TextEditingController();

  var uuid = Uuid();
  String? _sessionToken = '12345';
  List<dynamic> _placesList = [];

  bool istapped = true;

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

    searchController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(searchController.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = 'AIzaSyCIJ0M2vvrymov0ZgzgR9Arx4SMAIm8_ic';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    print(response.body.toString());

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
        istapped = true;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // convert address into lat long
  Future<LatLng> addressToLatLong(String address) async {
    List<Location> locations = await locationFromAddress(address);
    if (locations.length > 0) {
      return LatLng(locations.first.latitude, locations.first.longitude);
    } else {
      throw Exception("No location found for the address");
    }
  }

  // convert lat long into address
  Future<Placemark> latlngToAddress(double latitude, double longitude) async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(latitude, longitude);
    var first = addresses.first;
    print(first.name! +
        ',' +
        first.subAdministrativeArea! +
        ',' +
        first.locality! +
        ',' +
        first.country! +
        ',' +
        first.postalCode!);
    return first;
  }

  // animate the camera when user search location
  animateCamera(double latitude, double longitude) async {
    var cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14,
    );
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      mapController = controller;
    });
  }

  // when tapped on map
  void onMapTap(LatLng latLng) {
    setState(() {
      if (markerLatLng == null) {
        // Add initial marker
        markerLatLng = latLng;
      } else {
        // Replace existing marker
        markerLatLng = latLng;
      }
    });
  }

  // to get current location of user
  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    Position? currentLocation;
    try {
      await Geolocator.requestPermission()
          .then((_) {})
          .onError((error, stackTrace) async {
        await Geolocator.requestPermission();
      });
      currentLocation = await Geolocator.getCurrentPosition();
    } on Exception {
      showSnackBar('error');
    }

    var cameraPosition = CameraPosition(
      target: LatLng(currentLocation!.latitude, currentLocation.longitude),
      zoom: 14,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    markerLatLng = LatLng(currentLocation.latitude, currentLocation.longitude);
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    searchController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    notifire = Provider.of<ColorNotifier>(context, listen: true);

    return Scaffold(
        backgroundColor: notifire.getwhite,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: AddressUpdates._initialPostion,
                onMapCreated: this.onMapCreated,
                onTap: this.onMapTap,
                markers: Set<Marker>.of((markerLatLng != null)
                    ? [
                        Marker(
                          markerId: MarkerId('user_marker'),
                          position: markerLatLng!,
                        )
                      ]
                    : []),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.7,
                            color: notifire.getblackcolor,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      child: Customtextfild.textField(
                          'Search places',
                          Colors.black,
                          width / 1.13,
                          Icons.search,
                          Colors.white,
                          searchController,
                          false),
                    ),
                  ),
                  if (istapped)
                    ListView.builder(
                      itemCount: _placesList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var newAddress = _placesList[index]['description'];
                        return Container(
                          color: notifire.getwhite,
                          child: ListTile(
                            onTap: () async {
                              searchController.text = newAddress;

                              LatLng latLong =
                                  await addressToLatLong(newAddress);
                              animateCamera(
                                  latLong.latitude, latLong.longitude);
                              setState(() {
                                istapped = false;
                              });
                            },
                            title: Text(
                              newAddress,
                              style: TextStyle(
                                  color: notifire.getblackcolor,
                                  fontFamily: 'GilroyMedium',
                                  fontSize: height / 60),
                            ),
                          ),
                        );
                      },
                    )
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _currentLocation,
          child: Icon(Icons.my_location_rounded),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: GestureDetector(
            onTap: () async {
              if (markerLatLng == null) {
                showSnackBar('Please choose location');
                return;
              }

              // spread consumer lat long to app
              Provider.of<UserProvider>(context, listen: false)
                  .setConsumerLatLong(
                      markerLatLng!.latitude, markerLatLng!.longitude);

              // store consumer lat long locally
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'consumerLat', markerLatLng!.latitude.toString());
              await prefs.setString(
                  'consumerLong', markerLatLng!.longitude.toString());

              //

              Navigator.of(context).pushNamed(OrderDetailsScreen.routeName);
              // _showbottomsheet();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: button(notifire.getred, notifire.getwhite,
                  'Submit location', width / 1.1),
            ),
          ),
        ));
  }
}

// _showbottomsheet() {
//   void onsubmit() async {
//     // var response = await deliveryServices.deliveryFairCharges(
//     //   25.336089,
//     //   80.963976,
//     //   markerLatLng!.latitude,
//     //   markerLatLng!.longitude,
//     //   context,
//     // );

//     // print(response);

//     // final name = nameController.text.trim();
//     // final phoneNumber = phoneController.text.trim();

//     // if (name.isEmpty || (phoneNumber.isEmpty && phoneNumber.length != 10)) {
//     //   showSnackBar('Please fill all the fields');
//     //   return;
//     // }

//     // Placemark first = await latlngToAddress(
//     //     markerLatLng!.latitude, markerLatLng!.longitude);

//     // print(first);

//     // deliveryServices.deliveryFairCharges(
//     //   25.217529,
//     //   80.922493,
//     //   markerLatLng!.latitude,
//     //   markerLatLng!.longitude,
//     //   context
//     // );

//     // Navigator.of(context).pushNamed(OrderConformation.routeName, arguments: {
//     //   'name': name,
//     //   'phoneNumber': phoneNumber,
//     //   'street': first.street! + first.locality!,
//     //   'city': first.subAdministrativeArea,
//     //   'state': first.administrativeArea,
//     //   'pincode': first.postalCode,
//     // });
//   }

//   return showModalBottomSheet(
//       isScrollControlled: true,
//       constraints: BoxConstraints(maxHeight: height / 1.1),
//       context: context,
//       builder: (context) => Container(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: DraggableScrollableSheet(
//                 expand: false,
//                 maxChildSize: 0.45,
//                 initialChildSize: 0.45,
//                 minChildSize: 0.2,
//                 builder: (context, scrollController) => SingleChildScrollView(
//                       controller: scrollController,
//                       child: Column(
//                         children: [
//                           SizedBox(height: height / 20),
//                           Customtextfild.textField(
//                               LanguageEn.enteryourfullname,
//                               notifire.getblackcolor,
//                               width / 1.13,
//                               Icons.person,
//                               notifire.getbgfildcolor,
//                               nameController,
//                               false),
//                           SizedBox(height: height / 40),
//                           Customtextfild.textField(
//                               LanguageEn.enteryourphonenumber,
//                               notifire.getblackcolor,
//                               width / 1.13,
//                               Icons.call,
//                               notifire.getbgfildcolor,
//                               phoneController,
//                               false),
//                           SizedBox(height: height / 15),
//                           Padding(
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: width / 15),
//                             child: GestureDetector(
//                               onTap: onsubmit,
//                               child: button(
//                                   notifire.getred,
//                                   notifire.getwhite,
//                                   LanguageEn.submit,
//                                   width / 1.1),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//           ));
// }

// Center(
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).pushNamed(Address.routeName);
//         },
//         child: button(notifire.getred, notifire.getwhite,
//             LanguageEn.newaddress, width / 1.1),
//       ),
//     ),

// Widget con(name) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const Address(),
//         ),
//       );
//     },
//     child: Container(
//       height: height / 9,
//       width: width,
//       decoration: BoxDecoration(
//         color: notifire.getbgfildcolor,
//         borderRadius: const BorderRadius.all(
//           Radius.circular(15),
//         ),
//       ),
//       child: Column(
//         children: [
//           SizedBox(
//             height: height / 80,
//           ),
//           Row(
//             children: [
//               Row(
//                 children: [
//                   SizedBox(
//                     width: width / 30,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         style: TextStyle(
//                             color: notifire.getblackcolor,
//                             fontFamily: 'GilroyBold',
//                             fontSize: height / 50),
//                       ),
//                       SizedBox(
//                         height: height / 80,
//                       ),
//                       Text(
//                         LanguageEn.road,
//                         style: TextStyle(
//                             color: Colors.grey,
//                             fontFamily: 'GilroyMedium',
//                             fontSize: height / 65),
//                       ),
//                       SizedBox(
//                         height: height / 200,
//                       ),
//                       Text(
//                         "+88 012 356 870",
//                         style: TextStyle(
//                             color: Colors.grey,
//                             fontFamily: 'GilroyMedium',
//                             fontSize: height / 65),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Padding(
//                 padding: EdgeInsets.only(bottom: height / 20),
//                 child: Image.asset(
//                   "assets/edit.png",
//                   height: height / 40,
//                 ),
//               ),
//               SizedBox(
//                 width: width / 20,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }
