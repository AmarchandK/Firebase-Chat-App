import 'package:chat_firebase/controller/splash_controller.dart';
import 'package:chat_firebase/view/auth/login.dart';
import 'package:chat_firebase/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () =>
          controller.isSignedIn.value ?  HomeScreen() : const LogInPage(),
    ));
  }
}
