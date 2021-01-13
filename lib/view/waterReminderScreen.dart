import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:reminder_app/modal/fireBase/firebase_constants.dart';
import 'package:reminder_app/modal/screenSizing/sizeConfig.dart';
import 'package:reminder_app/modal/themes/themes.dart';

class WaterReminder extends StatefulWidget {
  @override
  _WaterReminderState createState() => _WaterReminderState();
}

class _WaterReminderState extends State<WaterReminder> {
  CountdownController countdownController =
      CountdownController(duration: Duration(minutes: 1));
  TimeOfDay selectedTime =
      TimeOfDay.fromDateTime(DateTime.now()); //(hour: 00, minute: 00);
  int reminderListLength = 0;
  bool isTableExist = false;
  FirebaseService firebaseService;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child:
                // StreamBuilder(
                //   stream: FirebaseFirestore.instance
                //       .collection("$WATER_REMINDER_COLLECTION")
                //       .snapshots(),
                //   builder: (context, snapshot) {
                //     return snapshot.hasData
                //         ?
                Column(
          children: [
            _appBar(),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.all(10),
                // padding: EdgeInsets.all(30),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * .78,
                decoration: BoxDecoration(
                    ////color: Get.isDarkMode ? Colors.purple : Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: _bodyListContainer(4)
                //(snapshot.data.docs.length, snapshot),
                )
          ],
        )
            //         : Center(
            //             child: Container(
            //               child: CircularProgressIndicator(),
            //             ),
            //           );
            //   },
            // ),
            ),
      ),
    );
  }

  _appBar() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * .09,
          decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.purple : Colors.blue,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                ),
              ),
              Text(
                "Water Reminder",
                style: titleTextStyle.copyWith(color:Get.isDarkMode ? Colors.black : Colors.white, ),
              ),
              GestureDetector(
                onTap: () => _cupertinoActionSheet(context),
                child: Row(
                  children: [
                    Text(
                      "Add",
                      style: body2TextStyle.copyWith(fontSize: 20,color:Get.isDarkMode ? Colors.black : Colors.white, ),
                    ),
                    Icon(Icons.add,color:Get.isDarkMode ? Colors.black : Colors.white, )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight/7,
          decoration: BoxDecoration(
            color: Colors.red
          ),
        )
      ],
    );
  }

  _bodyListContainer(int length) {
    //AsyncSnapshot snapshot
    return ListView.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        return SwipeActionCell(
          key: ObjectKey(index),
          trailingActions: <SwipeAction>[
            SwipeAction(
                paddingToBoundary: 20,
                forceAlignmentToBoundary: true,
                // closeOnTap: true,
                widthSpace: 90,
                backgroundRadius: 40,
                title: "Delete",
                onTap: (CompletionHandler handler) async {
                  // list.removeAt(index);
                  setState(() {});
                },
                color: Colors.red),
          ],
          child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(10),
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * .11,
            decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.grey : Colors.grey,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Drink Water",
                      style: body2TextStyle,
                    ),
                    Text(
                      "At",
                      style: body2TextStyle,
                    ),
                    Text(
                      //snapshot.data.docs[index].data()["endTime"],
                      selectedTime.toString().split("(")[1].split(")")[0],
                      style: body2TextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(""),
                    //Countdown(countdownController: countdownController)
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _cupertinoActionSheet(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              final TimeOfDay picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                  builder: (BuildContext context, Widget child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: false),
                      child: child,
                    );
                  });
              if (picked != null) {
                setState(() {
                  selectedTime = picked;
                });
                //insertFirebase(selectedTime.toString().split("(")[1].split(")")[0]);
                Get.back();
              }
            },
            child: Text("Pick Time"),
            isDefaultAction: true,
          ),
        ],
      ),
    );
  }
  // insertFirebase(String endTime)async{
  //   if(int.parse(endTime.split(":")[0])>12) {
  //     endTime = (int.parse(endTime.split(":")[0]) - 12).toString() + ":" +
  //         endTime.split(":")[1] + " PM";
  //     try {
  //       await FirebaseFirestore.instance.collection(WATER_REMINDER_COLLECTION)
  //           .doc()
  //           .set({
  //         "endTime": endTime
  //       });
  //     }
  //     catch (e) {
  //       print("ee:$e");
  //     }
  //   }
  //   else
  //   {
  //     try {
  //       await FirebaseFirestore.instance.collection(WATER_REMINDER_COLLECTION)
  //           .doc()
  //           .set({
  //         "endTime": endTime+" AM"
  //       });
  //     }
  //     catch (e) {
  //       print("ee:$e");
  //     }
  //   }
  // }
}
