import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:reminder_app/view/walkThroughScreen/walkThroughScreen.dart';
import 'package:reminder_app/viewModal/allWidgets.dart';
import 'package:reminder_app/modal/screenSizing//sizeConfig.dart';
import 'package:reminder_app/modal/themes/theme_services.dart';
import 'package:reminder_app/modal/themes/themes.dart';

class HomeScreen extends StatefulWidget {
  String name;
  String dob;
  HomeScreen({this.dob, this.name});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = 'One';
  bool isExpanded = false;
  bool isVisible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String name;
  String dob;
  String dateOfBirth = DateTime.now().toString().split(" ")[0];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: AnimatedContainer(
                      alignment: Alignment.bottomCenter,
                      width: SizeConfig.screenWidth,
                      height: isExpanded ? 470 : SizeConfig.screenHeight * 0.5,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode ? primaryColor : Colors.blue[800],
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(radius),
                            bottomLeft: Radius.circular(radius)),
                      ),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      child: Column(
                        children: [
                          AnimatedContainer(
                            width: SizeConfig.screenWidth,
                            height:
                                isExpanded ? 380 : SizeConfig.screenHeight * 0.4,
                            decoration: BoxDecoration(
                              color:
                                  Get.isDarkMode ? darkGreyColor : WHITE_COLORS,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(radius),
                                  bottomLeft: Radius.circular(radius)),
                            ),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            child: Column(
                              children: [
                                appBar(),
                                profileTheme(
                                    widget.name,widget.dob)
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isVisible ? true : false,
                            child: Padding(
                              padding: const EdgeInsets.only(left:40.0,right: 40.0),
                              child: button("SAVE", () {
                                setState(() {
                                  widget.name = nameController.text;
                                  widget.dob = dateOfBirth;
                                  isExpanded = !isExpanded;
                                  isVisible=!isVisible;
                                });
                              }, context,headingTextStyle.copyWith(fontSize: 20)),
                            ),
                          )
                        ],
                      )),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    width: SizeConfig.screenWidth * .9,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? darkGreyColor : WHITE_COLORS,
                      borderRadius: BorderRadius.circular(radius),
                      // border: Border.all(color: Get.isDarkMode?WHITE_COLORS:darkGreyColor)
                    ),
                    child: bodyMainContainer())
              ],
            ),
          )),
    );
  }

  //divider
  Widget divider(double horizental, double verticle, Color color) {
    return Container(
      height: verticle,
      width: horizental,
      color: color,
    );
  }

  //SIZEBOX
  Widget sizeBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: IconButton(
                  onPressed: () => ThemeService().switchTheme(),
                  icon: Icon(
                    Get.isDarkMode
                        ? FlutterIcons.sun_fea
                        : FlutterIcons.moon_fea,
                    color: Get.isDarkMode ? Colors.white : darkGreyColor,
                  ),
                ),
              ),
              DropdownButton<String>(
                // value: dropdownValue,
                icon: Icon(Icons.more_vert_outlined),
                iconSize: 24,
                elevation: 16,
                // style: TextStyle(color: WHITE_COLORS),
                underline: Container(
                  height: 0,
                  color: WHITE_COLORS,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Edit Profile', 'Setting', 'Logout']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    onTap: () {
                      print(value);
                      switch (value) {
                        case "Edit Profile":
                          {
                            // Get.to(ViewProfile());
                            break;
                          }
                        case "Setting":
                          {
                            // Get.to(ViewProfile());
                            break;
                          }
                        case "Logout":
                          {
                            Get.to(WalkThroughScreen());
                            break;
                          }
                      }
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget profileTheme(String name,String dob) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth*.34,vertical:  SizeConfig.screenWidth*.2,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/homeScreen/home.jpg"),
                child: CircleAvatar(
                    radius: 60,
                    backgroundColor: isExpanded
                        ? Colors.grey.withOpacity(0.7)
                        : Colors.grey.withOpacity(0),
                    child: Text(
                      isExpanded ? "Edit" : "",
                      style: body2TextStyle.copyWith(
                          fontSize: getProportionateScreenHeight(24),
                          fontWeight: FontWeight.bold),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                    Future.delayed(Duration(milliseconds: 500),(){
                     setState(() {
                       isVisible=!isVisible;
                     });
                    });
                  });
                },
                child: CircleAvatar(
                  radius: isExpanded ? 0 : 15,
                  backgroundColor: Get.isDarkMode ? WHITE_COLORS : BLACK_COLORS,
                  child: Icon(
                    isExpanded ? Icons.edit : Icons.edit,
                    size: isExpanded ? 0 : 20,
                    color: Get.isDarkMode ? BLACK_COLORS : WHITE_COLORS,
                  ),
                ),
              ),
            ],
          ),
          // sizeBox(10),
          Visibility(
            visible: isVisible ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(left:40.0,right: 40.0),
              child: textField(
                  "$name", context, isExpanded ? true : false, nameController),
            ),
          ),
          Visibility(
            visible: isVisible ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(left:40.0,right: 40),
              child: button(dateOfBirth, () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1900, 12, 31),
                    maxTime: DateTime(2050, 12, 31), onChanged: (date) {
                  setState(() {
                    dateOfBirth = date.toString().split(" ")[0];
                  });
                  print('change ${date.toString().split(" ")[0]}');
                }, onConfirm: (date) {
                  print('confirm $date');
                  setState(() {
                    dateOfBirth = date.toString().split(" ")[0];
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              }, context,headingTextStyle.copyWith(fontSize: 20)),
            ),
          ),
          Visibility(visible:isVisible ?false:true,child: text("$name", subHeadingTextStyle)),
          sizeBox(5),
          Visibility(visible:isVisible ?false:true,child: text("$dob", body2TextStyle))
        ],
      ),
    );
  }

  Widget bodyMainContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            bodyContainer("Water Reminder", Icons.alarm),
            divider(
              getProportionateScreenWidth(2),
              getProportionateScreenHeight(90),
              Get.isDarkMode ? WHITE_COLORS : BLACK_COLORS,
            ),
            bodyContainer("Alarms", Ionicons.ios_alarm)
          ],
        ),
        divider(
          getProportionateScreenWidth(200),
          getProportionateScreenHeight(2),
          Get.isDarkMode ? WHITE_COLORS : BLACK_COLORS,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            bodyContainer("Reminders", FontAwesome5Solid.calendar_alt),
            divider(
              getProportionateScreenWidth(2),
              getProportionateScreenHeight(90),
              Get.isDarkMode ? WHITE_COLORS : BLACK_COLORS,
            ),
            bodyContainer("Prayers", FontAwesome.clock_o)
          ],
        )
      ],
    );
  }

  Widget bodyContainer(String text, IconData icon) {
    return Container(
        alignment: Alignment.center,
        width: getProportionateScreenWidth(120),
        height: getProportionateScreenHeight(120),
        decoration: BoxDecoration(
          // color: color,
          borderRadius: BorderRadius.circular(radius),
          // border: Border.all(color: Get.isDarkMode?WHITE_COLORS:darkGreyColor)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$text",
              style: titleTextStyle,
            ),
            sizeBox(10),
            Icon(
              icon,
              color: Get.isDarkMode ? WHITE_COLORS : Colors.grey[700],
            )
          ],
        ));
  }
}
