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
                    return new Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: (BuildContext context) async {
                            String upmid = doc.get('upmid');
                            QuerySnapshot matricStream = await studentInfo
                                .where('upmid', isEqualTo: upmid)
                                .get();
                            List<QueryDocumentSnapshot> matricStreamList =
                                matricStream.docs;
                            String upm_id = matricStreamList.first.get('upmid');
                            String fullName =
                                matricStreamList.first.get('fullName');

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
                                .set({'upmid': upm_id, 'fullName': fullName});
                          },
                          autoClose: true,
                          backgroundColor: Color(0xFF434BC0),
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Unarchive',
                        )
                      ]),
                      child: Card(
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
