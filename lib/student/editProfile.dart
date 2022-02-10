import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/services/database.dart';
import 'package:SSE3151_project/student_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? password;
  String? phoneNumber;

  String? currentName;
  String? currentUPMID;
  String? currentSemester;
  String? currentFaculty;
  String? currentEmail;
  String? currentWechat;
  String? currentPassword;
  String? currentPhoneNumber;

  void setVariable() {
    name = FNCtrl.text;
    UPMID = MIDCtrl.text;
    semester = semCtrl.text;
    // faculty = ;
    email = emailCtrl.text;
    wechat = wcCtrl.text;
    password = passwordCtrl.text;
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
    currentFaculty = studentInfo.get('faculty');
    currentEmail = studentInfo.get('email');
    currentWechat = studentInfo.get('wechat');
    currentPassword = studentInfo.get('password');
    currentPhoneNumber = studentInfo.get('phoneNumber');

    FNCtrl.text = currentName!;
    MIDCtrl.text = currentUPMID!;
    semCtrl.text = currentSemester!;
    PNCtrl.text = currentPhoneNumber!;
    emailCtrl.text = currentEmail!;
    wcCtrl.text = currentWechat!;
    passwordCtrl.text = currentPassword!;

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

  studentUser? student;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final user = Provider.of<studentUserData>(context);
    getStudentData();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                //need to be fix: if user using google & if user using normal email
                // final provider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.logout();
                FirebaseAuth.instance.signOut();
              },
              child: Image.asset(
                'assets/images/logoutIcon.png',
                scale: 20,
              )),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigoAccent, Colors.blue.shade200, Colors.white],
              // stops: [0.2, 0.8, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(image ??
                    'https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/default2_stdicon.jpg?alt=media&token=2e4518de-036f-47b6-9010-23588e9a6fe4'),
              ),
              SizedBox(height: 8),
              TextFormField(
                // initialValue: currentName,
                controller: FNCtrl,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: currentName,
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
                validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                // onChanged: (val) => setState(() {
                //   currentName = val;
                // }),
              ),
              SizedBox(height: 8),
              TextFormField(
                // initialValue: currentUPMID,
                controller: MIDCtrl,
                decoration: InputDecoration(
                  labelText: 'UPM-ID',
                  hintText: currentUPMID,
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
                validator: (val) => val != null && val.length < 6
                    ? 'This field cannot be empty'
                    : null,
                // onChanged: (val) => setState(() {
                //   currentUPMID = val;
                // }),
              ),
              SizedBox(height: 8),
              // TextFormField(
              //   initialValue: currentName,
              //   decoration: InputDecoration(
              //     labelText: 'Full Name',
              //     hintText: currentName,
              //     fillColor: Colors.white,
              //     filled: true,
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.white, width: 2.0),
              //     ),
              //   ),
              //   validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
              //   onChanged: (val) => setState(() {
              //     currentName = val;
              //   }),
              // ),

              // SizedBox(height: 8),
              // Text(
              //   'Email: ' + user.email!,
              //   style: TextStyle(fontSize: 16),
              // ),
              // //phone number is not available for those who sign in through google.
              // //so, we need the profile that can be edited to update their phone number

              // SizedBox(height: 8),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: 30, vertical: 10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.white70,
              //       borderRadius: new BorderRadius.circular(10.0),
              //     ),
              //     // child: Padding(
              //     //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              //     child: TextFormField(
              //       initialValue: user.displayName!,
              //       style: TextStyle(fontSize: 16),
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         fillColor: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              // ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      name = FNCtrl.text.trim();
                      UPMID = MIDCtrl.text.trim();
                      // final String semester = semCtrl.text;
                      // final String faculty = _faculty!;
                      // final String email = emailCtrl.text.trim();
                      // final String phoneNumber = PNCtrl.text.trim();
                      // final String wechat = wcCtrl.text.trim();
                      // final String password = passwordCtrl.text.trim();

                      User user = FirebaseAuth.instance.currentUser!;

                      await FirebaseFirestore.instance
                          .collection("students")
                          .doc(user.uid)
                          .update({
                        'fullName': name,
                        'upmid': UPMID,
                        // 'email': email,
                        // 'phoneNumber': '',
                      });

                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      "Save",
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
