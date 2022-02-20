import 'package:SSE3151_project/student/homePage.dart';
import 'package:SSE3151_project/provider/googleSignIn.dart';
import 'package:SSE3151_project/services/utils.dart';
import 'package:SSE3151_project/startPage.dart';
import 'package:SSE3151_project/student/student_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize('resource://drawable/res_noti_app_icon', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      channelDescription: 'Notification channel for basic tests',
      defaultColor: Colors.indigo,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
    NotificationChannel(
      channelKey: 'scheduled_channel',
      channelName: 'Scheduled Notifications',
      channelDescription: 'Notification channel for basic tests',
      defaultColor: Colors.indigo,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
  ]);
  runApp(const MyApp());
  // runApp(
  //   MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(
  //       create: (context) => GoogleSignInProvider(),
  //     ),
  //     // Provider<studentUserData>(
  //     //     create: (context) =>
  //     //         studentUserData(uid: '', name: '', upmid: '', email: '', phoneNumber: 0))
  //   ],
  //   child: MyApp(),
  // ));
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
      home: startLoginPage(),
      //Consumer<GoogleSignInProvider>(builder: (context, notifier, child) {
      //   return notifier.user != null ? Student_Profile() : AuthPage();
      // }),
      // ),
    );
  }
}
