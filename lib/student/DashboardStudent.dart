import 'package:SSE3151_project/background2.dart';
import 'package:SSE3151_project/services/menu_item.dart';
import 'package:SSE3151_project/services/menu_lists.dart';
import 'package:SSE3151_project/student/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';

class dashboardStudent extends StatelessWidget {
  const dashboardStudent({Key? key}) : super(key: key);

  final text =
      'random-words generates random words for use as sample text. We use it to generate random blog posts when testing Apostrophe.'
      'Cryptographic-quality randomness is NOT the goal, as speed matters for generating sample text and security does not. Math.random() is used.';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
              ...MenuLists.itemLists.map(buildItem).toList(),
              PopupMenuDivider(),
              ...MenuLists.itemSecList.map(buildItem).toList(),
            ],
            color: Colors.white,
            // icon: new Icon(Icons.add, color: Colors.amber),
          ),
          // TextButton(
          //     onPressed: () {
          //       // final provider =
          //       //     Provider.of<GoogleSignInProvider>(context, listen: false);
          //       // provider.logout();
          //       FirebaseAuth.instance.signOut();
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => LoginWidget(
          //                   // onClickedSignUp: () {},
          //                   )));
          //     },
          //     child: Image.asset(
          //       'assets/images/logoutIcon.png',
          //       scale: 20,
          //     )),
        ],
      ),
      body: Background2(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 27),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 10,
                  child: Container(
                    // height: 400,
                    width: 300,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          color: Colors.red[20],
                          child: Text(
                            'Assignment1',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: Text(
                            '$text',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          color: Colors.red[20],
                          child: Text(
                            'Assignment1',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: Text(
                            '$text',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
          MaterialPageRoute(builder: (context) => Student_Profile()),
        );
        break;
      case MenuLists.itemLogOut:
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginWidget()),
          (route) => false,
        );
        break;
      default:
    }
  }
}
