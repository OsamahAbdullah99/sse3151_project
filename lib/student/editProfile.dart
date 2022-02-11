import 'package:SSE3151_project/loginPage.dart';
import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/services/database.dart';
import 'package:SSE3151_project/student/student_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class editProfile extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //controller
  final FNCtrl = TextEditingController();
  final MIDCtrl = TextEditingController();
  final semCtrl = TextEditingController();
  final PNCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final wcCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;

  String? image;
  String? name;
  String? UPMID;
  String? semester;
  String? faculty;
  String? email;
  String? wechat;
  String? phoneNumber;

  String? currentName;
  String? currentUPMID;
  String? currentSemester;
  String? currentEmail;
  String? currentWechat;
  String? currentPhoneNumber;

  bool _isObscure = true;

  void setVariable() {
    name = FNCtrl.text;
    UPMID = MIDCtrl.text;
    semester = semCtrl.text;
    email = emailCtrl.text;
    wechat = wcCtrl.text;
    phoneNumber = PNCtrl.text;
  }

  Future getStudentData() async {
    final studentInfo = await FirebaseFirestore.instance
        .collection('students')
        .doc(user.uid)
        .get();

    image = studentInfo.get('image');
    currentName = studentInfo.get('fullName');
    currentUPMID = studentInfo.get('upmid');
    currentSemester = studentInfo.get('semester');
    currentEmail = studentInfo.get('email');
    currentWechat = studentInfo.get('wechat');
    currentPhoneNumber = studentInfo.get('phoneNumber');

    FNCtrl.text = currentName!;
    MIDCtrl.text = currentUPMID!;
    semCtrl.text = currentSemester!;
    PNCtrl.text = currentPhoneNumber!;
    emailCtrl.text = currentEmail!;
    wcCtrl.text = currentWechat!;

    // image = studentInfo.data()!['image'];
    // currentName = studentInfo.data()!['fullName'];
    // currentUPMID = studentInfo.data()!['upmid'];
    // currentSemester = studentInfo.data()!['semester'];
    // currentFaculty = studentInfo.data()!['faculty'];
    // currentEmail = studentInfo.data()!['email'];
    // currentWechat = studentInfo.data()!['wechat'];
    // currentPassword = studentInfo.data()!['password'];
    // currentPhoneNumber = studentInfo.data()!['phoneNumber'];

    print('getting...');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getStudentData();

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text("Edit Profile",
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
        actions: [
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginWidget(
                              onClickedSignUp: () {},
                            )));
              },
              child: Image.asset(
                'assets/images/logoutIcon.png',
                scale: 20,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.indigoAccent,
              Colors.blue.shade200,
              Colors.white
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(image ??
                      'https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/default_studicon.png?alt=media&token=7726cd03-0bb7-47bf-ac35-a86b0b44b457'),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: FNCtrl,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: currentName,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: MIDCtrl,
                  decoration: InputDecoration(
                    labelText: 'UPM-ID',
                    hintText: currentUPMID,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) => val != null && val.length < 6
                      ? 'This field cannot be empty'
                      : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: semCtrl,
                  decoration: InputDecoration(
                      labelText: 'Current Semester', hintText: currentSemester),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) =>
                      val == null ? 'This field cannot be empty' : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: emailCtrl,
                  decoration: InputDecoration(
                      labelText: 'Current Email', hintText: currentEmail),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) =>
                      val != null && !EmailValidator.validate(val)
                          ? 'Enter a valid email'
                          : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: wcCtrl,
                  decoration: InputDecoration(
                      labelText: 'Current Wechat ID', hintText: currentWechat),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) =>
                      val == null ? 'This field cannot be empty' : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: PNCtrl,
                  decoration: InputDecoration(
                      labelText: 'Current Phone Number',
                      hintText: currentPhoneNumber),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) =>
                      val == null ? 'This field cannot be empty' : null,
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.check_rounded,
            size: 40,
          ),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              gradient: new LinearGradient(colors: [
                Color.fromARGB(255, 255, 136, 34),
                Color.fromARGB(255, 255, 177, 41)
              ])),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            name = FNCtrl.text.trim();
            UPMID = MIDCtrl.text.trim();
            semester = semCtrl.text;
            email = emailCtrl.text.trim();
            phoneNumber = PNCtrl.text.trim();
            wechat = wcCtrl.text.trim();

            User user = FirebaseAuth.instance.currentUser!;

            await FirebaseFirestore.instance
                .collection("students")
                .doc(user.uid)
                .update({
              'fullName': name,
              'upmid': UPMID,
              'semester': semester,
              'email': email,
              'wechat': wechat,
              'phoneNumber': phoneNumber,
            });

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
