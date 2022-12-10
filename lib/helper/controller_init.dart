import 'package:chat_firebase/controller/auth_controller.dart';
import 'package:chat_firebase/controller/splash_controller.dart';
import 'package:get/get.dart';

controllerInit() {
  Get.put(LogInController());
  Get.put(SplashController());
}
