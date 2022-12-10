import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
  DataBaseService({this.uid});
  Future<void> updateuserData(String fullName, String email) async {
    await userCollection
        .doc(uid)
        .set({"fullName": fullName, "email": email, "groups": [], "uid": uid});
  }

  Future<QuerySnapshot> getuserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
