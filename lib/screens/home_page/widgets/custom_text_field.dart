import 'package:flutter/material.dart';
import 'package:buynow/constants/utils.dart';

import '../../../utils/mediaqury.dart';
import '../../search_screen/screens/search_product_list_screen.dart';

Widget customTextField({
  required double wi,
  required Color textbgcolor,
  required TextEditingController controller,
  required Color textcolor,
  required String name1,
  required BuildContext context,
  required List<dynamic> prodList,
}) {
  return Container(
    height: height / 16,
    width: wi,
    padding: EdgeInsets.all(3),
    decoration: BoxDecoration(
        color: textbgcolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        border: Border.all(width: 0.5, color: Colors.grey)),
    child: TextField(
      controller: controller,
      style: TextStyle(color: textcolor),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search_rounded, size: height / 35),
        border: InputBorder.none,
        hintText: name1,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      textCapitalization: TextCapitalization.words,
      onSubmitted: (value) async {
        if (value.isEmpty) {
          showSnackBar('Search Something.');
          return;
        }

        Navigator.of(context)
            .pushNamed(SearchProductListScreen.routeName, arguments: value);
      },
    ),
  );
}
