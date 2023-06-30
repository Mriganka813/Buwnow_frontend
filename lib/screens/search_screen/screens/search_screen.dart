import 'package:flutter/material.dart';
import 'package:gofoods/constants/utils.dart';
import 'package:gofoods/custtomscreens/textfild.dart';
import 'package:gofoods/screens/bottombar/bottombar.dart';
import 'package:provider/provider.dart';

import '../../../custtomscreens/custtombutton.dart';
import '../../../providers/user_provider.dart';
import '../../../services/search_by_city_services.dart';
import '../../../utils/mediaqury.dart';
import '../../../utils/notifirecolor.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  bool isLoading = false;
  final SearchServices searchServices = SearchServices();
  List<dynamic> list = [];

  void submit() async {
    final searchText = searchController.text.trim();
    if (searchText.isEmpty) {
      showSnackBar('Please enter city or country.');
      return;
    }
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    Provider.of<UserProvider>(context, listen: false).setKeyword(searchText);
    await searchServices.sendCityName(searchText, context);

    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => BottomHome(),
    ))
        .then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getwhite,
      appBar: AppBar(
        title: Text('Select location'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Customsearchtextfild.textField(
                'Search by city, state or country',
                notifier.getblackcolor,
                width / 1.13,
                notifier.getwhite,
                searchController,
              ),
              SizedBox(
                height: height / 20,
              ),
              Image.asset(
                'assets/search.png',
                height: height / 3,
                width: width / 1.2,
              ),
              SizedBox(
                height: height / 15,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: InkWell(
                onTap: () {
                  submit();
                },
                child: button(
                    Colors.green, notifier.getwhite, 'Search', width / 1.13),
              ),
            ),
    );
  }

  // Widget customButton(Color buttoncolor, Widget ch) {
  //   return Container(
  //     height: height / 14,
  //     width: width / 1.13,
  //     decoration: BoxDecoration(
  //       color: buttoncolor,
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(15),
  //       ),
  //     ),
  //     child: Center(child: ch),
  //   );
  // }
}
