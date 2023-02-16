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
        "groupIcon": "",
        "admin": "${id}_$userName",
        "members": [],
        "grpupId": "",
        "resentMessage": "",
        "resentMessageCentre": ""
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"]),
        "grpupId": groupDocumentReference.id
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
}
