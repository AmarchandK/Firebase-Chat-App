import 'dart:developer';

import 'package:chat_firebase/helper/helpers.dart';
import 'package:chat_firebase/services/data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<bool?> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        ///////// Call database for  adding name and email ////////////
        await DataBaseService(uid: user.uid)
            .saveUserData(fullName: name, email: email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      log("error on Register --------------------------- $e ---------------------------");
      showSnack(e.message!, Colors.red);
      return false;
    }
    return null;
  }

  static Future<bool?> logInUser(
      {required String email, required String password}) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        
        return true;
      }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return false;
    }
    return null;
  }

  static Future<bool> signOutUser() async {
    try {
      await Helpers.saveUserLoggedInStatus(false);
      await firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      showSnack(e.message.toString(), Colors.red);
      return false;
    }
  }
}
