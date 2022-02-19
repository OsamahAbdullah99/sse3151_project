import 'package:SSE3151_project/student/reports.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './DashboardStudent.dart';
import './new_post.dart';

class NewReport extends StatefulWidget {
  const NewReport({Key? key}) : super(key: key);

  @override
  _NewReportState createState() => _NewReportState();
}

class _NewReportState extends State<NewReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.transparent,
          title: Text("Add new Report",
              style:
              GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Reports())),
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
                  ElevatedButton(

                    child: Text('Upload Document'),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,

                      primary: Colors.orange[600],
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    onPressed: () {
                      print('Pressed');
                    },

                  ),
                  SizedBox(height: 40,),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
                    child: Container(
                      // alignment: Alignment.bottomRight,
                      // height: 40.0,
                      // width: 40.0,
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