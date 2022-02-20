import 'package:SSE3151_project/HOD/homePage.dart';
import 'package:SSE3151_project/PA/homePage.dart';
import 'package:SSE3151_project/background2.dart';
import 'package:SSE3151_project/student/homePage.dart';
import 'package:flutter/material.dart';

import 'PACoordinator/homePage.dart';

class startLoginPage extends StatefulWidget {
  const startLoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<startLoginPage> createState() => _startLoginPageState();
}

class _startLoginPageState extends State<startLoginPage> {
//change the UI if you want

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background2(
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Container(
                child: Text(
                  'Welcome to \nPAdvisor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36),
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/images/upm.png',
                scale: 3.7,
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage_Student()
                          // LoginWidget(
                          //     // onClickedSignUp: () {}
                          //     )
                          )),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ))),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 265,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "LOGIN AS STUDENT",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage_PA())),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ))),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 265,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "LOGIN AS PA",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage_PAC())),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ))),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 265,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "LOGIN AS PA COORDINATOR",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage_HOD())),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ))),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 265,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "LOGIN AS HEAD OF DEPARTMENT",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
