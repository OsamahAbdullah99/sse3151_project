import 'package:flutter/material.dart';

class AdvisoCard extends StatefulWidget {
  const AdvisoCard({Key? key}) : super(key: key);

  @override
  _AdvisoCardState createState() => _AdvisoCardState();
}

class _AdvisoCardState extends State<AdvisoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      margin: EdgeInsets.all(8),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              //onTap: ,
              leading: Icon(
                Icons.people_outline_outlined,
                size: 50,
              ),
              title: Text(
                'name',
                style: TextStyle(fontSize: 15),
              ),
              trailing: PopupMenuButton(
                //onSelected: (item) => onSelected(context, item, docId),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 0,
                        child: Text(
                          'Advisee List',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    PopupMenuItem(
                        value: 1,
                        child: Text(
                          'Archive List',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
