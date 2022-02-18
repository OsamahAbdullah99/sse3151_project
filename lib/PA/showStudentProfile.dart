import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class showStudentsProfile extends StatefulWidget {
  final String upmid;
  const showStudentsProfile({Key? key, required this.upmid}) : super(key: key);

  @override
  _showStudentsProfileState createState() => _showStudentsProfileState();
}

final user = FirebaseAuth.instance.currentUser;

class _showStudentsProfileState extends State<showStudentsProfile> {
  final db = FirebaseFirestore.instance
      .collection('Advisee_Advisor')
      .doc(user?.uid)
      .collection('students')
      .doc(upmid);
  final CollectionReference studentInfo =
      FirebaseFirestore.instance.collection('students');

  static String? get upmid => null;

  getProfile() {
    db.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Profile",
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigoAccent, Colors.blue.shade200, Colors.white],
              // stops: [0.2, 0.8, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        alignment: Alignment.center,

        //  StreamBuilder<QuerySnapshot>(
        //     stream: db.snapshots(),
        //     builder: (context, snapshot) {
        //       final profile = snapshot.data!.docs;

        //       if (!snapshot.hasData) {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       } else {
        //         return ListView(
        //           children: snapshot.data!.docs.map((doc) {
        //             return Card(
        //               child: Column(
        //                 children: [
        //                   Text(doc.get('upmid')),
        //                 ],
        //               ),
        //             );
        //           }).toList(),
        //         );
        //       }
        //     })
      ),
    );
  }
}
