import 'package:chat_firebase/controller/auth_controller.dart';
import 'package:chat_firebase/helper/helpers.dart';
import 'package:chat_firebase/view/auth/signin.dart';
import 'package:chat_firebase/view/auth/widgets/botton.dart';
import 'package:chat_firebase/view/auth/widgets/fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInPage extends GetView<LogInController> {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: LogInController.formkeyLogin,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Groupie',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  h10,
                  const Text(
                    'LogIn Now to see what we are talking',
                  ),
                  Image.asset('assets/login.png'),
                  FormFields(
                    hint: 'Email',
                    error: 'Enter an Email',
                    controller: controller.emailController,
                    icon: Icons.email_outlined,
                    keybord: TextInputType.emailAddress,
                  ),
                  FormFields(
                    hint: 'Password',
                    error: 'Enter a Password',
                    controller: controller.passwordController,
                    icon: Icons.lock,
                    keybord: TextInputType.number,
                  ),
                  h10,
                  OnTapButton(
                    buttonName: 'LogIn',
                    onPressed: () => controller.onLogin(),
                  ),
                  h10,
                  Text.rich(
                    TextSpan(
                      text: "Dont't have an account ? ",
                      children: [
                        TextSpan(
                          text: 'Register here',
                          style: TextStyle(color: primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => const RegisterPage()),
                        ),
                      ],
                    ),
                  ),
                  h20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
