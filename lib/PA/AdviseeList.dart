import 'package:SSE3151_project/PA/addAdvisee.dart';
import 'package:SSE3151_project/PA/archivedList.dart';
import 'package:SSE3151_project/PA/showStudentProfile.dart';
import 'package:SSE3151_project/background2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../services/menu_item.dart';
import '../services/menu_lists.dart';

class adviseeList extends StatefulWidget {
  const adviseeList({Key? key}) : super(key: key);

  @override
  _adviseeListState createState() => _adviseeListState();
}

final user = FirebaseAuth.instance.currentUser;

class _adviseeListState extends State<adviseeList> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance
        .collection('Advisee_Advisor')
        .doc(user?.uid)
        .collection('students');
    final CollectionReference studentInfo =
        FirebaseFirestore.instance.collection('students');

    // Future getAdviseeLists() async {
    //   Query<Map<String, dynamic>> advisees =
    //       FirebaseFirestore.instance.collection('Advisee_Advisor').orderBy('field');
    //   DocumentSnapshot snapshot = await advisees
    //       .doc(user?.uid)
    //       .collection('student')
    //       .doc(user?.uid)
    //       .get();
    //   var data = snapshot.data() as Map;
    //   var adviseeData = data['student'] as List<dynamic>;
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Advisee List'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          // TextButton.icon(
          //   style: TextButton.styleFrom(primary: Colors.black),
          //   icon: const Icon(Icons.person_add_alt_1_rounded),
          //   label: const Text('Add'),
          //   onPressed: () => _showPanel(),
          // ),
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => archivedList())),
              icon: Icon(Icons.archive_rounded)),
          // PopupMenuButton<MenuItem>(
          //   onSelected: (item) => onSelected(context, item),
          //   itemBuilder: (context) => [
          //     ...MenuLists.itemAdviseeLists.map(buildItem).toList(),
          //   ],
          //   color: Color.fromARGB(255, 206, 214, 255),
          //   //Color.fromARGB(255, 206, 214, 255),
          //   //Color.fromARGB(255, 166, 173, 211)
          // ),
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
                                .collection('Advisee_Advisor')
                                .doc(user?.uid)
                                .collection('students')
                                .doc(upm_id)
                                .delete();

                            FirebaseFirestore.instance
                                .collection("Archived_Advisee")
                                .doc(user?.uid)
                                .collection('students')
                                .doc(upm_id)
                                .set({'upmid': upm_id, 'fullName': fullName});
                          },
                          autoClose: true,
                          backgroundColor: Color(0xFF434BC0),
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Archive',
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
                          // title: Text(doc.get('upmid')),
                          // subtitle: Text(doc.get('fullName')),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => showStudentProfile()));
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

  // PopupMenuItem<MenuItem> buildItem(MenuItem item) {
  //   return PopupMenuItem<MenuItem>(
  //     value: item,
  //     child: Row(
  //       children: [
  //         Icon(
  //           item.icon,
  //           color: Colors.black,
  //           size: 25,
  //         ),
  //         const SizedBox(
  //           width: 12,
  //         ),
  //         Text(item.text),
  //       ],
  //     ),
  //   );
  // }

  // void onSelected(BuildContext context, MenuItem item) {
  //   switch (item) {
  //     case MenuLists.itemAddAdvisee:
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(builder: (context) => _showPanel()),
  //       // );
  //       Navigator.of(context).push(
  //         MaterialPageRoute(builder: (context) {
  //           return GestureDetector(
  //             onTap: () {
  //               showModalBottomSheet(
  //                   context: context,
  //                   builder: (context) {
  //                     return Container(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 20.0, horizontal: 60.0),
  //                       child: addAdvisee(),
  //                     );
  //                   });
  //             },
  //           );
  //         }),
  //       );
  //       //        Navigator.push(context, MaterialPageRoute<bool>(
  //       // builder: (BuildContext context) {
  //       //   return Center(
  //       //     child: GestureDetector(
  //       //       child: Text('OK'),
  //       //       onTap: ));}));
  //       break;
  //     // case MenuLists.itemArchivedAdvisee:
  //     //   Navigator.of(context).push(
  //     //     MaterialPageRoute(builder: (context) => adviseeList()),
  //     //   );
  //     //   break;
  //     default:
  //   }
  // }

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
            child: addAdvisee(),
          );
        });
  }
}
