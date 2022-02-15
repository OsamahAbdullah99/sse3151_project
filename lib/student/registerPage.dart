import 'package:SSE3151_project/provider/auth_page.dart';
import 'package:SSE3151_project/services/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import '../background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class RegisterWidget extends StatefulWidget {
  // final VoidCallback onClickedSignIn;
  const RegisterWidget({
    Key? key,
    // required this.onClickedSignIn
  }) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final formKey = GlobalKey<FormState>();
  final FNCtrl = TextEditingController();
  final MIDCtrl = TextEditingController();
  final semCtrl = TextEditingController();
  final PNCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final wcCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String? _faculty;
  final List<String> faculties = [
    'Faculty of Agriculture',
    'Faculty of Forestry',
    'Faculty of Veterinary Medicine',
    'Faculty of Economics and Management',
    'Faculty of Engineering',
    'Faculty of Educational Studies',
    'Faculty of Science',
    'Faculty of Food Science and Technology',
    'Faculty of Human Ecology',
    'Faculty of Modern Languages and Communication',
    'Faculty of Design and Architecture',
    'Faculty of Medicine and Health Sciences',
    'Faculty of Computer Science and Information Technology',
    'Faculty of Biotechnology and Biomolecular Sciences',
    'Faculty of Environmental Studies',
  ];

  @override
  void dispose() {
    FNCtrl.dispose();
    MIDCtrl.dispose();
    semCtrl.dispose();
    PNCtrl.dispose();
    emailCtrl.dispose();
    wcCtrl.dispose();
    passwordCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Background(
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
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: FNCtrl,
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (fullName) =>
                                fullName != null && fullName.length < 6
                                    ? 'Enter a full name'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: MIDCtrl,
                            decoration: InputDecoration(
                                labelText: "Matric ID",
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "eg. 208192"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (id) => id != null && id.length < 6
                                ? 'Enter UPM-ID'
                                : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: semCtrl,
                            decoration: InputDecoration(
                                labelText: "Current Semester",
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "eg. 2021/2022-1"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (semester) =>
                                semester != null && semester.length < 1
                                    ? 'This field cannot be empty'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: "Faculty",
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            value: _faculty,
                            items: faculties.map((faculty) {
                              return DropdownMenuItem(
                                value: faculty,
                                child: Text(faculty),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => _faculty = value.toString()),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: emailCtrl,
                            decoration: InputDecoration(
                                labelText: "Email Address",
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "eg. 208192@student.upm.edu.my"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: wcCtrl,
                            decoration: InputDecoration(
                                labelText: "Wechat ID",
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "eg. syna09"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (wechat) =>
                                wechat != null && wechat.length < 1
                                    ? 'This field cannot be empty'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: PNCtrl,
                            decoration: InputDecoration(
                                labelText: "Mobile Number",
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "eg. 0128934700"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (phoneNumber) =>
                                phoneNumber != null && phoneNumber.length < 10
                                    ? 'Enter a phone number'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: passwordCtrl,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (password) =>
                                password != null && password.length < 8
                                    ? 'Enter min. 8 characters'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              signUp();
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(0)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
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
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                  child:
                      //  RichText(
                      //   text: TextSpan(
                      //     style: TextStyle(
                      //       color: Color(0xFF2661FA),
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     text: 'Already Have an Account? ',
                      //     children: [
                      //       TextSpan(
                      //         recognizer: TapGestureRecognizer()
                      //           ..onTap = widget.onClickedSignIn,
                      //         text: 'Sign In',
                      //         style: TextStyle(
                      //             decoration: TextDecoration.underline,
                      //             color: Color(0xFF2661FA)),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already Have an Account? ',
                        style: TextStyle(
                          color: Color(0xFF2661FA),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign In",
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    final String fullName = FNCtrl.text.trim();
    final String id = MIDCtrl.text.trim();
    final String semester = semCtrl.text;
    final String faculty = _faculty!;
    final String email = emailCtrl.text.trim();
    final String phoneNumber = PNCtrl.text.trim();
    final String wechat = wcCtrl.text.trim();
    final String password = passwordCtrl.text.trim();

    try {
      dynamic result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User user = FirebaseAuth.instance.currentUser!;

        await FirebaseFirestore.instance
            .collection("students")
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'fullName': fullName,
          'upmid': id,
          'semester': semester,
          'faculty': faculty,
          'email': email,
          'wechat': wechat,
          'phoneNumber': phoneNumber,
          'role': 'student',
          'image':
              'https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/default_studicon.png?alt=media&token=7726cd03-0bb7-47bf-ac35-a86b0b44b457',
        });
      });
      if (result != null) {
        print('Successfully register a student');
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
