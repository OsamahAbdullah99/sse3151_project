import 'dart:io';

import 'package:SSE3151_project/PA/addAdvisee.dart';
import 'package:SSE3151_project/PA/archivedList.dart';
import 'package:SSE3151_project/background2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;
import '../pdfViewerPage.dart';
import '../services/firebase_file.dart';

class adviseeList extends StatefulWidget {
  const adviseeList({Key? key}) : super(key: key);

  @override
  _adviseeListState createState() => _adviseeListState();
}

final user = FirebaseAuth.instance.currentUser;

class _adviseeListState extends State<adviseeList> {
  String? wsLink;
  String? wcLink;
  final toCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance
        .collection('Advisee_Advisor')
        .doc(user?.uid)
        .collection('students')
        .orderBy('cohort', descending: true);
    final CollectionReference studentInfo =
        FirebaseFirestore.instance.collection('students');

    // Future getAdviseeLists() async {
    //   Query<Map<String, dynamic>> advisees =
    //       FirebaseFirestore.instance.collection('Advisee_Advisor').orderBy('field');
    //   DocumentSnapshot snapshot = await advisees
    //       .doc(user?.uid)
    //       .collection('student')
    //       .doc(user?.uid)
    //       .get();
    //   var data = snapshot.data() as Map;
    //   var adviseeData = data['student'] as List<dynamic>;
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Advisee List'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          // TextButton.icon(
          //   style: TextButton.styleFrom(primary: Colors.black),
          //   icon: const Icon(Icons.person_add_alt_1_rounded),
          //   label: const Text('Add'),
          //   onPressed: () => _showPanel(),
          // ),
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => archivedList())),
              icon: Icon(Icons.archive_rounded)),
          // PopupMenuButton<MenuItem>(
          //   onSelected: (item) => onSelected(context, item),
          //   itemBuilder: (context) => [
          //     ...MenuLists.itemAdviseeLists.map(buildItem).toList(),
          //   ],
          //   color: Color.fromARGB(255, 206, 214, 255),
          //   //Color.fromARGB(255, 206, 214, 255),
          //   //Color.fromARGB(255, 166, 173, 211)
          // ),
        ],
      ),
      body: Background2(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: db.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return Card(
                      margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
                      child: new Slidable(
                        endActionPane:
                            ActionPane(motion: BehindMotion(), children: [
                          SlidableAction(
                            onPressed: (BuildContext context) async {
                              String upmid = doc.get('upmid');
                              QuerySnapshot upmID_Stream = await studentInfo
                                  .where('upmid', isEqualTo: upmid)
                                  .get();
                              List<QueryDocumentSnapshot> upmID_StreamList =
                                  upmID_Stream.docs;
                              String upm_id =
                                  upmID_StreamList.first.get('upmid');
                              String cohort =
                                  upmID_StreamList.first.get('cohort');
                              String role = upmID_StreamList.first.get('role');
                              String fullName =
                                  upmID_StreamList.first.get('fullName');
                              String image =
                                  upmID_StreamList.first.get('image');
                              String faculty =
                                  upmID_StreamList.first.get('faculty');
                              String dept =
                                  upmID_StreamList.first.get('department');
                              String semester =
                                  upmID_StreamList.first.get('semester');
                              String email =
                                  upmID_StreamList.first.get('email');
                              String wechat =
                                  upmID_StreamList.first.get('wechat');
                              String phoneNumber =
                                  upmID_StreamList.first.get('phoneNumber');

                              FirebaseFirestore.instance
                                  .collection('Advisee_Advisor')
                                  .doc(user?.uid)
                                  .collection('students')
                                  .doc(upm_id)
                                  .delete();

                              FirebaseFirestore.instance
                                  .collection("Archived_Advisee")
                                  .doc(user?.uid)
                                  .collection('students')
                                  .doc(upm_id)
                                  .set({
                                'upmid': upm_id,
                                'cohort': cohort,
                                'role': role,
                                'fullName': fullName,
                                'image': image,
                                'semester': semester,
                                'faculty': faculty,
                                'department': dept,
                                'email': email,
                                'wechat': wechat,
                                'phoneNumber': phoneNumber,
                              });
                            },
                            autoClose: true,
                            backgroundColor: Color(0xFF434BC0),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          )
                        ]),
                        child: ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: 5,
                              ),
                              Text(doc.get('upmid')),
                            ],
                          ),
                          subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(doc.get('fullName')),
                                Text(doc.get('cohort'))
                              ]),
                          // title: Text(doc.get('upmid')),
                          // subtitle: Text(doc.get('fullName')),
                          onTap: () async {
                            String upmid = doc.get('upmid');
                            QuerySnapshot upmID_Stream = await studentInfo
                                .where('upmid', isEqualTo: upmid)
                                .get();
                            List<QueryDocumentSnapshot> upmID_StreamList =
                                upmID_Stream.docs;
                            String upm_id = upmID_StreamList.first.get('upmid');
                            String cohort =
                                upmID_StreamList.first.get('cohort');
                            String fullName =
                                upmID_StreamList.first.get('fullName');
                            String image = upmID_StreamList.first.get('image');
                            String faculty =
                                upmID_StreamList.first.get('faculty');
                            String dept =
                                upmID_StreamList.first.get('department');
                            String semester =
                                upmID_StreamList.first.get('semester');
                            String email = upmID_StreamList.first.get('email');
                            String wechat =
                                upmID_StreamList.first.get('wechat');
                            String phoneNumber =
                                upmID_StreamList.first.get('phoneNumber');

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => showStudentProfile(
                                    upm_id,
                                    cohort,
                                    fullName,
                                    semester,
                                    faculty,
                                    dept,
                                    image,
                                    email,
                                    wechat,
                                    phoneNumber)));
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.person_add_alt_1_rounded,
            size: 30,
          ),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              gradient: new LinearGradient(colors: [
                Color.fromARGB(255, 255, 136, 34),
                Color.fromARGB(255, 255, 177, 41)
              ])),
        ),
        onPressed: () {
          _showPanel();
        },
      ),
    );
  }

  // PopupMenuItem<MenuItem> buildItem(MenuItem item) {
  //   return PopupMenuItem<MenuItem>(
  //     value: item,
  //     child: Row(
  //       children: [
  //         Icon(
  //           item.icon,
  //           color: Colors.black,
  //           size: 25,
  //         ),
  //         const SizedBox(
  //           width: 12,
  //         ),
  //         Text(item.text),
  //       ],
  //     ),
  //   );
  // }

  // void onSelected(BuildContext context, MenuItem item) {
  //   switch (item) {
  //     case MenuLists.itemAddAdvisee:
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(builder: (context) => _showPanel()),
  //       // );
  //       Navigator.of(context).push(
  //         MaterialPageRoute(builder: (context) {
  //           return GestureDetector(
  //             onTap: () {
  //               showModalBottomSheet(
  //                   context: context,
  //                   builder: (context) {
  //                     return Container(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 20.0, horizontal: 60.0),
  //                       child: addAdvisee(),
  //                     );
  //                   });
  //             },
  //           );
  //         }),
  //       );
  //       //        Navigator.push(context, MaterialPageRoute<bool>(
  //       // builder: (BuildContext context) {
  //       //   return Center(
  //       //     child: GestureDetector(
  //       //       child: Text('OK'),
  //       //       onTap: ));}));
  //       break;
  //     // case MenuLists.itemArchivedAdvisee:
  //     //   Navigator.of(context).push(
  //     //     MaterialPageRoute(builder: (context) => adviseeList()),
  //     //   );
  //     //   break;
  //     default:
  //   }
  // }

  _showPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
            height: 230, //200
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: addAdvisee(),
          );
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: true, forceSafariVC: true, enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  //start of developing for advisee's profile
  Future getStudentProfile(
      String upm_id,
      String cohort,
      String fullName,
      String semester,
      String faculty,
      String dept,
      String image,
      String email,
      String wechat,
      String phoneNumber) async {
    final db = await FirebaseFirestore.instance
        .collection('Advisee_Advisor')
        .doc(user?.uid)
        .collection('students')
        .doc(upm_id)
        .get();
    setState(() {
      upm_id = db.data()!['upmid'];
      cohort = db.data()!['cohort'];
      fullName = db.data()!['fullName'];
      image = db.data()!['image'];
      faculty = db.data()!['faculty'];
      dept = db.data()!['department'];
      semester = db.data()!['semester'];
      email = db.data()!['email'];
      wechat = db.data()!['wechat'];
      phoneNumber = db.data()!['phoneNumber'];

      wsLink = "https://wa.me/" + phoneNumber;
      wcLink = "https://web.wechat.com/" + wechat;
    });
  }

  showStudentProfile(
      String upm_id,
      String cohort,
      String fullName,
      String semester,
      String faculty,
      String dept,
      String image,
      String email,
      String wechat,
      String phoneNumber) {
    getStudentProfile(upm_id, cohort, fullName, semester, faculty, dept, image,
        email, wechat, phoneNumber);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Profile",
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.indigoAccent,
                  Colors.blue.shade200,
                  Colors.white
                ],
                // stops: [0.2, 0.8, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(image),
                  ),
                ],
              ),
              Divider(
                height: 50,
                thickness: 0.6,
                color: Colors.black,
              ),
              Row(
                children: [
                  Text('Name: ',
                      style: TextStyle(
                          color: Colors.black87,
                          letterSpacing: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(fullName,
                      style: TextStyle(
                          color: Colors.indigo,
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('UPM-ID: ',
                      style: TextStyle(
                          color: Colors.black87,
                          letterSpacing: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(upm_id,
                      style: TextStyle(
                          color: Colors.indigo,
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Email: ',
                      style: TextStyle(
                          color: Colors.black87,
                          letterSpacing: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(email,
                        style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Divider(
                height: 50,
                thickness: 0.6,
                color: Colors.black,
              ),
              Row(
                children: [
                  Text('Cohort: ',
                      style: TextStyle(
                          color: Colors.black87,
                          letterSpacing: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(cohort,
                      style: TextStyle(
                          color: Colors.indigo,
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Semester: ',
                      style: TextStyle(
                          color: Colors.black87,
                          letterSpacing: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(semester,
                      style: TextStyle(
                          color: Colors.indigo,
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Faculty: ',
                      style: TextStyle(
                          color: Colors.black87,
                          letterSpacing: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Flexible(
                      child: Text(faculty,
                          style: TextStyle(
                              color: Colors.indigo,
                              letterSpacing: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Department: ',
                      style: TextStyle(
                          color: Colors.black87,
                          letterSpacing: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Flexible(
                      child: Text(dept,
                          style: TextStyle(
                              color: Colors.indigo,
                              letterSpacing: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))),
                ],
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(side: BorderSide.none),
                        onPressed: () {
                          _launchURL(wsLink!);
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.asset(
                                'assets/images/ws.png',
                              )),
                        )),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(side: BorderSide.none),
                        onPressed: () {
                          _launchURL(wcLink!);
                        },
                        child: Card(
                          elevation: 10,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Image.asset(
                              'assets/images/wechat.png',
                            ),
                          ),
                        )),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(side: BorderSide.none),
                        onPressed: () {
                          // _launchURL(emailLink!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      sendEmailtoStudentPage(upm_id, email)));
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Icon(
                              Icons.email_rounded,
                              color: Colors.black,
                              size: 19,
                            ),
                          ),
                        )
                        //  Stack(
                        //   children: [
                        //     Positioned(
                        //       left: 2.0,
                        //       top: 2.0,
                        //       child: Icon(Icons.email_rounded,
                        //           color: Colors.indigo),
                        //     ),
                        //     Icon(Icons.email_rounded, color: Colors.white)
                        //   ],
                        // )
                        ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      onPressed: () {
                        // _launchURL(emailLink!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    showStudentReport(upm_id)));
                      },
                      child: Card(
                        color: Colors.amber,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.assignment_sharp,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

//start of developing for sending email to respective advisee
  Future getStudentEmail(String upm_id, String email) async {
    final db = await FirebaseFirestore.instance
        .collection('Advisee_Advisor')
        .doc(user?.uid)
        .collection('students')
        .doc(upm_id)
        .get();
    setState(() {
      upm_id = db.data()!['upmid'];
      email = db.data()!['email'];

      toCtrl.text = email;
    });
  }

  sendEmailtoStudentPage(String upm_id, String email) {
    getStudentEmail(upm_id, email);
    Widget buildTextField({
      required String title,
      required TextEditingController ctrl,
      int maxLines = 1,
    }) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: ctrl,
              maxLines: maxLines,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        );
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Sender'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(title: 'To', ctrl: toCtrl),
            SizedBox(height: 16),
            buildTextField(title: 'Subject', ctrl: subjectCtrl),
            SizedBox(height: 16),
            buildTextField(title: 'Message', ctrl: msgCtrl, maxLines: 8),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => launchEmail(
          toEmail: toCtrl.text,
          subject: subjectCtrl.text,
          message: msgCtrl.text,
        ),
        label: Text('SEND',
            style: TextStyle(
              fontSize: 16,
            )),
        icon: Icon(Icons.send_rounded),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  Future launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

//start of developing for advisee's uploaded reports
  Future getStudentID(String upm_id) async {
    final db = await FirebaseFirestore.instance
        .collection('Advisee_Advisor')
        .doc(user?.uid)
        .collection('students')
        .doc(upm_id)
        .get();
    setState(() {
      upm_id = db.data()!['upmid'];
    });
  }

  showStudentReport(String upm_id) {
    getStudentID(upm_id);
    late Future<List<FirebaseFile>> futureFiles;

    futureFiles = listAll(upm_id);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.transparent,
        title: Text('$upm_id | Reports',
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occured!'));
                } else {
                  final files = snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.indigoAccent,
                            Colors.blue.shade200,
                            Colors.white
                          ],
                          // stops: [0.2, 0.8, 1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          CircleAvatar(
                            radius: 70,
                            child: ClipRRect(
                              child: Image.asset('assets/images/avatar.png'),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 5),
                                  Expanded(
                                    child: ListView.separated(
                                        padding: EdgeInsets.all(18),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 20),
                                        itemCount: files.length,
                                        itemBuilder: (context, index) {
                                          final file = files[index];
                                          return buildFile(
                                              context, file, upm_id);
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_downward,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  );
                }
            }
          }),
    );
  }

  buildFile(BuildContext context, FirebaseFile file, String upm_id) =>
      ElevatedButton(
        onPressed: () {
          final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);
          final isPDF = ['.pdf'].any(file.name.contains);
          if (isImage) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => imageView(context, file)));
          } else if (isPDF) {
            loadPDF(context, file, upm_id);
          }
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ))),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: 350,
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: new LinearGradient(colors: [
                Color.fromARGB(255, 255, 136, 34),
                Color.fromARGB(255, 255, 177, 41)
              ])),
          padding: const EdgeInsets.all(0),
          child: Text(
            file.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );

  imageView(BuildContext context, FirebaseFile file) {
    final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        backgroundColor: Color(0xB7000000),
        //Color(0xB7000000),
        //Color(0xDD000000),
        centerTitle: true,
      ),
      body: isImage
          ? Image.network(
              file.url,
              height: double.infinity,
              fit: BoxFit.cover,
            )
          : Center(
              child: Text(
                'Cannot be displayed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  Future<List<FirebaseFile>> listAll(String upm_id) async {
    final coll = FirebaseStorage.instance.ref('reports/$upm_id/');
    final result = await coll.listAll();

    final urls = await _getDownloadLinks(result.items);
    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());
}

Future loadPDF(BuildContext context, FirebaseFile ref, String upm_id) async {
  try {
    final url = 'reports/$upm_id/${ref.name}';

    final file = await loadFirebase(url);
    if (file == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => PDFViewerPage(context, file: file)),
    );
  } catch (e) {
    return null;
  }
}

Future loadFirebase(String url) async {
  try {
    final refPDF = FirebaseStorage.instance.ref().child(url);
    final bytes = await refPDF.getData();

    return _storeFile(url, bytes!);
  } catch (e) {
    return null;
  }
}

Future<File> _storeFile(String url, List<int> bytes) async {
  final filename = path.basename(url);
  final dir = await getApplicationDocumentsDirectory();

  final file = File('${dir.path}/$filename');
  await file.writeAsBytes(bytes, flush: true);
  return file;
}
