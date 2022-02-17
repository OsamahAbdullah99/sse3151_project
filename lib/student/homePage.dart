import 'package:SSE3151_project/startPage.dart';
import 'package:SSE3151_project/student/DashboardStudent.dart';
import 'package:SSE3151_project/student/loginPage.dart';
import 'package:SSE3151_project/provider/auth_page.dart';
import 'package:SSE3151_project/student/editProfile.dart';
import 'package:SSE3151_project/student/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//trial test connection with firebase
class HomePage_Student extends StatelessWidget {
  const HomePage_Student({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return dashboardStudent();
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
