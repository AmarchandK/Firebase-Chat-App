import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Future registerUser(String name, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }
}
