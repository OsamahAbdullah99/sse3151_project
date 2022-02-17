import 'package:SSE3151_project/PA/DashboardPA.dart';
import 'package:SSE3151_project/PA/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//trial test connection with firebase
class HomePage_PA extends StatelessWidget {
  const HomePage_PA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return dashboardPA();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something Went Wrong'));
          } else {
            return LoginWidgetPA();
          }
        },
      ),
    );
  }
}
