import 'package:SSE3151_project/background2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'chatPage.dart';
import 'chatUtil.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  void _handlePressed(types.User otherUser, BuildContext context) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: 27,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Users'),
      ),
      body: Background2(
        child: StreamBuilder<List<types.User>>(
          stream: FirebaseChatCore.instance.users(),
          initialData: const [],
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No users'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    _handlePressed(user, context);
                  },
                  child: Card(
                    color: Color(0xFF181F44),
                    elevation: 15,
                    margin: EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Color(0x15FFFFFF), width: 3.8),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Wrap(
                        // alignment: WrapAlignment.spaceEvenly,
                        children: [
                          _buildAvatar(user),
                          Chip(
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(10.0),
                            //   // side: BorderSide(
                            //   //     color: Color(0x15FFFFFF), width: 3.8),
                            // ),
                            label: Text(
                              getUserName(user),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            backgroundColor: Colors.indigoAccent,
                          ),
                          // Chip(
                          //   label: Text(
                          //     getUPMID(user),
                          //     style:
                          //         TextStyle(color: Colors.white, fontSize: 16),
                          //   ),
                          //   backgroundColor: Colors.indigoAccent,
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
