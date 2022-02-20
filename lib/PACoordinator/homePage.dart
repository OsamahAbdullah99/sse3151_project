import 'loginPage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashboardPAC.dart';

class HomePage_PAC extends StatefulWidget {
  const HomePage_PAC({Key? key}) : super(key: key);

  @override
  _HomePage_PACState createState() => _HomePage_PACState();
}

class _HomePage_PACState extends State<HomePage_PAC> {
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
            return dashboardPAC();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something Went Wrong'));
          } else {
            return LoginWidgetPAC();
          }
        },
      ),
    );
  }
}
