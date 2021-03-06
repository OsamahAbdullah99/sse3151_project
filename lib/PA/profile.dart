import 'package:SSE3151_project/PA/DashboardPA.dart';
import 'package:SSE3151_project/PA/loginPage.dart';
import 'package:SSE3151_project/sendEmailPage.dart';
import 'package:SSE3151_project/PA/editProfile.dart';
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

class PA_Profile extends StatefulWidget {
  PA_Profile({Key? key}) : super(key: key);

  @override
  State<PA_Profile> createState() => _PA_ProfileState();
}

class _PA_ProfileState extends State<PA_Profile> {
  final user = FirebaseAuth.instance.currentUser;

  String? name;
  String? image;
  String? UPMID;
  String? faculty;
  String? department;
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

  Future setPAValue() async {
    final PAInfo =
        await FirebaseFirestore.instance.collection('PA').doc(user?.uid).get();

    if (mounted) {
      setState(() {
        name = PAInfo.data()!['fullName'];
        image = PAInfo.data()!['image'];
        UPMID = PAInfo.data()!['upmid'];
        department = PAInfo.data()!['department'];
        faculty = PAInfo.data()!['faculty'];
        email = PAInfo.data()!['email'];
        wechat = PAInfo.data()!['wechat'];
        phoneNumber = PAInfo.data()!['phoneNumber'];

        // final Uri emailLaunchUrl = Uri(
        //   scheme: 'mailto',
        //   path: email,
        //   query: encodeQueryParameters(
        //       <String, String>{'subject': 'Example Subject'}),
        // );

        wsLink = "https://wa.me/" + phoneNumber!;
        wcLink = "https://web.wechat.com/" + wechat!;
        // emailLink = emailLaunchUrl.toString();
      });
    }
  }

  // void setPALink() {
  //   wsLink = "https://wa.me/" + phoneNumber!;
  //   wcLink = "weixin://dl/chat?" + wechat!;
  //   emailLink = "https://www.google.com/gmail/";
  // }

  //only work on API 31
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    setPAValue();
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
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => editProfile_PA())),
              icon: Icon(Icons.edit)),
        ],
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      name ?? "",
                      style: TextStyle(
                          color: Colors.indigo,
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(email ?? "",
                        style: TextStyle(
                          color: Colors.indigo,
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              Divider(
                height: 30,
                thickness: 0.4,
                color: Colors.black,
              ),
              Row(
                children: [
                  Text('UPM-ID: ',
                      style: TextStyle(
                          color: Colors.black87,
                          letterSpacing: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(UPMID ?? "",
                      style: TextStyle(
                          color: Colors.indigo,
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Faculty: ',
                      style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Flexible(
                      child: Text(faculty ?? "",
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 2,
                            fontSize: 16,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Flexible(
                      child: Text(department ?? "",
                          style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 2,
                            fontSize: 16,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(wechat ?? "",
                      style: TextStyle(
                        color: Colors.indigo,
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
