// ignore_for_file: prefer_const_constructors

import 'package:SSE3151_project/ForgotPWPage.dart';
import 'package:SSE3151_project/PA/DashboardPA.dart';
import 'package:SSE3151_project/PA/profile.dart';
import 'package:SSE3151_project/PA/registerPage.dart';
import 'package:SSE3151_project/services/utils.dart';
import 'package:SSE3151_project/student/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../background.dart';
import '../startPage.dart';
//import 'package:google_fonts/google_fonts.dart';

class LoginWidgetPA extends StatefulWidget {
  const LoginWidgetPA({
    Key? key,
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidgetPA> {
  bool _isObscure = true;
  final MIDCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Form(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: MIDCtrl,
                      decoration: InputDecoration(labelText: "UPM-ID"),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: passwordCtrl,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            _isObscure = !_isObscure;
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: GestureDetector(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFF2661FA),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()));
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () => signIn(),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          "LOGIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 55, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterWidgetPA()))
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t Have an Account? ',
                    style: TextStyle(
                      color: Color(0xFF2661FA),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Color(0xFF2661FA)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Container(
                alignment: Alignment.center,
                height: 40.0,
                width: 40.0,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41)
                    ])),
                padding: const EdgeInsets.all(0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    // Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => startLoginPage()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      final String UPMID = MIDCtrl.text.trim();
      final String password = passwordCtrl.text.trim();

      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('PA')
          .where('upmid', isEqualTo: UPMID)
          .get();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: snap.docs[0]['email'], password: password);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => dashboardPA()));
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
