import 'dart:io';

import 'package:SSE3151_project/student/reports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import './DashboardStudent.dart';
import './new_post.dart';

class NewReport extends StatefulWidget {
  const NewReport({Key? key}) : super(key: key);

  @override
  _NewReportState createState() => _NewReportState();
}

class _NewReportState extends State<NewReport> {
  final user = FirebaseAuth.instance.currentUser;
  // final db = FirebaseFirestore.instance
  //       .collection('Report')
  //       .doc(user?.uid)
  //       .collection('students')
  //       .orderBy('cohort', descending: true);
  //   final CollectionReference studentInfo =
  //       FirebaseFirestore.instance.collection('students');
  UploadTask? task;
  // UploadTask? task2;
  File? file;
  String? upmid;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.transparent,
        title: Text("Add new Report",
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              // Text(
              //   'Title',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              // ),
              // TextField(
              //   textAlign: TextAlign.left,
              //   decoration: InputDecoration(
              //     fillColor: Colors.transparent,
              //     filled: true,
              //     border: OutlineInputBorder(),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide:
              //           const BorderSide(color: Colors.black87, width: 2.0),
              //       borderRadius: BorderRadius.circular(25.0),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              // Text(
              //   'Content',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              // ),
              // TextField(
              //   maxLines: 6,
              //   textAlign: TextAlign.left,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide:
              //           const BorderSide(color: Colors.white, width: 2.0),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(9),
                child: ElevatedButton(
                  child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: 215,
                      child: Row(
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Upload a document'),
                        ],
                      )),
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    primary: Colors.orange[600],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      // fontStyle: FontStyle.italic,
                    ),
                  ),
                  onPressed: () {
                    selectFile();
                  },
                ),
              ),
              SizedBox(height: 7),
              Text(
                fileName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  uploadFile();
                },
                child: Icon(
                  Icons.assignment_turned_in_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(18),
                  primary: Colors.orange[600], // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
              ),
              SizedBox(height: 10),
              task != null ? buildUploadStatus(task!) : Container(),
              // Container(
              //   // alignment: Alignment.bottomRight,
              //   // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 120),
              //   child: Container(
              //     // alignment: Alignment.bottomRight,
              //     // height: 40.0,
              //     // width: 40.0,
              //     decoration: new BoxDecoration(
              //         borderRadius: BorderRadius.circular(80.0),
              //         gradient: new LinearGradient(colors: [
              //           Color.fromARGB(255, 255, 136, 34),
              //           Color.fromARGB(255, 255, 177, 41)
              //         ])),
              //     padding: const EdgeInsets.all(0),
              //     child: IconButton(
              //       icon: Icon(Icons.assignment_turned_in_sharp,
              //           color: Colors.white),
              //       onPressed: () {
              //         print('Pressed');
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    if (file == null) return;

    final studentInfo = await FirebaseFirestore.instance
        .collection('students')
        .doc(user?.uid)
        .get();
    if (mounted) {
      setState(() {
        upmid = studentInfo.data()!['upmid'];
        print(upmid);
      });
    }

    final fileName = basename(file!.path);
    final destination = 'reports/$upmid/$fileName';

    //FirebaseApi.uploadFile(destination, file!);
    try {
      task = FirebaseStorage.instance.ref(destination).putFile(file!);
      // task2 = FirebaseFirestore.instance.
      setState(() {});

      if (task == null) return;
      final snapshot = await task!.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();

      print('Download-Link: $url');
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Widget buildUploadStatus(UploadTask uploadTask) =>
      StreamBuilder<TaskSnapshot>(
        stream: task!.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(0);

            if (percentage == '100') {
              Navigator.pop(context);
            }

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            );
          } else {
            return Container();
          }
        },
      );
}
