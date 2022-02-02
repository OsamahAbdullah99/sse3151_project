import 'package:flutter/material.dart';
import 'background.dart';
class dashboardPA extends StatelessWidget {
  const dashboardPA({ Key? key }) : super(key: key);


final text = 'random-words generates random words for use as sample text. We use it to generate random blog posts when testing Apostrophe.' 
'Cryptographic-quality randomness is NOT the goal, as speed matters for generating sample text and security does not. Math.random() is used.';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue[300]),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Dashboard", style: TextStyle(color: Colors.blue),),
        centerTitle: true,
      ),
      body: Background(
        child: Card(
          margin: EdgeInsets.all(20) ,
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
                          fontSize: 36
                      ),
                      textAlign: TextAlign.left,
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
                               horizontal: 5,),
                               color: Colors.red[20],
                             child: Text(
                               'Assignment1',
          
                               style: TextStyle(
                                 fontWeight:FontWeight.bold,
                                 fontStyle: FontStyle.italic,
                                 fontSize: 20,
                                 ),
                               ),
                           ),
                           SizedBox(height:30),
                
                           Container(
                             child: Text(
                               '$text',
                               style: TextStyle(fontSize: 16,),
          
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
                               horizontal: 5,),
                               color: Colors.red[20],
                             child: Text(
                               'Assignment1',
          
                               style: TextStyle(
                                 fontWeight:FontWeight.bold,
                                 fontStyle: FontStyle.italic,
                                 fontSize: 20,
                                 ),
                               ),
                           ),
                           SizedBox(height:30),
                
                           Container(
                             child: Text(
                               '$text',
                               style: TextStyle(fontSize: 16,),
                               ),
                               ),
                         ],
                      ),
                    ),
                  ),
                   SizedBox(height:30),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       FloatingActionButton(
                         onPressed: null,
                         elevation: 6,
                         backgroundColor: Colors.lightGreen,
                        child: new Icon(Icons.add),
                       )
        
                    ],
                  )
        
                   ],
            ),
          ),
        ),

      ),
      
    );
  }
}