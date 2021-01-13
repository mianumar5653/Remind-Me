import 'package:cloud_firestore/cloud_firestore.dart';

const String WATER_REMINDER_COLLECTION="waterReminders";
class FirebaseService{
  insertFirebase(String endTime)async{
    if(int.parse(endTime.split(":")[0])>12) {
      endTime = (int.parse(endTime.split(":")[0]) - 12).toString() + ":" +
          endTime.split(":")[1] + "PM";
      try {
        await FirebaseFirestore.instance.collection(WATER_REMINDER_COLLECTION)
            .doc()
            .set({
          "endTime": endTime
        });
      }
      catch (e) {
        print("ee:$e");
      }
    }
    else
      {
        try {
          await FirebaseFirestore.instance.collection(WATER_REMINDER_COLLECTION)
              .doc()
              .set({
            "endTime": endTime+"AM"
          });
        }
        catch (e) {
          print("ee:$e");
        }
      }
  }

}



