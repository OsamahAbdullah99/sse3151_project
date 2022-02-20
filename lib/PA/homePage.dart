import 'package:SSE3151_project/PA/DashboardPA.dart';
import 'package:SSE3151_project/PA/loginPage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//trial test connection with firebase
class HomePage_PA extends StatefulWidget {
  const HomePage_PA({Key? key}) : super(key: key);

  @override
  State<HomePage_PA> createState() => _HomePage_PAState();
}

class _HomePage_PAState extends State<HomePage_PA> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Allow Notifications'),
                  content: Text('Our app would like to send you notifications'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Don\'t Allow',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => AwesomeNotifications()
                          .requestPermissionToSendNotifications()
                          .then((_) => Navigator.pop(context)),
                      child: Text(
                        'Allow',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ));
      }
    });

    // AwesomeNotifications().createdStream.listen((noti) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text('Notification Created on ${noti.channelKey}')));
    // });

    // AwesomeNotifications().actionStream.listen((event) {
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (_) => dashboardPA()),
    //       (route) => route.isFirst);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return dashboardPA();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something Went Wrong'));
          } else {
            return LoginWidgetPA();
          }
        },
      ),
    );
  }
}
