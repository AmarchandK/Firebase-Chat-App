import 'dart:developer';

import 'package:chat_firebase/helper/helpers.dart';
import 'package:chat_firebase/services/auth_service.dart';
import 'package:chat_firebase/services/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final String? userName;
  late final String? userEmail;
  Stream? streamGroupData;
  final DataBaseService dataBaseService =
      DataBaseService(uid: AuthService.firebaseAuth.currentUser!.uid);
  final GlobalKey<FormState> groupNameKey = GlobalKey<FormState>();
  final TextEditingController groupNameController = TextEditingController();
  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }

  void getUserDetails() async {
    // USER AUTH DETAILS//
    userName = await Helpers.getUserName();
    userEmail = await Helpers.getUserEmail();

    /// USER GROUP DETAILS Fetch ///
    dataBaseService.getUserGroups().then((value) {
      streamGroupData = value;
    });
    update();
  }

  void createGroup() {
    if (groupNameKey.currentState!.validate()) {
      Get.back();
      dataBaseService.createGroup(
          groupName: groupNameController.text.trim(),
          id: AuthService.firebaseAuth.currentUser!.uid,
          userName: userName ?? "");
      log("group created Sccessfully");
      groupNameController.clear();
    }
    update();
  }
}
