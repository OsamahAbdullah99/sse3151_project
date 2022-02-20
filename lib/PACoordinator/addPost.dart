import 'dashboardPAC.dart';
import 'package:SSE3151_project/background2.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/notiUtils.dart';

class addPost extends StatefulWidget {
  const addPost({Key? key}) : super(key: key);

  @override
  _addPostState createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  final CollectionReference postColl =
      FirebaseFirestore.instance.collection('Announcement');

  String postTitle = '';
  String postContent = '';
  String postTo = '';
  String holder = '';
  String defaultVal = 'Student';
  List<String> toList = ['Student', 'Academic Advisor (PA)'];

  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Add Announcement",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Background2(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 32.0),
              Row(
                children: [
                  Text(
                    'To:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: DropdownButton<String>(
                      value: defaultVal,
                      onChanged: (String? data) async {
                        setState(() {
                          defaultVal = data as String;
                        });
                      },
                      items:
                          toList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 17),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              buildTextField(title: 'Title', ctrl: _titleCtrl),
              SizedBox(height: 20),
              buildTextField(title: 'Content', ctrl: _contentCtrl, maxLines: 9),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          getDropDownItem();

          if (holder == 'Student') {
            postTo = holder;
            postTitle = _titleCtrl.text;
            postContent = _contentCtrl.text;
          } else if (holder == 'Academic Advisor (PA)') {
            postTo = holder;
            postTitle = _titleCtrl.text;
            postContent = _contentCtrl.text;
          } else {
            postTo = holder;
            postTitle = _titleCtrl.text;
            postContent = _contentCtrl.text;
          }

          int index = 0;
          postColl.doc('Current Index').get().then((value) {
            index = value.get('index') + 1;
          });

          postColl.get().then((querysnapshot) {
            if (querysnapshot.docs.isEmpty) {
              addCurrentIndex(1);
              addPost(postTo, postTitle, postContent, 1);
            } else {
              addCurrentIndex(index);
              addPost(postTo, postTitle, postContent, index);
            }
          });
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => dashboardPAC()));
        },
        label: Text('POST',
            style: TextStyle(
              fontSize: 16,
            )),
        icon: Icon(Icons.send_rounded),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  Widget buildTextField({
    required String title,
    required TextEditingController ctrl,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextField(
            controller: ctrl,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0x92FFFFFF),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                //Color(0xFFF0F0F3)
                //Color(0xFF1A2149)
                borderSide: BorderSide(color: Color(0xFFF0F0F3), width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1A2149), width: 2.0),
              ),
            ),
          ),
        ],
      );
  void getDropDownItem() {
    setState(() {
      holder = defaultVal;
    });
  }

  Future addPost(
      String postTo, String postTitle, String postContent, int index) async {
    await postColl.doc('Posts').collection('Announcement Lists').add({
      'postTo': postTo,
      'postTitle': postTitle,
      'postContent': postContent,
      'postIndex': index,
    });
    sendPostNoti();
  }

  Future addCurrentIndex(int index) async {
    return await postColl.doc('Current Index').set({'index': index});
  }

  Future<void> sendPostNoti() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: createUniqueID(),
            channelKey: 'basic_channel',
            title: postTitle,
            body: postContent,
            notificationLayout: NotificationLayout.BigText));
  }
}
