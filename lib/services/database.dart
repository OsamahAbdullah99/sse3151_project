import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SSE3151_project/student_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // final user = FirebaseAuth.instance.currentUser!;
  // final uid = FirebaseAuth.instance.currentUser!.uid;
  final String uid;
  DatabaseService({required this.uid});

  //for students data collection
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('students');
//kiv
  Future studentData(
    String name,
    String upmid,
    String email,
    int phonenumber,
    String password,
  ) async {
    return await studentCollection
      ..doc(uid).set({
        'fullName': name,
        'upmid': upmid,
        'email': email,
        'phoneNumber': phonenumber,
        'password': password,
      });
  }

  //update student data
  Future updateStudentData(
    String name,
    String upmid,
    String email,
    int phonenumber,
  ) async {
    return await studentCollection.doc(uid).update({
      'fullName': name,
      'upmid': upmid,
      'email': email,
      'phoneNumber': phonenumber,
    });
  }

  // // brew list from snapshot
  // List<UserDisplay> _userListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return UserDisplay(
  //         name: doc.get('fullName') ?? "0",
  //         upmid: doc.get('upmid') ?? "0",
  //         email: doc.get('email') ?? "0",
  //         phoneNumber: doc.get('phoneNumber') ?? "0");
  //   }).toList();
  // }

  // userData from snapshot
  // studentUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return studentUserData(
  //       uid: uid,
  //       name: snapshot['fullName'],
  //       upmid: snapshot['upmid'],
  //       email: snapshot['email'],
  //       phoneNumber: snapshot['phoneNumber']);
  // }

  // // // get brews stream
  // // Stream<List<UserDisplay>> get users {
  // //   return studentCollection.snapshots().map(_userListFromSnapshot);
  // // }

  // //get user doc stream
  // Stream<studentUserData> get userData {
  //   return studentCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  // }
}
