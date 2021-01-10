import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder_app/modal/homeScreen.dart';
import 'package:reminder_app/modal/widget/allWidgets.dart';
import 'package:reminder_app/modal/widget/sizeConfig.dart';
import 'package:reminder_app/themes.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  String dateOfBirth = DateTime.now().toString().split(" ")[0];
  final nameController = new TextEditingController();
  GetStorage themeValue=GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _timeController.text = formatDate(
    //     DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
    //     [hh, ':', nn, " ", am]).toString();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? darkGreyColor : context.theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100)),
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * .4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/splashScreen/splash.jpg"),
                          fit: BoxFit.cover)),
                ),
              ),
              text("WELCOME TO WATER", headingTextStyle),
              SizedBox(
                height: 5,
              ),
              text("REMAINDER APP", headingTextStyle),
              textField("Enter your name", context, true, nameController),
              button(dateOfBirth, ()async{
                // _timeSelected();
                _dateSelected();
              }, context,headingTextStyle),
              button("NEXT", () {
                print(nameController);
                print(dateOfBirth);
                if (nameController.text==null) {
                  print(themeValue.read("themeValue"));
                  Get.snackbar("Error", "Name is necessary",colorText: primaryColor);
                }
                else
                  {
                    Get.off(HomeScreen(
                      name: nameController.text,
                      dob: dateOfBirth,
                    ));
                  }
              }, context,headingTextStyle)
            ],
          ),
        ),
      ),
    );
  }
  _dateSelected(){
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 12, 31),
        maxTime: DateTime(2050, 12, 31), onChanged: (date) {
          setState(() {
            dateOfBirth = date.toString().split(" ")[0];
            return date.toString().split(" ")[0];
          });
          print('change ${date.toString().split(" ")[0]}');
        }, onConfirm: (date) {
          print('confirm $date');
          setState(() {
            dateOfBirth = date.toString().split(" ")[0];
            return date.toString().split(" ")[0];
          });
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}

// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// ],
// ),
