import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../pdfViewerPage.dart';
import '../services/firebase_file.dart';
import './new_report.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final user = FirebaseAuth.instance.currentUser;
  String? upmid;
  late Future<List<FirebaseFile>> futureFiles;
  // File? file;

  @override
  void initState() {
    super.initState();

    futureFiles = listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.transparent,
        title: Text("Reports",
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _Refresh,
        child: FutureBuilder<List<FirebaseFile>>(
            future: futureFiles,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('Some error occured!'));
                  } else {
                    final files = snapshot.data!;

                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.indigoAccent,
                              Colors.blue.shade200,
                              Colors.white
                            ],
                            // stops: [0.2, 0.8, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 120,
                            ),
                            CircleAvatar(
                              radius: 70,
                              child: ClipRRect(
                                child: Image.asset('assets/images/avatar.png'),
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 90),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 5),
                                    Expanded(
                                      child: ListView.separated(
                                          padding: EdgeInsets.all(18),
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 20),
                                          itemCount: files.length,
                                          itemBuilder: (context, index) {
                                            final file = files[index];
                                            return Slidable(
                                              endActionPane: ActionPane(
                                                  motion: ScrollMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      spacing: 5,
                                                      onPressed: ((context) {
                                                        deleteFile(file);
                                                      }),
                                                      autoClose: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.delete,
                                                      label: 'Delete',
                                                    ),
                                                  ]),
                                              child: buildFile(context, file),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('ADD REPORT'),
        elevation: 3,
        focusElevation: 60,
        focusColor: Colors.white,
        backgroundColor: Colors.orange[600],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewReport()));
        },
      ),
    );
  }

  Widget imageView(BuildContext context, FirebaseFile file) {
    final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        backgroundColor: Color(0xB7000000),
        //Color(0xB7000000),
        //Color(0xDD000000),
        centerTitle: true,
      ),
      body: isImage
          ? Image.network(
              file.url,
              height: double.infinity,
              fit: BoxFit.cover,
            )
          : Center(
              child: Text(
                'Cannot be displayed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => ElevatedButton(
        onPressed: () {
          final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);
          final isPDF = ['.pdf'].any(file.name.contains);
          if (isImage) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => imageView(context, file)));
          } else if (isPDF) {
            loadPDF(file);
          }
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ))),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: 350,
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: new LinearGradient(colors: [
                Color.fromARGB(255, 255, 136, 34),
                Color.fromARGB(255, 255, 177, 41)
              ])),
          padding: const EdgeInsets.all(0),
          child: Text(
            file.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );

  Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  // and then in advisee profile, get the file through upmid too from the long list. Try to link them
  Future<List<FirebaseFile>> listAll() async {
    final studentInfo = await FirebaseFirestore.instance
        .collection('students')
        .doc(user?.uid)
        .get();
    if (mounted) {
      setState(() {
        upmid = studentInfo.data()!['upmid'];
      });
    }
    final coll = FirebaseStorage.instance.ref('reports/$upmid/');
    final result = await coll.listAll();

    final urls = await _getDownloadLinks(result.items);
    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  Future deleteFile(FirebaseFile ref) async {
    final studentInfo = await FirebaseFirestore.instance
        .collection('students')
        .doc(user?.uid)
        .get();
    if (mounted) {
      setState(() {
        upmid = studentInfo.data()!['upmid'];
        print(upmid);
      });
    }

    try {
      await FirebaseStorage.instance.ref('reports/$upmid/${ref.name}').delete();
      setState(() {});
    } on FirebaseException catch (e) {
      return null;
    }
  }

  // Future loadPDF(FirebaseFile ref) async {
  //   final studentInfo = await FirebaseFirestore.instance
  //       .collection('students')
  //       .doc(user?.uid)
  //       .get();
  //   if (mounted) {
  //     setState(() {
  //       upmid = studentInfo.data()!['upmid'];
  //       print(upmid);
  //     });
  //   }
  //   try {
  //     final refPDF =
  //         FirebaseStorage.instance.ref().child('reports/$upmid/${ref.name}');
  //     final bytes = await refPDF.getData();
  //     String url = '${ref.name}';
  //     // await _storeFile(url, bytes!);
  //     openPDF(context, file);
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // void openPDF(BuildContext context, File file) => Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => PDFViewerPage()),
  //     );

  Future loadPDF(FirebaseFile ref) async {
    final studentInfo = await FirebaseFirestore.instance
        .collection('students')
        .doc(user?.uid)
        .get();
    if (mounted) {
      setState(() {
        upmid = studentInfo.data()!['upmid'];
        print(upmid);
      });
    }
    try {
      final url = 'reports/$upmid/${ref.name}';

      final file = await loadFirebase(url);
      if (file == null) return;
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => PDFViewerPage(context, file)),
      // );
      // PDFViewerPage(context, file: file);
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(context, file: file)),
      );
    } catch (e) {
      return null;
    }
  }

  Future loadFirebase(String url) async {
    try {
      final refPDF = FirebaseStorage.instance.ref().child(url);
      final bytes = await refPDF.getData();

      return _storeFile(url, bytes!);
    } catch (e) {
      return null;
    }
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = path.basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  //     Future<File> loadPDF(String url) async {
  //       try {
  //     final refPDF = FirebaseStorage.instance.ref().child(url);
  //     final bytes = await refPDF.getData();

  //     return _storeFile(url, bytes);
  //   } catch (e) {
  //     return null;
  //   }
  // }

  //pull to refresh
  Future<Null> _Refresh() {
    return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => Reports(),
            transitionDuration: Duration(seconds: 0)));
  }
}
