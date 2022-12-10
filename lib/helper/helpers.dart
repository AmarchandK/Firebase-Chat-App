import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helpers {
  static String userLogedInKey = '';
  static String userNameKey = '';
  static String userEmailKey = '';
  static Future<bool?> getUserStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLogedInKey);
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
