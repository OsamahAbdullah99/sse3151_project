import 'package:SSE3151_project/PA/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class editProfile_PA extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //controller
  final FNCtrl = TextEditingController();
  final MIDCtrl = TextEditingController();
  final depCtrl = TextEditingController();
  final PNCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final wcCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;

  String? image;
  String? name;
  String? UPMID;
  // String? department;
  // String? faculty;
  String? email;
  String? wechat;
  String? phoneNumber;

  String? currentName;
  String? currentUPMID;
  // String? currentFac;
  // String? currentDep;
  String? currentEmail;
  String? currentWechat;
  String? currentPhoneNumber;

  bool _isObscure = true;

  void setVariable() {
    name = FNCtrl.text;
    UPMID = MIDCtrl.text;

    // department = depCtrl.text;
    email = emailCtrl.text;
    wechat = wcCtrl.text;
    phoneNumber = PNCtrl.text;
  }

  Future getPAData() async {
    final paInfo =
        await FirebaseFirestore.instance.collection('PA').doc(user.uid).get();

    image = paInfo.get('image');
    currentName = paInfo.get('fullName');
    currentUPMID = paInfo.get('upmid');
    // currentFac = paInfo.get('faculty');
    // currentDep = paInfo.get('department');
    currentEmail = paInfo.get('email');
    currentWechat = paInfo.get('wechat');
    currentPhoneNumber = paInfo.get('phoneNumber');

    FNCtrl.text = currentName!;
    MIDCtrl.text = currentUPMID!;
    // depCtrl.text = currentDep!;
    PNCtrl.text = currentPhoneNumber!;
    emailCtrl.text = currentEmail!;
    wcCtrl.text = currentWechat!;

    print('getting...');
  }

  // final List<String> faculties = [
  //   'Faculty of Agriculture',
  //   'Faculty of Forestry',
  //   'Faculty of Veterinary Medicine',
  //   'Faculty of Economics and Management',
  //   'Faculty of Engineering',
  //   'Faculty of Educational Studies',
  //   'Faculty of Science',
  //   'Faculty of Food Science and Technology',
  //   'Faculty of Human Ecology',
  //   'Faculty of Modern Languages and Communication',
  //   'Faculty of Design and Architecture',
  //   'Faculty of Medicine and Health Sciences',
  //   'Faculty of Computer Science and Information Technology',
  //   'Faculty of Biotechnology and Biomolecular Sciences',
  //   'Faculty of Environmental Studies',
  // ];

  // List<String> departments = [];
  // final List<String> f1 = [
  //   'Department Of Crop Science',
  //   'Department of Plant Protection',
  //   'Department of Animal Science',
  //   'Department of Land Management',
  //   'Department of Agri-Business and Bioresources Economics',
  //   'Department of Agriculture Technology and Department of Aquaculture',
  // ];
  // final List<String> f2 = [
  //   'Department of Forestry Science and Biodiversity',
  //   'Department of Natural Resource Industry',
  //   'Department of Nature Parks and Recreation',
  //   'Department of Environment and Natural Resources Section',
  // ];

  // final List<String> f3 = [
  //   'Department of Veterinary Pre Clinical Science',
  //   'Department of Veterinary Pathology & Microbiology',
  //   'Department of Veterinary Clinical Studies',
  //   'Department of Veterinary Laboratory Diagnosis',
  //   'Department of Companion Animal Medicine & Surgery',
  //   'Department of Farm & Exotic Animals Medicine & Surgery',
  // ];
  // final List<String> f4 = [
  //   'Department of Economics',
  //   'Department of Management and Marketing',
  //   'Department of Accounting and Finance',
  // ];
  // final List<String> f5 = [
  //   "Department of Aerospace Engineering",
  //   "Department of Civil Engineering",
  //   "Department of Biological & Agricultural Engineering",
  //   "Department of Electrical & Electronic Engineering",
  //   "Department of Chemical & Environmental Engineering",
  //   "Department of Computer and Communication Systems Engineering",
  //   "Department of Process and Food Engineering",
  // ];
  // final List<String> f6 = [
  //   'Department of Foundations of Education',
  //   'Department of Sport Studies',
  //   'Department of Science and Technical Education',
  //   'Department of Language and Humanities Education',
  //   'Department of Professional Development and Continuing Education',
  //   'Department of Counselor Education and Counseling Psychology',
  // ];
  // final List<String> f7 = [
  //   'Department of Biology',
  //   'Department of Physics',
  //   'Department of Chemistry',
  //   'Department of Mathematics & Statistics',
  // ];
  // final List<String> f8 = [
  //   'Department of Food Science',
  //   'Department of Food Technology',
  //   'Department of Food Management and Service',
  // ];
  // final List<String> f9 = [
  //   'Department of Human Development and Family Studies',
  //   'Department of Social Sciences and Development',
  //   'Department of Resource Management and Consumer Studies',
  //   'Department of Music',
  //   'Department of Government and Civilisation',
  // ];
  // final List<String> f10 = [
  //   'Department of Malay Language',
  //   'Department of English',
  //   'Department of Foreign Languages',
  //   'Department of Communication',
  // ];
  // final List<String> f11 = [
  //   'Department of Landscape Architecture',
  //   'Department of Architecture',
  //   'Department of Industrial Design',
  // ];
  // final List<String> f12 = [
  //   'Department of Biomedical Sciences',
  //   'Department of Nutrition',
  //   'Department of Dietetic',
  //   'Department of Environmental and Occupational Health',
  //   'Department of Nursing',
  //   'Department of Human Anatomy',
  //   'Department of Pathology',
  //   'Department of Medical Microbiology',
  //   'Department of Family Medicine',
  //   'Department of Community Health',
  //   'Department of Obstetric and Gynaecology',
  //   'Department of Paediatrics',
  //   'Department of Radiology',
  //   'Department of Orthopaedics',
  //   'Department of Rehabilitation Medicine',
  //   'Department of Psychiatry',
  //   'Department of Medicine',
  //   'Department of Neurology',
  //   'Department of Surgery',
  //   'Department of Anaesthesia and Intensive Care',
  //   'Department of Urology',
  //   'Department of Ophthalmology',
  //   'Department of Otorhinolaryngology-Head and Neck Surgery',
  // ];
  // final List<String> f13 = [
  //   'Department of Computer Science',
  //   'Department of Multimedia',
  //   'Department of Software Engineering and Information System',
  //   'Department of Communication Technology and Network',
  // ];
  // final List<String> f14 = [
  //   'Department of Microbiology',
  //   'Department of Cell & Molecular Biology',
  //   'Department of Bioprocess Technology',
  //   'Department of Biochemistry',
  // ];
  // final List<String> f15 = [
  //   'Department of Environmental Management',
  //   'Department of Environmental Science',
  // ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getPAData();

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text("Edit Profile",
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.indigoAccent,
              Colors.blue.shade200,
              Colors.white
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(image ??
                      'https://firebasestorage.googleapis.com/v0/b/padvisor-45b73.appspot.com/o/def_profIcon2.png?alt=media&token=b5e1061d-f647-40f5-82bf-5bf55a44d5d7'),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: FNCtrl,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          hintText: currentName,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter a name' : null,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: MIDCtrl,
                        decoration: InputDecoration(
                          labelText: 'UPM-ID',
                          hintText: currentUPMID,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) => val != null && val.length < 6
                            ? 'This field cannot be empty'
                            : null,
                      ),
                      // SizedBox(height: 8),
                      // Container(
                      //   alignment: Alignment.center,
                      //   margin: EdgeInsets.symmetric(horizontal: 40),
                      //   child: DropdownButtonFormField(
                      //     isExpanded: true,
                      //     hint: Text('$currentFac'),
                      //     decoration: InputDecoration(
                      //       labelText: "Faculty",
                      //       labelStyle: TextStyle(color: Colors.black),
                      //     ),
                      //     value: faculty,
                      //     items: faculties.map((faculty) {
                      //       return DropdownMenuItem(
                      //         value: faculty,
                      //         child: Text(faculty),
                      //       );
                      //     }).toList(),
                      //     onChanged: (value) {
                      //       if (value == 'Faculty of Agriculture') {
                      //         departments = f1;
                      //       } else if (value == 'Faculty of Forestry') {
                      //         departments = f2;
                      //       } else if (value == 'Faculty of Veterinary Medicine') {
                      //         departments = f3;
                      //       } else if (value ==
                      //           'Faculty of Economics and Management') {
                      //         departments = f4;
                      //       } else if (value == 'Faculty of Engineering') {
                      //         departments = f5;
                      //       } else if (value == 'Faculty of Educational Studies') {
                      //         departments = f6;
                      //       } else if (value == 'Faculty of Science') {
                      //         departments = f7;
                      //       } else if (value ==
                      //           'Faculty of Food Science and Technology') {
                      //         departments = f8;
                      //       } else if (value == 'Faculty of Human Ecology') {
                      //         departments = f9;
                      //       } else if (value ==
                      //           'Faculty of Modern Languages and Communication') {
                      //         departments = f10;
                      //       } else if (value ==
                      //           'Faculty of Design and Architecture') {
                      //         departments = f11;
                      //       } else if (value ==
                      //           'Faculty of Medicine and Health Sciences') {
                      //         departments = f12;
                      //       } else if (value ==
                      //           'Faculty of Computer Science and Information Technology') {
                      //         departments = f13;
                      //       } else if (value ==
                      //           'Faculty of Biotechnology and Biomolecular Sciences') {
                      //         departments = f14;
                      //       } else if (value == 'Faculty of Environmental Studies') {
                      //         departments = f15;
                      //       } else {
                      //         departments = [];
                      //       }

                      //       department = null;
                      //       faculty = value.toString();
                      //     },
                      //   ),
                      // ),
                      // SizedBox(height: 8),
                      // Container(
                      //   alignment: Alignment.center,
                      //   margin: EdgeInsets.symmetric(horizontal: 40),
                      //   child: DropdownButtonFormField(
                      //       isExpanded: true,
                      //       hint: Text('$currentDep'),
                      //       decoration: InputDecoration(
                      //         labelText: "Department",
                      //         labelStyle: TextStyle(color: Colors.black),
                      //       ),
                      //       value: department,
                      //       items: departments.map((dep) {
                      //         return DropdownMenuItem(
                      //           value: dep,
                      //           child: Text(dep),
                      //         );
                      //       }).toList(),
                      //       onChanged: (value) => department = value.toString()),
                      // ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: emailCtrl,
                        decoration: InputDecoration(
                            labelText: 'Current Email', hintText: currentEmail),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) =>
                            val != null && !EmailValidator.validate(val)
                                ? 'Enter a valid email'
                                : null,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: wcCtrl,
                        decoration: InputDecoration(
                            labelText: 'Current Wechat ID',
                            hintText: currentWechat),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) =>
                            val == null ? 'This field cannot be empty' : null,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: PNCtrl,
                        decoration: InputDecoration(
                            labelText: 'Current Phone Number',
                            hintText: currentPhoneNumber),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) =>
                            val == null ? 'This field cannot be empty' : null,
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.check_rounded,
            size: 40,
          ),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              gradient: new LinearGradient(colors: [
                Color.fromARGB(255, 255, 136, 34),
                Color.fromARGB(255, 255, 177, 41)
              ])),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            name = FNCtrl.text.trim();
            UPMID = MIDCtrl.text.trim();
            // department = depCtrl.text;
            email = emailCtrl.text.trim();
            phoneNumber = PNCtrl.text.trim();
            wechat = wcCtrl.text.trim();

            User user = FirebaseAuth.instance.currentUser!;

            await FirebaseFirestore.instance
                .collection("PA")
                .doc(user.uid)
                .update({
              'fullName': name,
              'upmid': UPMID,
              // 'department': department,
              'email': email,
              'wechat': wechat,
              'phoneNumber': phoneNumber,
            });

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
