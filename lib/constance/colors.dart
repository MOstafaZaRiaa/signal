import 'package:flutter/material.dart';

class MyColors {

  static const Map<int, Color> color =
  {
    50:Color.fromRGBO(238,17,25, .1),
    100:Color.fromRGBO(238,17,25, .2),
    200:Color.fromRGBO(238,17,25, .3),
    300:Color.fromRGBO(238,17,25, .4),
    400:Color.fromRGBO(238,17,25, .5),
    500:Color.fromRGBO(238,17,25, .6),
    600:Color.fromRGBO(238,17,25, .7),
    700:Color.fromRGBO(238,17,25, .8),
    800:Color.fromRGBO(238,17,25, .9),
    900:Color.fromRGBO(238,17,25, 1),
  };
  static MaterialColor primarySwatch = const MaterialColor(0xFFee1119, color);

  static const Color myPrimary = Color(0xFFee1119);
  static const Color myGrey = Color(0xFF929292);
  static const Color myWhite = Color(0xffffffff);

}
