import 'editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class PAC_Profile extends StatefulWidget {
  const PAC_Profile({Key? key}) : super(key: key);

  @override
  _PAC_ProfileState createState() => _PAC_ProfileState();
}

class _PAC_ProfileState extends State<PAC_Profile> {
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

  Future setPACValue() async {
    final PACInfo = await FirebaseFirestore.instance
        .collection('PA Coordinator')
        .doc(user?.uid)
        .get();

    if (mounted) {
      setState(() {
        name = PACInfo.data()!['fullName'];
        image = PACInfo.data()!['image'];
        UPMID = PACInfo.data()!['upmid'];
        department = PACInfo.data()!['department'];
        faculty = PACInfo.data()!['faculty'];
        email = PACInfo.data()!['email'];
        wechat = PACInfo.data()!['wechat'];
        phoneNumber = PACInfo.data()!['phoneNumber'];

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
    setPACValue();

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
                  MaterialPageRoute(builder: (context) => editProfile_PAC())),
              icon: Icon(Icons.edit)),
        ],
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
        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(image ??
                      "https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/def_profIcon.png?alt=media&token=12132e6a-7c3d-4424-a36a-6e1334dc799b"),
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
    );
  }
}
