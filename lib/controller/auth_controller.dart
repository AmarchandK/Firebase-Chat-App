import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  static GlobalKey<FormState> formkeyLogin = GlobalKey();
  static GlobalKey<FormState> formkeyRegister = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  onLogin() {
    if (formkeyLogin.currentState!.validate()) {}
  }

  onRegister() {
    if (formkeyRegister.currentState!.validate()) {
      _controllerClear();
    }
  }

  _controllerClear() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
