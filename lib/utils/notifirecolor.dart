import 'package:flutter/cupertino.dart';

import 'colors.dart';

class ColorNotifier with ChangeNotifier {
  bool isDark = false;

  set setIsDark(v) {
    isDark = v;
    notifyListeners();
  }

  get getIsdark => isDark;

  get getred => isDark ? redcolor : darkred;

  get getwhite => isDark ? darkwhite : white;

  get getbgcolor => isDark ? bgcolor : darkbgcolor;

  get getblackcolor => isDark ? blackcolor : darkblackcolor;

  get getgrey => isDark ? grey : darkgrey;

  get getstarcolor => isDark ? starcolor : darkstarcolor;

  get getbottomcolor => isDark ? darkbottomcolor :  bottomcolor;

  get getbgfildcolor => isDark ? bgfildcolor :  darkbgfildcolor;
}
