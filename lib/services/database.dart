import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SSE3151_project/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // final user = FirebaseAuth.instance.currentUser!;
  // final uid = FirebaseAuth.instance.currentUser!.uid;
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String upmid, int phonenumber) async {
    return await userCollection.doc(uid).set({
      'fullName': name,
      // 'email': email,
      'upmid': upmid,
      'phoneNumber': phonenumber,
    });
  }

  Future updateUserGData(String name) async {
    return await userCollection.doc(uid).set({
      'fullName': name,
    });
  }

  // brew list from snapshot
  List<UserDisplay> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserDisplay(
          name: doc.get('fullName') ?? "0",
          upmid: doc.get('upmid') ?? "0",
          email: doc.get('email') ?? "0",
          phoneNumber: doc.get('phoneNumber') ?? "0");
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['fullName'],
        upmid: snapshot['upmid'],
        email: snapshot['email'],
        phoneNumber: snapshot['phoneNumber']);
  }

  // get brews stream
  Stream<List<UserDisplay>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
