import 'package:SSE3151_project/login.dart';
import 'package:SSE3151_project/profile_student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//trial test to see whether the details from google profile can be retrieve or not
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return StudentProfile();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something Went Wrong'));
          } else {
            return LoginWidget();
          }
        },
      ),
    );
  }
}
