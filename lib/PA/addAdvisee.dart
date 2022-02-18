// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addAdvisee extends StatefulWidget {
  @override
  State<addAdvisee> createState() => _addAdviseeState();
}

class _addAdviseeState extends State<addAdvisee> {
  final user = FirebaseAuth.instance.currentUser;
  String? upmID;
  // String? upmIDA;
  // String? facultyStudent;
  // String? student;
  bool successTVisibility = false;
  bool errorTVisibility = false;
  // bool avTVisibility = false;
  bool _validate = false;
  // List<String> students = [];

  // final CollectionReference PAInfo =
  //     FirebaseFirestore.instance.collection('PA');
  final CollectionReference studentInfo =
      FirebaseFirestore.instance.collection('students');

  // Future setPAValue() async {
  //   final PAData =
  //       await FirebaseFirestore.instance.collection('PA').doc(user?.uid).get();

  //   if (mounted) {
  //     setState(() {
  //       facultyPA = PAData.data()!['faculty'];
  //     });
  //   }
  // }
  // Stream<QuerySnapshot> get studentData {
  //   return studentInfo.snapshots();
  // }

  // getData() async {
  //   final PAData =
  //       await FirebaseFirestore.instance.collection('PA').doc(user?.uid).get();
  //   final studentData = await FirebaseFirestore.instance
  //       .collection('student')
  //       .doc(user?.uid)
  //       .get();
  //   if (PAData.data()!['faculty'] == studentData.data()!['faculty']) {
  //     return PAData.data()!['fullName'];
  //   } else {
  //     return null;
  //   }
  // }

