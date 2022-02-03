import 'package:SSE3151_project/provider/auth_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'background.dart';

class RegisterWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const RegisterWidget({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
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
                  "REGISTER",
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
                        decoration: InputDecoration(labelText: "Full Name"),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        decoration: InputDecoration(labelText: "Matric ID"),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        decoration: InputDecoration(labelText: "Email address"),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        decoration: InputDecoration(labelText: "Mobile number"),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () {},
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
                            "SIGN UP",
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
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Color(0xFF2661FA),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    text: 'Already Have an Account? ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Sign In',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFF2661FA)),
                      ),
                    ],
                  ),
                ),
                // GestureDetector(
                //   onTap: () => {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => AuthPage()))
                //   },
                //   child: Text(
                //     "Already Have an Account? Sign in",
                //     style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.bold,
                //         color: Color(0xFF2661FA)),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
