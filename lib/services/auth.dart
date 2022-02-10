import 'package:SSE3151_project/student_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database.dart';

class AuthService with ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  studentUser? _userfromFirebase(User user) {
    return user != null ? studentUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<studentUser?> get users {
    return FirebaseAuth.instance
        .authStateChanges()
        .map((User? user) => _userfromFirebase(user!));
  }

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        final user = FirebaseAuth.instance.currentUser!;

        // await DatabaseService(uid: user.uid)
        //     .updateUserGData(googleUser.displayName as String);

        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'fullName': user.displayName,
          'email': user.email,
        });
      });
      // await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}