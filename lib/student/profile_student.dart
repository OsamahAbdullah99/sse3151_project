import 'package:SSE3151_project/login.dart';
import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/student/DashboardStudent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//trial test to see whether the details from google profile can be retrieve or not
//Result: Success! but only available for google user
//Feel free to change the UI :)

class StudentProfile extends StatelessWidget {
  StudentProfile({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

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
          ],
        ),
      ),
    );
  }
}
