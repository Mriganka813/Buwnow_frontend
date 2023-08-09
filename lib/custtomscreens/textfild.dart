import 'package:flutter/material.dart';
import 'package:buynow/utils/mediaqury.dart';

class Customtextfild {
  static Widget textField(
      String name1,
      Color textcolor,
      double wi,
      IconData icon,
      Color fillcolor,
      TextEditingController controller,
      bool obscureText) {
    return Container(
      height: height / 16,
      width: wi,
      padding: EdgeInsets.all(0),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(13),
        ),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: TextField(
          controller: controller,
          maxLines: 1,
          textInputAction: TextInputAction.next,
          scrollPhysics: ClampingScrollPhysics(),
          // scrollPhysics: ClampingScrollPhysics(),
          textCapitalization: TextCapitalization.sentences,
          obscureText: obscureText,
          obscuringCharacter: '*',
          style: TextStyle(color: textcolor),
          decoration: InputDecoration(
            fillColor: fillcolor,
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: InputBorder.none,
            prefixIcon: Icon(icon, size: height / 35),
            hintText: name1,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////

class Customsearchtextfild {
  static Widget textField(String name1, Color textcolor, double wi,
      Color textbgcolor, TextEditingController controller) {
    return Container(
      height: height / 16,
      padding: EdgeInsets.all(3),
      width: wi,
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
      ),
    );
  }
}
