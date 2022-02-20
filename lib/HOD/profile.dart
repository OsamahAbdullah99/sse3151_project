import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'editProfile.dart';

class HOD_Profile extends StatefulWidget {
  const HOD_Profile({Key? key}) : super(key: key);

  @override
  _HOD_ProfileState createState() => _HOD_ProfileState();
}

class _HOD_ProfileState extends State<HOD_Profile> {
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

  Future setHODValue() async {
    final HODInfo =
        await FirebaseFirestore.instance.collection('HOD').doc(user?.uid).get();

    if (mounted) {
      setState(() {
        name = HODInfo.data()!['fullName'];
        image = HODInfo.data()!['image'];
        UPMID = HODInfo.data()!['upmid'];
        department = HODInfo.data()!['department'];
        faculty = HODInfo.data()!['faculty'];
        email = HODInfo.data()!['email'];
        wechat = HODInfo.data()!['wechat'];
        phoneNumber = HODInfo.data()!['phoneNumber'];

        wsLink = "https://wa.me/" + phoneNumber!;
        wcLink = "https://web.wechat.com/" + wechat!;
      });
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    setHODValue();

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
                  MaterialPageRoute(builder: (context) => editProfile_HOD())),
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
                        "https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/def_profIcon3.png?alt=media&token=bfc1368c-d1bb-4b27-af4e-cd7b03bbdb69"),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
