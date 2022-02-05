import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/services/database.dart';
import 'package:SSE3151_project/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _formKey = GlobalKey<FormState>();
  // final user = FirebaseAuth.instance.currentUser!;

  String? _currentName;
  String? _currentEmail;
  String? _currentUPMID;
  String? _currentPN;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData? userData = snapshot.data;
                return Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text("Edit Profile",
                        style: GoogleFonts.poppins(
                            fontSize: 25, fontWeight: FontWeight.w600)),
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
                          colors: [
                            Colors.indigoAccent,
                            Colors.blue.shade200,
                            Colors.white
                          ],
                          // stops: [0.2, 0.8, 1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   radius: 40,
                        //   backgroundImage: NetworkImage(user.photoURL!),
                        // ),
                        // SizedBox(height: 8),
                        // Padding(
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        //   child: TextFormField(
                        //     initialValue: user.displayName!,
                        //     style: TextStyle(fontSize: 16),
                        //     decoration:
                        //         InputDecoration(border: OutlineInputBorder()),
                        //   ),
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
                      ],
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  Future editProfile() async {
    User user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      'uid': user.uid,
      'fullName': user.displayName,
      'id': '',
      'email': user.email,
      'phoneNumber': '',
    });
  }
}
