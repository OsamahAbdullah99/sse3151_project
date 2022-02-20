import 'package:SSE3151_project/services/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class RegisterWidgetHOD extends StatefulWidget {
  const RegisterWidgetHOD({Key? key}) : super(key: key);

  @override
  _RegisterWidgetHODState createState() => _RegisterWidgetHODState();
}

class _RegisterWidgetHODState extends State<RegisterWidgetHOD> {
  final formKey = GlobalKey<FormState>();
  final FNCtrl = TextEditingController();
  final MIDCtrl = TextEditingController();
  final PNCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final wcCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String? _faculty;
  final List<String> faculties = [
    'Faculty of Agriculture',
    'Faculty of Forestry',
    'Faculty of Veterinary Medicine',
    'Faculty of Economics and Management',
    'Faculty of Engineering',
    'Faculty of Educational Studies',
    'Faculty of Science',
    'Faculty of Food Science and Technology',
    'Faculty of Human Ecology',
    'Faculty of Modern Languages and Communication',
    'Faculty of Design and Architecture',
    'Faculty of Medicine and Health Sciences',
    'Faculty of Computer Science and Information Technology',
    'Faculty of Biotechnology and Biomolecular Sciences',
    'Faculty of Environmental Studies',
  ];

  String? _dep;
  List<String> departments = [];
  final List<String> f1 = [
    'Department Of Crop Science',
    'Department of Plant Protection',
    'Department of Animal Science',
    'Department of Land Management',
    'Department of Agri-Business and Bioresources Economics',
    'Department of Agriculture Technology and Department of Aquaculture',
  ];
  final List<String> f2 = [
    'Department of Forestry Science and Biodiversity',
    'Department of Natural Resource Industry',
    'Department of Nature Parks and Recreation',
    'Department of Environment and Natural Resources Section',
  ];

  final List<String> f3 = [
    'Department of Veterinary Pre Clinical Science',
    'Department of Veterinary Pathology & Microbiology',
    'Department of Veterinary Clinical Studies',
    'Department of Veterinary Laboratory Diagnosis',
    'Department of Companion Animal Medicine & Surgery',
    'Department of Farm & Exotic Animals Medicine & Surgery',
  ];
  final List<String> f4 = [
    'Department of Economics',
    'Department of Management and Marketing',
    'Department of Accounting and Finance',
  ];
  final List<String> f5 = [
    "Department of Aerospace Engineering",
    "Department of Civil Engineering",
    "Department of Biological & Agricultural Engineering",
    "Department of Electrical & Electronic Engineering",
    "Department of Chemical & Environmental Engineering",
    "Department of Computer and Communication Systems Engineering",
    "Department of Process and Food Engineering",
  ];
  final List<String> f6 = [
    'Department of Foundations of Education',
    'Department of Sport Studies',
    'Department of Science and Technical Education',
    'Department of Language and Humanities Education',
    'Department of Professional Development and Continuing Education',
    'Department of Counselor Education and Counseling Psychology',
  ];
  final List<String> f7 = [
    'Department of Biology',
    'Department of Physics',
    'Department of Chemistry',
    'Department of Mathematics & Statistics',
  ];
  final List<String> f8 = [
    'Department of Food Science',
    'Department of Food Technology',
    'Department of Food Management and Service',
  ];
  final List<String> f9 = [
    'Department of Human Development and Family Studies',
    'Department of Social Sciences and Development',
    'Department of Resource Management and Consumer Studies',
    'Department of Music',
    'Department of Government and Civilisation',
  ];
  final List<String> f10 = [
    'Department of Malay Language',
    'Department of English',
    'Department of Foreign Languages',
    'Department of Communication',
  ];
  final List<String> f11 = [
    'Department of Landscape Architecture',
    'Department of Architecture',
    'Department of Industrial Design',
  ];
  final List<String> f12 = [
    'Department of Biomedical Sciences',
    'Department of Nutrition',
    'Department of Dietetic',
    'Department of Environmental and Occupational Health',
    'Department of Nursing',
    'Department of Human Anatomy',
    'Department of Pathology',
    'Department of Medical Microbiology',
    'Department of Family Medicine',
    'Department of Community Health',
    'Department of Obstetric and Gynaecology',
    'Department of Paediatrics',
    'Department of Radiology',
    'Department of Orthopaedics',
    'Department of Rehabilitation Medicine',
    'Department of Psychiatry',
    'Department of Medicine',
    'Department of Neurology',
    'Department of Surgery',
    'Department of Anaesthesia and Intensive Care',
    'Department of Urology',
    'Department of Ophthalmology',
    'Department of Otorhinolaryngology-Head and Neck Surgery',
  ];
  final List<String> f13 = [
    'Department of Computer Science',
    'Department of Multimedia',
    'Department of Software Engineering and Information System',
    'Department of Communication Technology and Network',
  ];
  final List<String> f14 = [
    'Department of Microbiology',
    'Department of Cell & Molecular Biology',
    'Department of Bioprocess Technology',
    'Department of Biochemistry',
  ];
  final List<String> f15 = [
    'Department of Environmental Management',
    'Department of Environmental Science',
  ];

