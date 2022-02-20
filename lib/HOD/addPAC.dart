import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addPAC extends StatefulWidget {
  @override
  _addPACState createState() => _addPACState();
}

class _addPACState extends State<addPAC> {
  final user = FirebaseAuth.instance.currentUser;
  String? upmID;
  bool successTVisibility = false;
  bool errorTVisibility = false;
  bool _validate = false;

  final CollectionReference pacInfo =
      FirebaseFirestore.instance.collection('PA Coordinator');
  final MIDCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('PA Coordinator').snapshots(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Text(
                'Add PA Coordinator',
                style: TextStyle(
                    color: Colors.indigo,
                    //Color(0xFFFFC107),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                child: TextField(
                  controller: MIDCtrl,
                  decoration: InputDecoration(
                    hintText: 'Enter UPM-ID ',
                    errorText: _validate ? 'This field cannot be empty' : null,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.9)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(
                        colors: [Color(0xFF4322FF), Color(0xFF295BFF)])),
                child: IconButton(
                  icon: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    upmID = MIDCtrl.text;
                    setState(() {
                      upmID!.isEmpty ? _validate = true : _validate = false;
                    });
                    if (_validate == false) {
                      QuerySnapshot upmID_Stream =
                          await pacInfo.where('upmid', isEqualTo: upmID).get();

                      List<QueryDocumentSnapshot> upmID_StreamList =
                          upmID_Stream.docs;
                      String upm_id = upmID_StreamList.first.get('upmid');
                      String role = upmID_StreamList.first.get('role');
                      String fullName = upmID_StreamList.first.get('fullName');
                      String image = upmID_StreamList.first.get('image');
                      String faculty = upmID_StreamList.first.get('faculty');
                      String dept = upmID_StreamList.first.get('department');
                      String email = upmID_StreamList.first.get('email');
                      String wechat = upmID_StreamList.first.get('wechat');
                      String phoneNumber =
                          upmID_StreamList.first.get('phoneNumber');

                      if (upmID_Stream != null) {
                        setState(() {
                          regPAC(upm_id, role, fullName, image, faculty, dept,
                              email, wechat, phoneNumber);
                          successTVisibility = true;
                        });
                        await Future.delayed(Duration(milliseconds: 500));
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          errorTVisibility = true;
                        });
                        await Future.delayed(Duration(milliseconds: 750));
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 14),
              Visibility(
                  visible: successTVisibility,
                  child: Text(
                    'Successfully Added!',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  )),
              Visibility(
                  visible: errorTVisibility,
                  child: Text(
                    'Invalid UPM-ID',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  )),
            ],
          );
        });
  }

  Future regPAC(
    String upmID,
    String role,
    String name,
    String image,
    String faculty,
    String dept,
    String email,
    String wechat,
    String phoneNumber,
  ) async {
    await FirebaseFirestore.instance
        .collection("PAC_HOD")
        .doc(user?.uid)
        .collection('PAC')
        .doc(upmID)
        .set({
      'role': role,
      'fullName': name,
      'image': image,
      'faculty': faculty,
      'department': dept,
      'email': email,
      'wechat': wechat,
      'phoneNumber': phoneNumber,
    });
  }
}
