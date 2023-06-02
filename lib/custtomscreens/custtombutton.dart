import 'package:flutter/material.dart';
import 'package:gofoods/utils/mediaqury.dart';
Widget button(buttoncolor, buttontextcolor, txt, w) {
  return Container(
    height: height / 14,
    width: w,
    decoration: BoxDecoration(
      color: buttoncolor,
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    child: Center(
      child: Text(
        txt,
        style: TextStyle(
            color: buttontextcolor,
            fontSize: height / 50,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

