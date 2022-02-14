import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './DashboardStudent.dart';
import './new_report.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  late String _value;
   List<int> list_items =[1,2,3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Add new Post",
              style:
              GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewReport())),
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigoAccent, Colors.blue.shade200, Colors.white],
                  // stops: [0.2, 0.8, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            alignment: Alignment.center,

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 100,),

                  Text('Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent, filled: true,
                      border: OutlineInputBorder(),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black87, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Text('Content', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  TextField(
                    maxLines: 6,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),



                  SizedBox(height: 40,),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40.0,
                      width: 40.0,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: new LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: IconButton(
                        icon: Icon(Icons.assignment_turned_in_sharp, color: Colors.white),
                        onPressed: () {
                          print('Pressed');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),



          ),
        )


    );
  }
}