  final MIDCtrl = TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    // final db = FirebaseFirestore.instance
    //     .collection('Advisee_Advisor')
    //     .doc(user?.uid)
    //     .collection('student');

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Text(
                'Add Advisee',
                style: TextStyle(
                    color: Colors.indigo,
                    //Color(0xFFFFC107),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              // Container(
              //   alignment: Alignment.center,
              //   margin: EdgeInsets.symmetric(horizontal: 40),
              //   child: DropdownButtonFormField(
              //       isExpanded: true,
              //       decoration: InputDecoration(
              //         labelText: "List of Students",
              //         labelStyle: TextStyle(color: Colors.black),
              //       ),
              //       value: _advisee,
              //       items: snapshot.map((dep) {
              //         return DropdownMenuItem(
              //           value: dep,
              //           child: Text(dep),
              //         );
              //       }).toList(),
              //       onChanged: (value) {
              //         if (facultyPA ==
              //             studentInfo
              //                 .where('faculty', isEqualTo: facultyPA)
              //                 .get()) {
              //           students == studentInfo.get();
              //         }
              //         setState(() => _advisee = value.toString());
              //       }),
              // ),
              SizedBox(height: 20),
              Container(
                child: TextField(
                  controller: MIDCtrl,
                  decoration: InputDecoration(
                    hintText: 'Enter UPM-ID ',
                    errorText: _validate ? 'This field cannot be empty' : null,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.9)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(
                        colors: [Color(0xFF4322FF), Color(0xFF295BFF)])),
                child: IconButton(
                  icon: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    upmID = MIDCtrl.text;
                    setState(() {
                      upmID!.isEmpty ? _validate = true : _validate = false;
                    });
                    if (_validate == false) {
                      QuerySnapshot upmID_Stream = await studentInfo
                          .where('upmid', isEqualTo: upmID)
                          .get();
                      // QuerySnapshot upmIDA_Stream = await studentInfo
                      //     .where('upmid', isEqualTo: upmID)
                      //     .get();

                      List<QueryDocumentSnapshot> upmID_StreamList =
                          upmID_Stream.docs;
                      String upm_id = upmID_StreamList.first.get('upmid');
                      String cohort = upmID_StreamList.first.get('cohort');
                      String role = upmID_StreamList.first.get('role');
                      String fullName = upmID_StreamList.first.get('fullName');
                      String image = upmID_StreamList.first.get('image');
                      String faculty = upmID_StreamList.first.get('faculty');
                      String dept = upmID_StreamList.first.get('department');
                      String semester = upmID_StreamList.first.get('semester');
                      String email = upmID_StreamList.first.get('email');
                      String wechat = upmID_StreamList.first.get('wechat');
                      String phoneNumber =
                          upmID_StreamList.first.get('phoneNumber');
                      // Future setAAValue() async {
                      //   final AAData = FirebaseFirestore.instance
                      //       .collection('Advisee_Advisor')
                      //       .doc(user?.uid)
                      //       .collection('student')
                      //       .snapshots();
                      //   List<QueryDocumentSnapshot<Object?>> data =
                      //       snapshot.data!.docs;
                      //   // upmIDA = data.first.get('upmid');
                      //   return upmIDA = data.first.get('upmid');
                      // }

                      if (upmID_Stream != null
                          //  && setAAValue() != upmID
                          // &&
                          //     // upmID!.isNotEmpty &&
                          //     // upmID == upmID_Stream &&
                          //     (getName(upmID as String) != upmID_Stream)
                          ) {
                        // print('$db.doc($upmID)');
                        // print('.........................');

                        setState(() {
                          regAdvisee(
                              upm_id,
                              cohort,
                              role,
                              fullName,
                              image,
                              semester,
                              faculty,
                              dept,
                              email,
                              wechat,
                              phoneNumber);
                          successTVisibility = true;
                        });
                        await Future.delayed(Duration(milliseconds: 500));
                        Navigator.pop(context);
                        //snapshots().toString()
                        //doc(user?.uid).get().d
                      }
                      // else if (upmID_Stream ==
                      //     db.doc(upmID).collection('upmid').get()) {
                      //   setState(() {
                      //     avTVisibility = true;
                      //   });
                      // }
                      else {
                        setState(() {
                          errorTVisibility = true;
                        });
                        await Future.delayed(Duration(milliseconds: 750));
                        Navigator.pop(context);
                        // await Future.delayed(Duration(milliseconds: 700));
                        // MIDCtrl.clear();

                        // await Future.delayed(Duration(milliseconds: 650));
                        // setState(() {
                        //   errorTVisibility = false;
                        // });
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 14),
              Visibility(
                  visible: successTVisibility,
                  child: Text(
                    'Successfully Added!',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  )),
              Visibility(
                  visible: errorTVisibility,
                  child: Text(
                    'Invalid UPM-ID',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  )),
              // Visibility(
              //     visible: avTVisibility,
              //     child: Text(
              //       'UPM-ID Already Exists',
              //       style: TextStyle(
              //           color: Colors.black, fontWeight: FontWeight.w400),
              //     )),
              // // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       primary: Colors.red,
              //       minimumSize: Size(150, 32),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(18))),
              //   child: Text('Confirm'),
              //   onPressed: () async {
              //     upmID = MIDCtrl.text;

              //     QuerySnapshot matricStream =
              //         await studentInfo.where('upmid', isEqualTo: upmID).get();

              //     if (matricStream != null) {
              //       List<QueryDocumentSnapshot> matricStreamList =
              //           matricStream.docs;
              //       String upm_id = matricStreamList.first.get('upmid');
              //       String fullName = matricStreamList.first.get('fullName');

              //       regAdvisee(upm_id, fullName);
              //     } else {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(content: Text('Invalid Matric no.')));
              //     }
              //   },
              // )
            ],
          );
        });
    // Scaffold(
    //   appBar: AppBar(
    //     title: Text('Add Advisee'),
    //     centerTitle: true,
    //     backgroundColor: Colors.indigo,
    //   ),
    //   body: Background2(
    //     child: Container(

    //     ),
    //   ),
    // );
  }

  Future regAdvisee(
    String upmID,
    String cohort,
    String role,
    String name,
    String image,
    String semester,
    String faculty,
    String dept,
    String email,
    String wechat,
    String phoneNumber,
  ) async {
    await FirebaseFirestore.instance
        .collection("Advisee_Advisor")
        .doc(user?.uid)
        .collection('students')
        .doc(upmID)
        .set({
      'upmid': upmID,
      'cohort': cohort,
      'role': role,
      'fullName': name,
      'image': image,
      'semester': semester,
      'faculty': faculty,
      'department': dept,
      'email': email,
      'wechat': wechat,
      'phoneNumber': phoneNumber,
    });
  }

  // Future getName(String upmid) async {
  //   final studID = await FirebaseFirestore.instance
  //       .collection("Advisee_Advisor")
  //       .doc(user?.uid)
  //       .collection('student')
  //       .doc(upmid)
  //       .get();
  //   upmid = studID.data()!['upmid'];
  //   print(upmid);
  //   return upmid;
  // }

  // getDatas() async {
  //   final PAData =
  //       await FirebaseFirestore.instance.collection('PA').doc(user?.uid).get();
  //   final studentData = await FirebaseFirestore.instance
  //       .collection('student')
  //       .doc(user?.uid)
  //       .get();
  //   if (PAData.data()!['faculty'] == studentData.data()!['faculty']) {
  //     return PAData.data()!['fullName'];
  //   } else {
  //     return null;
  //   }
  // }
}
