import 'package:SSE3151_project/background2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'addPA.dart';
import 'archivedList.dart';

class paList extends StatefulWidget {
  const paList({Key? key}) : super(key: key);

  @override
  _paListState createState() => _paListState();
}

final user = FirebaseAuth.instance.currentUser;

class _paListState extends State<paList> {
  String? wsLink;
  String? wcLink;
  final toCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance
        .collection('PA_PAC')
        .doc(user?.uid)
        .collection('PA');
    final CollectionReference paInfo =
        FirebaseFirestore.instance.collection('PA');

    return Scaffold(
      appBar: AppBar(
        title: Text('PA List'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => archivedList())),
              icon: Icon(Icons.archive_rounded)),
        ],
      ),
      body: Background2(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: db.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return Card(
                      margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
                      child: new Slidable(
                        endActionPane:
                            ActionPane(motion: BehindMotion(), children: [
                          SlidableAction(
                            onPressed: (BuildContext context) async {
                              String upmid = doc.get('upmid');
                              QuerySnapshot upmID_Stream = await paInfo
                                  .where('upmid', isEqualTo: upmid)
                                  .get();
                              List<QueryDocumentSnapshot> upmID_StreamList =
                                  upmID_Stream.docs;
                              String upm_id =
                                  upmID_StreamList.first.get('upmid');

                              String role = upmID_StreamList.first.get('role');
                              String fullName =
                                  upmID_StreamList.first.get('fullName');
                              String image =
                                  upmID_StreamList.first.get('image');
                              String faculty =
                                  upmID_StreamList.first.get('faculty');
                              String dept =
                                  upmID_StreamList.first.get('department');
                              String email =
                                  upmID_StreamList.first.get('email');
                              String wechat =
                                  upmID_StreamList.first.get('wechat');
                              String phoneNumber =
                                  upmID_StreamList.first.get('phoneNumber');

                              FirebaseFirestore.instance
                                  .collection('PA_PAC')
                                  .doc(user?.uid)
                                  .collection('PA')
                                  .doc(upm_id)
                                  .delete();

                              FirebaseFirestore.instance
                                  .collection("Archived_PA")
                                  .doc(user?.uid)
                                  .collection('PA')
                                  .doc(upm_id)
                                  .set({
                                'upmid': upm_id,
                                'role': role,
                                'fullName': fullName,
                                'image': image,
                                'faculty': faculty,
                                'department': dept,
                                'email': email,
                                'wechat': wechat,
                                'phoneNumber': phoneNumber,
                              });
                            },
                            autoClose: true,
                            backgroundColor: Color(0xFF434BC0),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          )
                        ]),
                        child: ListTile(
                          title: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: 5,
                              ),
                              Text(doc.get('upmid')),
                            ],
                          ),
                          subtitle: Text(doc.get('fullName')),
                          onTap: () async {
                            String upmid = doc.get('upmid');
                            QuerySnapshot upmID_Stream = await paInfo
                                .where('upmid', isEqualTo: upmid)
                                .get();
                            List<QueryDocumentSnapshot> upmID_StreamList =
                                upmID_Stream.docs;
                            String upm_id = upmID_StreamList.first.get('upmid');
                            String fullName =
                                upmID_StreamList.first.get('fullName');
                            String image = upmID_StreamList.first.get('image');
                            String faculty =
                                upmID_StreamList.first.get('faculty');
                            String dept =
                                upmID_StreamList.first.get('department');
                            String email = upmID_StreamList.first.get('email');
                            String wechat =
                                upmID_StreamList.first.get('wechat');
                            String phoneNumber =
                                upmID_StreamList.first.get('phoneNumber');

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => showPAProfile(
                                    upm_id,
                                    fullName,
                                    faculty,
                                    dept,
                                    image,
                                    email,
                                    wechat,
                                    phoneNumber)));
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.person_add_alt_1_rounded,
            size: 30,
          ),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              gradient: new LinearGradient(colors: [
                Color.fromARGB(255, 255, 136, 34),
                Color.fromARGB(255, 255, 177, 41)
              ])),
        ),
        onPressed: () {
          _showPanel();
        },
      ),
    );
  }

  _showPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
            height: 230, //200
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: addPA(),
          );
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: true, forceSafariVC: true, enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  //start of developing for PA's profile
  Future getPAProfile(
      String upm_id,
      String fullName,
      String faculty,
      String dept,
      String image,
      String email,
      String wechat,
      String phoneNumber) async {
    final db = await FirebaseFirestore.instance
        .collection('PA_PAC')
        .doc(user?.uid)
        .collection('PA')
        .doc(upm_id)
        .get();
    setState(() {
      upm_id = db.data()!['upmid'];
      fullName = db.data()!['fullName'];
      image = db.data()!['image'];
      faculty = db.data()!['faculty'];
      dept = db.data()!['department'];
      email = db.data()!['email'];
      wechat = db.data()!['wechat'];
      phoneNumber = db.data()!['phoneNumber'];

      wsLink = "https://wa.me/" + phoneNumber;
      wcLink = "https://web.wechat.com/" + wechat;
    });
  }

  showPAProfile(String upm_id, String fullName, String faculty, String dept,
      String image, String email, String wechat, String phoneNumber) {
    getPAProfile(
        upm_id, fullName, faculty, dept, image, email, wechat, phoneNumber);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Profile",
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
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
        padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(image),
                ),
              ],
            ),
            Divider(
              height: 50,
              thickness: 0.6,
              color: Colors.black,
            ),
            Row(
              children: [
                Text('Name: ',
                    style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text(fullName,
                    style: TextStyle(
                        color: Colors.indigo,
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('UPM-ID: ',
                    style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text(upm_id,
                    style: TextStyle(
                        color: Colors.indigo,
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Email: ',
                    style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Text(email,
                      style: TextStyle(
                          color: Colors.indigo,
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Divider(
              height: 50,
              thickness: 0.6,
              color: Colors.black,
            ),
            Row(
              children: [
                Text('Faculty: ',
                    style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Flexible(
                    child: Text(faculty,
                        style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Department: ',
                    style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Flexible(
                    child: Text(dept,
                        style: TextStyle(
                            color: Colors.indigo,
                            letterSpacing: 2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
              ],
            ),
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      onPressed: () {
                        _launchURL(wsLink!);
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Image.asset(
                              'assets/images/ws.png',
                            )),
                      )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      onPressed: () {
                        _launchURL(wcLink!);
                      },
                      child: Card(
                        elevation: 10,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Image.asset(
                            'assets/images/wechat.png',
                          ),
                        ),
                      )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                      onPressed: () {
                        // _launchURL(emailLink!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    sendEmailtoPAPage(upm_id, email)));
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.email_rounded,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //start of developing for sending email to respective PA
  Future getPAEmail(String upm_id, String email) async {
    final db = await FirebaseFirestore.instance
        .collection('PA_PAC')
        .doc(user?.uid)
        .collection('PA')
        .doc(upm_id)
        .get();
    setState(() {
      upm_id = db.data()!['upmid'];
      email = db.data()!['email'];

      toCtrl.text = email;
    });
  }

  sendEmailtoPAPage(String upm_id, String email) {
    getPAEmail(upm_id, email);
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
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        );
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Sender'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(title: 'To', ctrl: toCtrl),
            SizedBox(height: 16),
            buildTextField(title: 'Subject', ctrl: subjectCtrl),
            SizedBox(height: 16),
            buildTextField(title: 'Message', ctrl: msgCtrl, maxLines: 8),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => launchEmail(
          toEmail: toCtrl.text,
          subject: subjectCtrl.text,
          message: msgCtrl.text,
        ),
        label: Text('SEND',
            style: TextStyle(
              fontSize: 16,
            )),
        icon: Icon(Icons.send_rounded),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  Future launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
