import 'package:SSE3151_project/student/loginPage.dart';
import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/sendEmailPage.dart';
import 'package:SSE3151_project/student/DashboardStudent.dart';
import 'package:SSE3151_project/student/editProfile.dart';
import 'package:SSE3151_project/student/reports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//this is just to display whether the info can be retrieve or not
//Result: success!
//Feel free to change the UI :D

class Student_Profile extends StatefulWidget {
  Student_Profile({Key? key}) : super(key: key);

  @override
  State<Student_Profile> createState() => _Student_ProfileState();
}

class _Student_ProfileState extends State<Student_Profile> {
  final user = FirebaseAuth.instance.currentUser;

  String? name;
  String? image;
  String? UPMID;
  String? semester;
  String? faculty;
  String? dept;
  String? email;
  String? wechat;
  String? phoneNumber;

  String? wsLink;
  String? wcLink;
  String? emailLink;

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future setStudentValue() async {
    final studentInfo = await FirebaseFirestore.instance
        .collection('students')
        .doc(user?.uid)
        .get();

    if (mounted) {
      setState(() {
        // name = studentInfo.get('fullName');
        // image = studentInfo.get('image');
        // UPMID = studentInfo.get('upmid');
        // semester = studentInfo.get('semester');
        // faculty = studentInfo.get('faculty');
        // email = studentInfo.get('email');
        // wechat = studentInfo.get('wechat');
        // phoneNumber = studentInfo.get('phoneNumber');

        name = studentInfo.data()!['fullName'];
        image = studentInfo.data()!['image'];
        UPMID = studentInfo.data()!['upmid'];
        semester = studentInfo.data()!['semester'];
        faculty = studentInfo.data()!['faculty'];
        dept = studentInfo.data()!['department'];
        email = studentInfo.data()!['email'];
        wechat = studentInfo.data()!['wechat'];
        phoneNumber = studentInfo.data()!['phoneNumber'];

        final Uri emailLaunchUrl = Uri(
          scheme: 'mailto',
          path: email,
          query: encodeQueryParameters(
              <String, String>{'subject': 'Example Subject'}),
        );

        wsLink = "https://wa.me/" + phoneNumber!;
        wcLink = "https://web.wechat.com/" + wechat!;
        emailLink = emailLaunchUrl.toString();
      });
    }
  }

  void setStudentLink() {
    wsLink = "https://wa.me/" + phoneNumber!;
    wcLink = "weixin://dl/chat?" + wechat!;
    emailLink = "https://www.google.com/gmail/";
  }

  //only work on API 31
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: true, forceSafariVC: true, enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    setStudentValue();
    // setStudentLink();

    Size size = MediaQuery.of(context).size;

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
      body: SingleChildScrollView(
        child: Container(
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
          padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(image ??
                        "https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/default2_stdicon.jpg?alt=media&token=2e4518de-036f-47b6-9010-23588e9a6fe4"),
                  ),
                ],
              ),

              Divider(
                height: 50,
                color: Colors.black,
              ),
              Row(
                children: [
                  Text(
                    'Name: ',
                    style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              //SizedBox(height: 10),
              Row(
                children: [
                  Text(name ?? "",
                      style: TextStyle(
                        color: Colors.indigo,
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Email: ',
                    style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(email ?? "",
                      style: TextStyle(
                        color: Colors.indigo,
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Divider(
                height: 30,
                color: Colors.black,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('UPM-ID: ',
                      style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(UPMID ?? "",
                      style: TextStyle(
                        color: Colors.indigo,
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(semester ?? "",
                      style: TextStyle(
                        color: Colors.indigo,
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              SizedBox(height: 20),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Faculty: ',
                      style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Flexible(
                      child: Text(faculty ?? "",
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Department: ',
                      style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Flexible(
                      child: Text(dept ?? "",
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))),
                ],
              ),
              SizedBox(height: 20),
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Wechat ID: ',
                      style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(wechat ?? "",
                      style: TextStyle(
                        color: Colors.indigo,
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
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
                        child: Image.asset(
                          'assets/images/ws.png',
                          height: 24.0,
                          width: 24.0,
                        )),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      onPressed: () {
                        _launchURL(wcLink!);
                      },
                      child: Image.asset(
                        'assets/images/wechat.png',
                        height: 24.0,
                        width: 24,
                      ),
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(side: BorderSide.none),
                        onPressed: () {
                          // _launchURL(emailLink!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => sendEmailPage()));
                        },
                        child: Image.asset(
                          'assets/images/email.png',
                          height: 24,
                          width: 24,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => editProfile()));
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
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Edit Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Reports()));
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
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "My Reports",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => editProfile()));
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
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Chat",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
