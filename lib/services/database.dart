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
    String semester,
    String faculty,
    String email,
    String phonenumber,
    String wechat,
    String password,
  ) async {
    return await studentCollection
      ..doc(uid).set({
        'fullName': name,
        'upmid': upmid,
        'semester': semester,
        'faculty': faculty,
        'email': email,
        'phoneNumber': phonenumber,
        'wechat': wechat,
        'password': password,
      });
  }

  //update student data
  Future updateStudentData(
    String name,
    String upmid,
    String semester,
    String faculty,
    String email,
    String phonenumber,
    String wechat,
    String password,
  ) async {
    return await studentCollection.doc(uid).update({
      'fullName': name,
      'upmid': upmid,
      'semester': semester,
      'faculty': faculty,
      'email': email,
      'phoneNumber': phonenumber,
      'wechat': wechat,
      'password': password,
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
  studentUserData _studentDataFromSnapshot(DocumentSnapshot snapshot) {
    return studentUserData(
        uid: uid,
        name: snapshot['fullName'],
        upmid: snapshot['upmid'],
        semester: snapshot['semester'],
        faculty: snapshot['faculty'],
        email: snapshot['email'],
        wechat: snapshot['wechat'],
        phoneNumber: snapshot['phoneNumber']);
  }

  // // // get brews stream
  // // Stream<List<UserDisplay>> get users {
  // //   return studentCollection.snapshots().map(_userListFromSnapshot);
  // // }

  //get user doc stream
  Stream<studentUserData> get studentsData {
    return studentCollection.doc(uid).snapshots().map(_studentDataFromSnapshot);
  }
}
