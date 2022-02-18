import 'package:SSE3151_project/background2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class archivedList extends StatefulWidget {
  const archivedList({Key? key}) : super(key: key);

  @override
  _archivedListState createState() => _archivedListState();
}

final user = FirebaseAuth.instance.currentUser;

class _archivedListState extends State<archivedList> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance
        .collection('Archived_Advisee')
        .doc(user?.uid)
        .collection('students');
    final CollectionReference studentInfo =
        FirebaseFirestore.instance.collection('students');

    return Scaffold(
      appBar: AppBar(
        title: Text('Archived'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
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
                              QuerySnapshot upmID_Stream = await studentInfo
                                  .where('upmid', isEqualTo: upmid)
                                  .get();
                              List<QueryDocumentSnapshot> upmID_StreamList =
                                  upmID_Stream.docs;
                              String upm_id =
                                  upmID_StreamList.first.get('upmid');
                              String cohort =
                                  upmID_StreamList.first.get('cohort');
                              String role = upmID_StreamList.first.get('role');
                              String fullName =
                                  upmID_StreamList.first.get('fullName');
                              String image =
                                  upmID_StreamList.first.get('image');
                              String faculty =
                                  upmID_StreamList.first.get('faculty');
                              String dept =
                                  upmID_StreamList.first.get('department');
                              String semester =
                                  upmID_StreamList.first.get('semester');
                              String email =
                                  upmID_StreamList.first.get('email');
                              String wechat =
                                  upmID_StreamList.first.get('wechat');
                              String phoneNumber =
                                  upmID_StreamList.first.get('phoneNumber');

                              FirebaseFirestore.instance
                                  .collection('Archived_Advisee')
                                  .doc(user?.uid)
                                  .collection('students')
                                  .doc(upm_id)
                                  .delete();

                              FirebaseFirestore.instance
                                  .collection("Advisee_Advisor")
                                  .doc(user?.uid)
                                  .collection('students')
                                  .doc(upm_id)
                                  .set({
                                'upmid': upm_id,
                                'cohort': cohort,
                                'role': role,
                                'fullName': fullName,
                                'image': image,
                                'semester': semester,
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
                            label: 'Unarchive',
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
                          subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(doc.get('fullName')),
                                Text(doc.get('cohort'))
                              ]),
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
    );
  }
}
