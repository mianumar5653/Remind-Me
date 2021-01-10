import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:reminder_app/modal/waterReminderScreen.dart';
import 'package:reminder_app/theme_services.dart';
import 'package:reminder_app/themes.dart';
bool USE_FIRESTORE_EMULATOR = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home:WaterReminder(),//HomeScreen(name: "Umar Arshad",dob: "20/12/2000",),//WaterReminder()
      //SplashScreen(boxBackgroundColor: WHITE_COLORS,text: "WATER IS LIFE",)
    );
  }

}

