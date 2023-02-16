import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helpers {
  static const String userLogedInKey = 'LOGEDINKEY';
  static const String userNameKey = 'USERNAMEKEY';
  static const String userEmailKey = 'USEREMAILKEY';
  static Future<bool?> getUserStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLogedInKey);
  }

  static Future<bool> saveUserLoggedInStatus(bool isLogedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLogedInKey, isLogedIn);
  }

  static Future<bool> saveUserEmail(String email) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, email);
  }

  static Future<bool> saveUserName(String name) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, name);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }
}

const SizedBox h10 = SizedBox(height: 10);
const SizedBox h20 = SizedBox(height: 20);
const SizedBox h30 = SizedBox(height: 30);
const SizedBox w10 = SizedBox(width: 10);
const SizedBox w20 = SizedBox(width: 20);
const Color bColor = Colors.black;
const Color wColor = Colors.white;
final Color primaryColor = Colors.orangeAccent[700]!;
void showSnack(String msg, Color color) {
  Get.snackbar(msg, '', borderColor: color);
}
