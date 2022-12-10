import 'dart:developer';
import 'package:chat_firebase/helper/helpers.dart';
import 'package:chat_firebase/services/auth_service.dart';
import 'package:chat_firebase/services/data_service.dart';
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

  onLogin() async {
    final bool? value = await AuthService.logInUser(
        emailController.text.trim(), passwordController.text.trim());
    if (value == true) {
      QuerySnapshot snapshot =
          await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .getuserData(emailController.text.trim());
      await Helpers.saveUserLoggedInStatus(true);
      await Helpers.saveUserEmail(emailController.text.trim());
      await Helpers.saveUserName(snapshot.docs[0]["fullName"]);
      Get.offAll(() => const HomeScreen());
    }
    _controllerClear();
  }

  onRegister() async {
    isLoading.value = true;
    if (formkeyRegister.currentState!.validate()) {
      final bool? value = await AuthService.registerUser(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim());
      if (value == true) {
        log(value.toString());
        await Helpers.saveUserLoggedInStatus(true);
        await Helpers.saveUserEmail(emailController.text.trim());
        await Helpers.saveUserName(nameController.text.trim());
        log('Success');
        Get.offAll(() => const HomeScreen());
      }

      _controllerClear();
      isLoading.value = false;
      update();
    }
  }

  signOut() async {
    await AuthService.signOutUser();
  }

  _controllerClear() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
