import 'package:flutter/material.dart';

class Constants {
  static const Color myGray = Color(0xFF354458);
  static const Color myOrange = Color(0xFFF06D3D);
  static const Color myBlack = Color(0xFF121619);
  static const Color mySilver = Color(0xFFC4CBCA);
  static const Color myWhite = Color(0xFFFEFEFE);

  static const Color myTeal = Color(0xFF19747E);

  static late double height;
  static late double width;

  static bool initialized = false;

  void init(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
    initialized = true;
  }
}
