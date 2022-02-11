import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class sendEmailPage extends StatefulWidget {
  const sendEmailPage({Key? key}) : super(key: key);

  @override
  _sendEmailPageState createState() => _sendEmailPageState();
}

class _sendEmailPageState extends State<sendEmailPage> {
  final toCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Sender'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(title: 'To', ctrl: toCtrl),
            SizedBox(height: 16),
            buildTextField(title: 'Subject', ctrl: subjectCtrl),
            SizedBox(height: 16),
            buildTextField(title: 'Message', ctrl: msgCtrl, maxLines: 8),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => launchEmail(
          toEmail: toCtrl.text,
          subject: subjectCtrl.text,
          message: msgCtrl.text,
        ),
        label: Text('SEND',
            style: TextStyle(
              fontSize: 16,
            )),
        icon: Icon(Icons.send_rounded),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  Widget buildTextField({
    required String title,
    required TextEditingController ctrl,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextField(
            controller: ctrl,
            maxLines: maxLines,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      );

  Future launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
