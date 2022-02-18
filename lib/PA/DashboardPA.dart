import 'package:SSE3151_project/PA/AdviseeList.dart';
import 'package:SSE3151_project/PA/addAdvisee.dart';
import 'package:SSE3151_project/PA/addPost.dart';
import 'package:SSE3151_project/PA/loginPage.dart';
import 'package:SSE3151_project/PA/profile.dart';
import 'package:SSE3151_project/background2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/menu_item.dart';
import '../services/menu_lists.dart';

class dashboardPA extends StatelessWidget {
  const dashboardPA({Key? key}) : super(key: key);

  final text =
      'random-words generates random words for use as sample text. We use it to generate random blog posts when testing Apostrophe.'
      'Cryptographic-quality randomness is NOT the goal, as speed matters for generating sample text and security does not. Math.random() is used.';
  // Stream<QuerySnapshot> get listOfPost {
  //   final CollectionReference postColl = FirebaseFirestore.instance
  //       .collection('Announcement')
  //       .doc('Posts')
  //       .collection('Announcement Lists');
  //   return postColl.snapshots();
  // }
  // Stream<QuerySnapshot> get postListPA {
  //   return FirebaseFirestore.instance
  //       .collection('Announcement')
  //       .doc('Posts')
  //       .collection('Announcement Lists')
  //       .where('postTo', isEqualTo: 'Student')
  //       .snapshots();
  // }
  // Stream<QuerySnapshot> get postList {
  //   return FirebaseFirestore.instance
  //       .collection('Announcement')
  //       .doc('Posts')
  //       .collection('Announcement Lists')
  //       .where('postTo', isEqualTo: 'Student')
  //       .snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    // if (postListPA == postListPA) {
    //   postList = postListPA;
    // }
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Announcement')
            .doc('Posts')
            .collection('Announcement Lists')
            .where('postTo', isEqualTo: 'Academic Advisor')
            .snapshots(),
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.indigo,
                automaticallyImplyLeading: false,
                title: Text(
                  "Dashboard",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                actions: [
                  PopupMenuButton<MenuItem>(
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => [
                      ...MenuLists.itemPALists.map(buildItem).toList(),
                      PopupMenuDivider(),
                      ...MenuLists.itemSecList.map(buildItem).toList(),
                    ],
                    color: Colors.white,
                    // icon: new Icon(Icons.add, color: Colors.amber),
                  ),
                ],
              ),
              body: Background2(
                child: postList(context, snapshot),
                //     Card(
                //   margin: EdgeInsets.all(20),
                //   child: SingleChildScrollView(
                //     child: StreamBuilder<QuerySnapshot>(
                //         stream: FirebaseFirestore.instance
                //             .collection('Announcement')
                //             .doc('Posts')
                //             .collection('Announcement Lists')
                //             .snapshots(),
                //         builder: (context, snapshot) {
                //           return Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: <Widget>[
                //               Container(
                //                 alignment: Alignment.centerLeft,
                //                 padding: EdgeInsets.symmetric(horizontal: 30),
                //                 child: Text(
                //                   "s",
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       color: Color(0xFF2661FA),
                //                       fontSize: 36),
                //                   textAlign: TextAlign.left,
                //                 ),
                //               ),
                //               SizedBox(height: 10),
                //               //add posted announcment here
                //               Card(
                //                 elevation: 10,
                //                 child: Container(
                //                   width: 300,
                //                   padding: EdgeInsets.all(20),
                //                   margin: EdgeInsets.all(5),
                //                   decoration: BoxDecoration(
                //                     color: Colors.white60,
                //                   ),
                //                   // child: postList(context, snapshot),
                //                 ),
                //               ),

                //               Card(
                //                 elevation: 10,
                //                 child: Container(
                //                   // height: 400,
                //                   width: 300,
                //                   padding: EdgeInsets.all(20),
                //                   margin: EdgeInsets.all(5),
                //                   decoration: BoxDecoration(
                //                     color: Colors.white60,
                //                   ),
                //                   child: Column(
                //                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       // Container(
                //                       //   padding: EdgeInsets.symmetric(
                //                       //     vertical: 10,
                //                       //     horizontal: 5,
                //                       //   ),
                //                       //   color: Colors.red[20],
                //                       //   child: Text(
                //                       //     'Assignment1',
                //                       //     style: TextStyle(
                //                       //       fontWeight: FontWeight.bold,
                //                       //       fontStyle: FontStyle.italic,
                //                       //       fontSize: 20,
                //                       //     ),
                //                       //   ),
                //                       // ),
                //                       // SizedBox(height: 30),
                //                       // Container(
                //                       //   child: Text(
                //                       //     '$text',
                //                       //     style: TextStyle(
                //                       //       fontSize: 16,
                //                       //     ),
                //                       //   ),
                //                       // ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Card(
                //                 elevation: 10,
                //                 child: Container(
                //                   width: 300,
                //                   padding: EdgeInsets.all(20),
                //                   margin: EdgeInsets.all(5),
                //                   decoration: BoxDecoration(
                //                     color: Colors.white60,
                //                   ),
                //                   child: Column(
                //                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Container(
                //                         padding: EdgeInsets.symmetric(
                //                           vertical: 10,
                //                           horizontal: 5,
                //                         ),
                //                         color: Colors.red[20],
                //                         child: Text(
                //                           'Assignment1',
                //                           style: TextStyle(
                //                             fontWeight: FontWeight.bold,
                //                             fontStyle: FontStyle.italic,
                //                             fontSize: 20,
                //                           ),
                //                         ),
                //                       ),
                //                       SizedBox(height: 30),
                //                       Container(
                //                         child: Text(
                //                           '$text',
                //                           style: TextStyle(
                //                             fontSize: 16,
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(height: 30),
                //             ],
                //           );
                //         }),
                //   ),
                // ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                child: Container(
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.add,
                    size: 40,
                  ),
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => addPost()));
                },
              ),
            );
          }
        });
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) {
    return PopupMenuItem<MenuItem>(
      value: item,
      child: Row(
        children: [
          Icon(
            item.icon,
            color: Colors.black,
            size: 25,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(item.text),
        ],
      ),
    );
  }

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuLists.itemProfile:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PA_Profile()),
        );
        break;
      case MenuLists.itemAdvisee:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => adviseeList()),
        );
        break;
      case MenuLists.itemLogOut:
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginWidgetPA()),
          (route) => false,
        );
        break;
      default:
    }
  }
}

Widget postList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  return Card(
    margin: EdgeInsets.all(20),
    child: Container(
      width: 350,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white60,
      ),
      child: postDetails(context, snapshot),
    ),
  );
}

Widget postDetails(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  final postList = snapshot.data!.docs.toList();
  // final db = FirebaseFirestore.instance
  //   .collection('Announcement')
  //   .doc('Post')
  //   .collection('Announcement Lists')
  //   .orderBy("index", descending: true)
  //   .get()
  //   .then((snapshot) => snapshot.docs.forEach((value) {
  //         // postDetails(value["postTile"], value["postContent"]);
  //         print(value['postTo']);
  //         if (value['postTo'] == "All" &&
  //             value['postTo'] == "Students Only") {
  //           print('Entered All');
  //           postDetails(value["postTile"], value["postContent"]);
  //         }
  //       }));
  return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 4),
      itemCount: postList.length,
      itemBuilder: ((context, index) {
        return Card(
          elevation: 10,
          child: Container(
            width: 300,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: Text(
                    postList[index]['postTitle'].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                    postList[index]['postContent'].toString(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      }));
}
