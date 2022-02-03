import 'package:SSE3151_project/login.dart';
import 'package:SSE3151_project/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(onClickedSignUp: toggle)
      : RegisterWidget(onClickedSignIn: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
