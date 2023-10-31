import 'package:chat_firebase/helper/constants.dart';
import 'package:chat_firebase/helper/controller_init.dart';
import 'package:chat_firebase/helper/helpers.dart';
import 'package:chat_firebase/view/splash/splsh_sceen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: Constant.apiKey,
            appId: Constant.appId,
            messagingSenderId: Constant.messagingSenderId,
            projectId: Constant.projectId));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: controllerInit,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: primaryColor)),
      home: const SplashScreen(),
    );
  }
}
