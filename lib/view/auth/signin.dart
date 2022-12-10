import 'package:chat_firebase/controller/auth_controller.dart';
import 'package:chat_firebase/helper/helpers.dart';
import 'package:chat_firebase/view/auth/login.dart';
import 'package:chat_firebase/view/auth/widgets/botton.dart';
import 'package:chat_firebase/view/auth/widgets/fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<LogInController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: LogInController.formkeyRegister,
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
                  'Register Now to see what we are talking',
                ),
                Image.asset('assets/register.png'),
                FormFields(
                  hint: 'Name',
                  error: 'Enter an Email',
                  controller: controller.nameController,
                  icon: Icons.person,
                  keybord: TextInputType.name,
                ),
                FormFields(
                  hint: 'Email',
                  error: 'Enter an Email',
                  controller: controller.emailController,
                  icon: Icons.email_outlined,
                  keybord: TextInputType.name,
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
                  buttonName: 'Register',
                  onPressed: () => controller.onRegister(),
                ),
                h10,
                Text.rich(
                  TextSpan(
                    text: "Already have an account ? ",
                    children: [
                      TextSpan(
                        text: 'LogIn here',
                        style: TextStyle(color: primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => const LogInPage()),
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
    );
  }
}
