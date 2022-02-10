import 'package:SSE3151_project/homepage.dart';
import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/services/utils.dart';
import 'package:SSE3151_project/student_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(const MyApp());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
      ),
      // Provider<studentUserData>(
      //     create: (context) =>
      //         studentUserData(uid: '', name: '', upmid: '', email: '', phoneNumber: 0))
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        //   create: (context) => GoogleSignInProvider(),
        //   child:
        MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      title: 'PAdvisor',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //Consumer<GoogleSignInProvider>(builder: (context, notifier, child) {
      //   return notifier.user != null ? Student_Profile() : AuthPage();
      // }),
      // ),
    );
  }
}
