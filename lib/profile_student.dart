import 'package:SSE3151_project/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//trial test to see whether the details from google profile can be retrieve or not
class StudentProfile extends StatelessWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          TextButton(onPressed: () {}, child: Text('Logout')),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(),
      ),
    );
  }
}
