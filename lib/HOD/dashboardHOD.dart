import 'package:SSE3151_project/background2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../chats/chatRoomsPage.dart';
import '../services/menu_item.dart';
import '../services/menu_lists.dart';
import 'addPost.dart';
import 'loginPage.dart';
import 'pacList.dart';
import 'profile.dart';

class dashboardHOD extends StatelessWidget {
  const dashboardHOD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Announcement')
            .doc('Posts')
            .collection('Announcement Lists')
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
                      ...MenuLists.itemHODLists.map(buildItem).toList(),
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
          MaterialPageRoute(builder: (context) => HOD_Profile()),
        );
        break;
      case MenuLists.itemPAC:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => pacList()),
        );
        break;
      case MenuLists.itemChat:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ChatRoomsPage()),
        );
        break;
      case MenuLists.itemLogOut:
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginWidgetHOD()),
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

  return Container(
    margin: EdgeInsets.all(5),
    child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 15),
        itemCount: postList.length,
        itemBuilder: ((context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
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
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: Text(
                      postList[index]['postTitle'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(height: 20, color: Colors.black),
                  Container(
                    child: Text(
                      postList[index]['postContent'],
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
        })),
  );
}
