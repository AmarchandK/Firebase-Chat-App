import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  DataBaseService({this.uid});
  final String? uid;

  //////// Reference for  Collection  ////////////////
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
///////////////// Update Userdata /////////////////////
  Future<void> saveUserData(
      {required String fullName, required String email}) async {
    await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "ProfilePic": [],
      "uid": uid
    });
  }

  Future<QuerySnapshot> getuserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  ////////  Get Stream Data  of Groups of User /////////////////
  Future<Stream<DocumentSnapshot<Object?>>> getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  Future<void> createGroup(
      {required String groupName,
      required String id,
      required String userName}) async {
    try {
      DocumentReference groupDocumentReference = await groupCollection.add({
        "groupName": groupName,
        "groupIcon": "  ",
        "admin": "${id}_$userName",
        "members": [],
        "groupId": "",
        "recentMessage": "",
        "recentMessageSender": ""
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"]),
        "groupId": groupDocumentReference.id
      });
      DocumentReference userDocumentReference = userCollection.doc(uid);
      return userDocumentReference.update({
        "groups":
            FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
      });
    } catch (e) {
      log("error on group creating =====$e");
    }
  }

  ///// getting the chat //////
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getChats(
      String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  ////// getting admin ////////
  Future<String> getAdmin(String groupId) async {
    DocumentReference reference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await reference.get();
    return documentSnapshot["admin"];
  }

  ////// Get Group Members /////
  Future<Stream<DocumentSnapshot<Object?>>> getGroupMembers(
      String groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  //// Search ///////
  Future<QuerySnapshot<Object?>> searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  Future<bool> checkUserInGroup(
      String groupId, String groupName, String? userName) async {
    DocumentReference userReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userReference.get();
    // DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    List groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  Future toggleGroupJoin(
      String groupId, String groupName, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List result = await documentSnapshot['groups'];
    if (result.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  void sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }
}
