import 'dart:developer';
import 'package:chat_firebase/helper/helpers.dart';
import 'package:chat_firebase/services/auth_service.dart';
import 'package:chat_firebase/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  String? userName;
  String? userEmail;
  Stream<QuerySnapshot>? chats;
  String? admin;
  Stream? members;
  bool userSearchAlready = false;
  QuerySnapshot? searchSnapshot;
  RxBool userSearching = false.obs;
  List<bool> userIsInGroup = [];
  TextEditingController messageController = TextEditingController();

  Stream? streamGroupData;
  final DataBaseService dataBaseService =
      DataBaseService(uid: AuthService.firebaseAuth.currentUser?.uid);
  final GlobalKey<FormState> groupNameKey = GlobalKey<FormState>();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    AuthService.firebaseAuth.currentUser != null ? getUserDetails() : '';
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

  String getGroupId(String value) => value.split("_").first;
  String getGroupName(String value) => value.split("_")[1].toUpperCase();

  void getChatAndAdmin({required String groupId}) {
    dataBaseService.getChats(groupId).then((value) => chats = value);
    dataBaseService.getAdmin(groupId).then((value) => admin = value);
  }

  void getGroupMembers(String groupId) {
    dataBaseService.getGroupMembers(groupId).then((value) => members = value);
  }

  void searchGroup() async {
    if (searchController.text.isNotEmpty) {
      userIsInGroup = [];
      userSearchAlready = false;
      userSearching.value = true;
      await dataBaseService
          .searchByName(searchController.text.trim())
          .then((value) {
        searchSnapshot = value;
      });
      if (searchSnapshot != null) {
        for (var item in searchSnapshot!.docs) {
          bool isUserInGroup =
              await checkUserInGroup(item["groupName"], item["groupId"]);
          userIsInGroup.add(isUserInGroup);
        }
      }
      userSearching.value = false;
      userSearchAlready = true;
    }
  }

  Future<bool> checkUserInGroup(String groupName, String groupId) async {
    bool isUserInGroup =
        await dataBaseService.checkUserInGroup(groupId, groupName, userName);
    // if username is null take from Shared Preference

    return isUserInGroup;
  }

  void exitGroup({required String groupId, required String groupName}) async {
    await dataBaseService.toggleGroupJoin(groupId, groupName, userName!);
    update();
  }

  void sendMessage(String groupId) {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      dataBaseService.sendMessage(groupId, chatMessageMap);
      messageController.clear();
      update();
    }
  }
}
