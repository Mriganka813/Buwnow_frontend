import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// void showSnackBar(BuildContext context, String text) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//       duration: const Duration(seconds: 2),
//     ),
//   );
// }

void showSnackBar(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
