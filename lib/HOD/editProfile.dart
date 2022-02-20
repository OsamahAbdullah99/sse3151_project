import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class editProfile_HOD extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //controller
  final FNCtrl = TextEditingController();
  final MIDCtrl = TextEditingController();
  final depCtrl = TextEditingController();
  final PNCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final wcCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;

  String? image;
  String? name;
  String? UPMID;
  String? email;
  String? wechat;
  String? phoneNumber;

  String? currentName;
  String? currentUPMID;
  String? currentEmail;
  String? currentWechat;
  String? currentPhoneNumber;

  bool _isObscure = true;

  void setVariable() {
    name = FNCtrl.text;
    UPMID = MIDCtrl.text;
    email = emailCtrl.text;
    wechat = wcCtrl.text;
    phoneNumber = PNCtrl.text;
  }

  Future getHODData() async {
    final hodInfo =
        await FirebaseFirestore.instance.collection('HOD').doc(user.uid).get();

    image = hodInfo.get('image');
    currentName = hodInfo.get('fullName');
    currentUPMID = hodInfo.get('upmid');
    currentEmail = hodInfo.get('email');
    currentWechat = hodInfo.get('wechat');
    currentPhoneNumber = hodInfo.get('phoneNumber');

    FNCtrl.text = currentName!;
    MIDCtrl.text = currentUPMID!;
    PNCtrl.text = currentPhoneNumber!;
    emailCtrl.text = currentEmail!;
    wcCtrl.text = currentWechat!;

    print('getting...');
  }

  @override
  Widget build(BuildContext context) {
    getHODData();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text("Edit Profile",
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
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
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(image ??
                      'https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/def_profIcon3.png?alt=media&token=bfc1368c-d1bb-4b27-af4e-cd7b03bbdb69'),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
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
                            labelText: 'Current Wechat ID',
                            hintText: currentWechat),
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
            email = emailCtrl.text.trim();
            phoneNumber = PNCtrl.text.trim();
            wechat = wcCtrl.text.trim();

            User user = FirebaseAuth.instance.currentUser!;

            await FirebaseFirestore.instance
                .collection("HOD")
                .doc(user.uid)
                .update({
              'fullName': name,
              'upmid': UPMID,
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
