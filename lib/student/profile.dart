import 'package:SSE3151_project/login.dart';
import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/student/DashboardStudent.dart';
import 'package:SSE3151_project/student/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//trial test to see whether the details from google profile can be retrieve or not
//Result: Success! but only available for google user
//Feel free to change the UI :)
//var userD = FirebaseFirestore.instance.collection('users').doc("uid").get();
class Student_Profile extends StatelessWidget {
  Student_Profile({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(user.photoURL!),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Name: ' + user.displayName!,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Email: ' + user.email!,
                          style: TextStyle(fontSize: 16),
                        ),
                        //phone number is not available for those who sign in through google.
                        //so, we need the profile that can be edited to update their phone number
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => editProfile()));
                          },
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                  );
          }),
    );
  }

  // Future editProfile() async {
  //   User user = FirebaseAuth.instance.currentUser!;

  //     await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
  //       'uid': user.uid,
  //       'fullName': user.displayName,
  //       'id': '',
  //       'email': user.email,
  //       'phoneNumber': '',
  //     });
  // }
}
