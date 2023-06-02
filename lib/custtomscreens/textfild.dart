import 'package:flutter/material.dart';
import 'package:gofoods/utils/mediaqury.dart';

class Customtextfild {
  static Widget textField(
      name1, textcolor, wi, icon, fillcolor, TextEditingController controller,
      {obscureText = false}) {
    return Container(
      height: height / 16,
      width: wi,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(13),
        ),
      ),
      child: TextField(
        controller: controller,
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
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////

class Customsearchtextfild {
  static Widget textField(name1, textcolor, wi, textbgcolor) {
    return Container(
      height: height / 16,
      width: wi,
      decoration: BoxDecoration(
        color: textbgcolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
      ),
      child: TextField(
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
