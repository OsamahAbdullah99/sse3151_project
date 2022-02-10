import 'package:SSE3151_project/login.dart';
import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/student/DashboardStudent.dart';
// import 'package:SSE3151_project/student/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//trial test to see whether the details from google profile can be retrieve or not
//Result: Success! but only available for google user
//Feel free to change the UI :)
//var userD = FirebaseFirestore.instance.collection('users').doc("uid").get();
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
  String? email;
  String? wechat;
  String? phoneNumber;

  String? wsLink;
  String? wcLink;
  String? emailLink;

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
        email = studentInfo.data()!['email'];
        wechat = studentInfo.data()!['wechat'];
        phoneNumber = studentInfo.data()!['phoneNumber'];
      });
    }
  }

  // void setStudentLink() {
  //   wsLink = "https://wa.me/" + phoneNumber!;
  //   wcLink = "https://wechat.com/" + wechat!;
  //   emailLink = "https://www.google.com/gmail/";
  // }

  //   _launchURL(String url) async {
  //   //const url = 'https://flutter.io';
  //   if (await canLaunch(url)) {
  //     await launch(url, forceWebView: true, forceSafariVC: true);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => dashboardStudent())),
        ),
        actions: [
          TextButton(
              onPressed: () {
                //need to be fix: if user using google & if user using normal email
                // final provider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.logout();
                FirebaseAuth.instance.signOut();
              },
              child: Image.asset(
                'assets/images/logoutIcon.png',
                scale: 20,
              )),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(image ??
                  "https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/default2_stdicon.jpg?alt=media&token=2e4518de-036f-47b6-9010-23588e9a6fe4"),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  name ?? "",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  email ?? "",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(UPMID ?? "", style: TextStyle(fontSize: 15)),
                  Text(semester ?? "", style: TextStyle(fontSize: 15)),
                  Text(faculty ?? "", style: TextStyle(fontSize: 15)),
                ],
              ),
            ),

            //phone number is not available for those who sign in through google.
            //so, we need the profile that can be edited to update their phone number
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => editProfile()));
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
          ],
        ),
      ),
    );
  }
}
