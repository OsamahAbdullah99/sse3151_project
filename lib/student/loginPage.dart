// ignore_for_file: prefer_const_constructors

import 'package:SSE3151_project/ForgotPWPage.dart';
import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/services/utils.dart';
import 'package:SSE3151_project/startPage.dart';
import 'package:SSE3151_project/student/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'registerPage.dart';
import '../PA/DashboardPA.dart';
import 'DashboardStudent.dart';
import '../background.dart';
//import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  // final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    // required this.onClickedSignUp
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool _isObscure = true;
  final MIDCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: SingleChildScrollView(
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
                        decoration: InputDecoration(
                            labelText: "UPM-ID", hintText: "eg. 208192"),
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
                    // GestureDetector(
                    //   child: Text(
                    //     'Forgot Password?',
                    //     style: TextStyle(
                    //       fontSize: 12,
                    //       color: Color(0XFF2661FA),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () => signIn(),
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(0)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
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
              // Container(
              //   alignment: Alignment.centerRight,
              //   margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       final provider =
              //           Provider.of<GoogleSignInProvider>(context, listen: false);
              //       provider.googleLogin();
              //     },
              //     style: ButtonStyle(
              //         foregroundColor: MaterialStateProperty.all(Colors.white),
              //         padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(80.0),
              //         ))),
              //     child: Container(
              //       alignment: Alignment.center,
              //       height: 50.0,
              //       width: size.width * 0.5,
              //       decoration: new BoxDecoration(
              //           borderRadius: BorderRadius.circular(80.0),
              //           gradient: new LinearGradient(colors: [
              //             Color.fromARGB(255, 255, 136, 34),
              //             Color.fromARGB(255, 255, 177, 41)
              //           ])),
              //       padding: const EdgeInsets.all(0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             "Login with Google",
              //             textAlign: TextAlign.center,
              //             style: TextStyle(fontWeight: FontWeight.bold),
              //           ),
              //           SizedBox(width: 7),
              //           Image.asset(
              //             'assets/images/Google1.png',
              //             scale: 20,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                child:
                    // RichText(
                    //   text: TextSpan(
                    //     style: TextStyle(
                    //       color: Color(0xFF2661FA),
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //     text: 'Don\'t Have an Account? ',
                    //     children: [
                    //       TextSpan(
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = widget.onClickedSignUp,
                    //         text: 'Sign Up',
                    //         style: TextStyle(
                    //             decoration: TextDecoration.underline,
                    //             color: Color(0xFF2661FA)),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterWidget(
                                // onClickedSignIn: () {},
                                )))
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
      ),
    );
  }

  Future signIn() async {
    try {
      final String UPMID = MIDCtrl.text.trim();
      final String password = passwordCtrl.text.trim();

      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('students')
          .where('upmid', isEqualTo: UPMID)
          .get();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: snap.docs[0]['email'], password: password);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => dashboardStudent()));
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
