import 'dart:developer';
import 'package:chat_firebase/helper/helpers.dart';
import 'package:chat_firebase/services/auth_service.dart';
import 'package:chat_firebase/services/data_service.dart';
import 'package:chat_firebase/view/auth/login.dart';
import 'package:chat_firebase/view/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  static GlobalKey<FormState> formkeyLogin = GlobalKey<FormState>();
  static GlobalKey<FormState> formkeyRegister = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  void onLogin() async {
    isLoading.value = true;
    final bool? value = await AuthService.logInUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    if (value == true && value != null) {
      QuerySnapshot snapshot =
          await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .getuserData(emailController.text.trim());
      await Helpers.saveUserLoggedInStatus(true);
      await Helpers.saveUserEmail(emailController.text.trim());
      await Helpers.saveUserName(snapshot.docs[0]["fullName"]);
      Get.offAll(() => HomeScreen());
      update();
    } else {
      Get.snackbar("Error", value.toString());
      log(value.toString());
    }
    isLoading.value = false;
    update();
    _controllerClear();
  }

  void onRegister() async {
    isLoading.value = true;
    if (formkeyRegister.currentState!.validate()) {
      final bool? value = await AuthService.registerUser(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (value == true && value != null) {
        ////////////// Add to SF ////////////////
        await Helpers.saveUserLoggedInStatus(true);
        await Helpers.saveUserEmail(emailController.text.trim());
        await Helpers.saveUserName(nameController.text.trim());
        log('Success');
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar("Error", value.toString(),
            backgroundColor: primaryColor.withOpacity(0.5));
        log(value.toString());
      }

      _controllerClear();
      isLoading.value = false;
      update();
    }
  }

  void signOut() async {
    await AuthService.signOutUser().then((value) => value
        ? Get.offAll(() => const LogInPage())
        : Get.snackbar("Error", 'SignOut Failed'));
  }

  void _controllerClear() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
