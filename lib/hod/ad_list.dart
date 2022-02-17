import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'advisor_card.dart';

class AdList extends StatefulWidget {
  const AdList({Key? key}) : super(key: key);

  @override
  _AdListState createState() => _AdListState();
}

class _AdListState extends State<AdList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          backgroundColor: Colors.transparent,
          title: Text("List Advisor",
              style:
              GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
        ),
      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigoAccent, Colors.blue.shade200, Colors.white],
              // stops: [0.2, 0.8, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 700,
              child: Container(
                child: Column(
                  children: [
                    AdvisoCard(),
                    AdvisoCard(),
                    AdvisoCard(),

                  ],
                ),

                  ),
            ),
          ],
        ),
    ),
      ),
    );
  }
}
