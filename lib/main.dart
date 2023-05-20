import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:test_project/app/modules/home/controllers/selection_doctor_or_sick_controller.dart';
import 'package:test_project/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

bool? tokenValueDoctor;
bool? tokenValuePatients;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  valueOfSelection = GetStorage().read("valueOfSelection");
  if (valueOfSelection == false) {
    tokenOfDoctors = GetStorage().read("token");
    if (tokenOfDoctors != null) {
      tokenValueDoctor = true;
      print(tokenOfDoctors);
    } else {
      tokenValueDoctor = false;
    }
  }
  if (valueOfSelection == true) {
    tokenOfPatients = GetStorage().read("tokenOfPatients");
    if (tokenOfPatients != null) {
      tokenValuePatients = true;
      print(tokenOfDoctors);
    } else {
      tokenValuePatients = false;
    }
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // Spanish
      ],
      title: "Application",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0Xffffffff),
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedLabelStyle: TextStyle(
            color: Colors.green,
          ))),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
