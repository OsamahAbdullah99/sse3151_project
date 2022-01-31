// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';



class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator LoginWidget - FRAME


    return Scaffold(
        appBar: AppBar(
          title: Text(
              'PA Advisor'
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.25),
          elevation: 0.0,

        ),
      body: Container(
        // width: 375,
        // height: 812,
        decoration: BoxDecoration(
          color : Colors.blue
          //fromRGBO(108, 99, 255, 1)
          //fromRGBO(255, 255, 255, 1),
        ),
        child: Stack(
            children: <Widget>[
              // Positioned(
              //     top: 0,
              //     left: 1,
              //     child: SvgPicture.asset(
              //         'assets/images/backgroundbox.png',
              //         semanticsLabel: 'backgroundbox'
              //     )
              // ),
              // Positioned(
              //     top: 48,
              //     left: 142,
              //     child: Text('PAdvisor', textAlign: TextAlign.left, style: TextStyle(
              //         color: Color.fromRGBO(255, 255, 255, 1),
              //         fontFamily: 'Poppins',
              //         fontSize: 24,
              //         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
              //         fontWeight: FontWeight.normal,
              //         height: 1
              //     ),
              //     )
              // ),
              Positioned(
                  top: 266,
                  left: 44,
                  child: Container(
                      width: 287,
                      height: 440,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        boxShadow : const [BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0,2),
                            blurRadius: 3
                        )],
                        color : Color.fromRGBO(255, 246, 246, 1),
                      )
                  )
              ),Positioned(
                  top: 405,
                  left: 74,
                  child: Container(
                      width: 232,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color : Color.fromRGBO(108, 99, 255, 1),
                      )
                  )
              ),Positioned(
                  top: 409,
                  left: 152,
                  child: Text('Password', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 348,
                  left: 74,
                  child: Container(
                      width: 232,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color : Color.fromRGBO(108, 99, 255, 1),
                      )
                  )
              ),Positioned(
                  top: 352,
                  left: 145,
                  child: Text('Username', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 481,
                  left: 74,
                  child: Container(
                      width: 232,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color : Color.fromRGBO(108, 99, 255, 1),
                      )
                  )
              ),Positioned(
                  top: 487,
                  left: 154,
                  child: Text('Sign in', textAlign: TextAlign.left, style: TextStyle(
                      color: Colors.deepOrange,
                      //fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1
                  ),)
              ),Positioned(
                  top: 447,
                  left: 129,
                  child: Text('Forgot password? ', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(57, 98, 241, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 728,
                  left: 65,
                  child: Text('Don’t have an account? Sign Up!', textAlign: TextAlign.left, style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 573,
                  left: 95,
                  child: Divider(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      thickness: 1
                  )

              ),Positioned(
                  top: 545,
                  left: 164,
                  child: Container(
                      width: 49,
                      height: 51,
                      decoration: BoxDecoration(
                        color : Color.fromRGBO(229, 229, 229, 1),
                        borderRadius : BorderRadius.all(Radius.elliptical(49, 51)),
                      )
                  )
              ),Positioned(
                  top: 555,
                  left: 173,
                  child: Text('OR', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 619,
                  left: 81,
                  child: Container(
                      width: 209,
                      height: 31,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color : Color.fromRGBO(255, 255, 255, 1),
                      )
                  )
              ),Positioned(
                  top: 618,
                  left: 95,
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image : DecorationImage(
                            image: AssetImage('assets/images/Google1.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )
                  )
              ),Positioned(
                  top: 623,
                  left: 138,
                  child: Text('Login with Google', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(108, 99, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 100,
                  left: 55,
                  child: Container(
                      width: 264,
                      height: 135,
                      decoration: BoxDecoration(
                        image : DecorationImage(
                            image: AssetImage('assets/images/1.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )
                  )
              ),
            ]
        )
    )
    );
  }
}
