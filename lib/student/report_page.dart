import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Report_page extends StatefulWidget {
  const Report_page({ Key? key }) : super(key: key);

  @override
  _Report_pageState createState() => _Report_pageState();
}

class _Report_pageState extends State<Report_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 2,
          backgroundColor: Colors.transparent,
          title: Text("Report1",
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.w600)),
          centerTitle: true,
              ),
              body: Container(
                decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.indigoAccent,
                      Colors.blue.shade200,
                      Colors.white
                    ],
                    // stops: [0.2, 0.8, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                    ),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                    height: 120,
                ),
                
                    Card(
                      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ), 
                      elevation: 10,
            child: Container(
              //width: 300,
              
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white60,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                          //   padding: EdgeInsets.symmetric(
                          // vertical: 10,
                          // horizontal: 5,),
                            child: Text(
                              "Internet Problem",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            ),
                          ),
                          Divider(height: 20,color: Colors.black,),
                          Container(
                            padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,),
                    child: Text(
                      'Slow Internet connections or limited access from homes in rural'
                      'areas can contribute to students falling behind academically'
                       'according to a new report from Michigan State University'
                        'Quello Center. The educational setbacks can have significant'
                        'impacts on academic success, college admissions and career opportunities.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                        ],
                      ),
                      
                    ),


                    )],
                ),
              ),
              ),
      
    );
  }
}