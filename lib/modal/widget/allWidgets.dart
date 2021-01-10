import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reminder_app/modal/widget/sizeConfig.dart';
import 'package:reminder_app/themes.dart';
import 'package:get/get.dart';
Widget text(String text, TextStyle style) {
  return Text("$text", style: style);
}
// button widget
Widget button(String text, Function onTap, BuildContext context,TextStyle style) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.screenHeight*.09,
        width:SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Get.isDarkMode?darkGreyColor:context.theme.backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: TEXT_FIELD_BG_COLOR.withOpacity(0.7))),
        child: Text(
          "$text",
          style: style,
        ),
      ),
    ),
  );
}

//TextField
Widget textField(
    String hintText, BuildContext context, bool enable,TextEditingController controller) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
    child: TextFormField(
      controller: controller,
      enabled: enable,
      cursorColor:  Get.isDarkMode?WHITE_COLORS:darkGreyColor,
      style: TextStyle(color: Get.isDarkMode?WHITE_COLORS:darkGreyColor),
      // obscureText: hintText=="Password" || hintText=="Confirm Password"?true:false,
      decoration: InputDecoration(
        labelText: "$hintText",
        labelStyle: TextStyle(color: Get.isDarkMode?WHITE_COLORS:darkGreyColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(color: Get.isDarkMode?WHITE_COLORS:TEXT_FIELD_BG_COLOR),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Get.isDarkMode?WHITE_COLORS:TEXT_FIELD_BG_COLOR.withOpacity(0.7)),
        ),
      ),
    ),
  );
}
