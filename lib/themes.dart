import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/modal/widget/sizeConfig.dart';
Color darkGreyColor=Colors.grey[900];
Color lightGreyColor=Colors.grey[100];
const Color primaryColor=Colors.blueAccent;
const Color WHITE_COLORS=Colors.white;
const Color BLACK_COLORS=Colors.black;
const Color TEXT_FIELD_BG_COLOR=Colors.grey;
const double radius=30;
class Themes {
  static final light = ThemeData(
      backgroundColor: Colors.grey[100],
      primaryColor: primaryColor,
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline5: TextStyle(),
      ),
      fontFamily: "Poppins");
  static final dark = ThemeData(
      backgroundColor: darkGreyColor,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      fontFamily: "Poppins");
}

TextStyle get headingTextStyle {
  return TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: Get.isDarkMode ? Colors.white : darkGreyColor);
}

TextStyle get subHeadingTextStyle {
  return TextStyle(
      fontSize: getProportionateScreenHeight(25),
      fontWeight: FontWeight.w800,
      color: Get.isDarkMode ? Colors.white : darkGreyColor);
}

TextStyle get titleTextStyle {
  return TextStyle(
      fontSize: getProportionateScreenHeight(20),
      fontWeight: FontWeight.w600,
      color: Get.isDarkMode ? Colors.white : darkGreyColor);
}

TextStyle get body2TextStyle {
  return TextStyle(
      fontSize: getProportionateScreenHeight(16),
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[200] : Colors.black);
}