  @override
  void dispose() {
    FNCtrl.dispose();
    MIDCtrl.dispose();
    PNCtrl.dispose();
    emailCtrl.dispose();
    wcCtrl.dispose();
    passwordCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: FNCtrl,
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (fullName) =>
                                fullName != null && fullName.length < 6
                                    ? 'Enter a full name'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: MIDCtrl,
                            decoration: InputDecoration(
                                labelText: "Staff ID",
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "eg. AZ8192"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (id) => id != null && id.length < 6
                                ? 'Enter UPM-ID'
                                : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: "Faculty",
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            value: _faculty,
                            items: faculties.map((faculty) {
                              return DropdownMenuItem(
                                value: faculty,
                                child: Text(faculty),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == 'Faculty of Agriculture') {
                                departments = f1;
                              } else if (value == 'Faculty of Forestry') {
                                departments = f2;
                              } else if (value ==
                                  'Faculty of Veterinary Medicine') {
                                departments = f3;
                              } else if (value ==
                                  'Faculty of Economics and Management') {
                                departments = f4;
                              } else if (value == 'Faculty of Engineering') {
                                departments = f5;
                              } else if (value ==
                                  'Faculty of Educational Studies') {
                                departments = f6;
                              } else if (value == 'Faculty of Science') {
                                departments = f7;
                              } else if (value ==
                                  'Faculty of Food Science and Technology') {
                                departments = f8;
                              } else if (value == 'Faculty of Human Ecology') {
                                departments = f9;
                              } else if (value ==
                                  'Faculty of Modern Languages and Communication') {
                                departments = f10;
                              } else if (value ==
                                  'Faculty of Design and Architecture') {
                                departments = f11;
                              } else if (value ==
                                  'Faculty of Medicine and Health Sciences') {
                                departments = f12;
                              } else if (value ==
                                  'Faculty of Computer Science and Information Technology') {
                                departments = f13;
                              } else if (value ==
                                  'Faculty of Biotechnology and Biomolecular Sciences') {
                                departments = f14;
                              } else if (value ==
                                  'Faculty of Environmental Studies') {
                                departments = f15;
                              } else {
                                departments = [];
                              }
                              setState(() {
                                _dep = null;
                                _faculty = value.toString();
                              });
                            },
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: "Department",
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            value: _dep,
                            items: departments.map((dep) {
                              return DropdownMenuItem(
                                value: dep,
                                child: Text(dep),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => _dep = value.toString()),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: emailCtrl,
                            decoration: InputDecoration(
                                labelText: "Email Address",
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "eg. name@upm.edu.my"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: wcCtrl,
                            decoration: InputDecoration(
                                labelText: "Wechat ID",
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "eg. syna09"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (wechat) =>
                                wechat != null && wechat.length < 1
                                    ? 'This field cannot be empty'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: PNCtrl,
                            decoration: InputDecoration(
                                labelText: "Office Number",
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: "eg. 0397014301"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (phoneNumber) =>
                                phoneNumber != null && phoneNumber.length < 10
                                    ? 'This field cannot be empty'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            controller: passwordCtrl,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (password) =>
                                password != null && password.length < 8
                                    ? 'Enter min. 8 characters'
                                    : null,
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              signUp();
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(0)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ))),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              width: size.width * 0.5,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  gradient: new LinearGradient(colors: [
                                    Color.fromARGB(255, 255, 136, 34),
                                    Color.fromARGB(255, 255, 177, 41)
                                  ])),
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                "SIGN UP",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already Have an Account? ',
                        style: TextStyle(
                          color: Color(0xFF2661FA),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Color(0xFF2661FA)),
                          ),
                        ],
                      ),
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

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    final String fullName = FNCtrl.text.trim();
    final String id = MIDCtrl.text.trim();
    final String department = _dep!;
    final String faculty = _faculty!;
    final String email = emailCtrl.text.trim();
    final String phoneNumber = PNCtrl.text.trim();
    final String wechat = wcCtrl.text.trim();
    final String password = passwordCtrl.text.trim();

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = FirebaseAuth.instance.currentUser!;

      await FirebaseFirestore.instance.collection("HOD").doc(user.uid).set({
        'uid': user.uid,
        'fullName': fullName,
        'upmid': id,
        'faculty': faculty,
        'department': department,
        'email': email,
        'wechat': wechat,
        'phoneNumber': phoneNumber,
        'role': 'Head of Department (HOD)',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/def_profIcon3.png?alt=media&token=bfc1368c-d1bb-4b27-af4e-cd7b03bbdb69',
      });
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: fullName,
          id: credential.user!.uid,
          imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/def_profIcon3.png?alt=media&token=bfc1368c-d1bb-4b27-af4e-cd7b03bbdb69?u=$id',
        ),
      );
      print('Successfully register a HOD');
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
