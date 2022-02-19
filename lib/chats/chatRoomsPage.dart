import 'package:SSE3151_project/background2.dart';
import 'package:SSE3151_project/startPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'chatPage.dart';
import 'chatUtil.dart';
import 'chatUsers.dart';

class ChatRoomsPage extends StatefulWidget {
  const ChatRoomsPage({Key? key}) : super(key: key);

  @override
  _ChatRoomsPageState createState() => _ChatRoomsPageState();
}

class _ChatRoomsPageState extends State<ChatRoomsPage> {
  // bool _error = false;
  bool _initialized = false;
  User? _user;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      await FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (mounted) {
          setState(() {
            _user = user;
          });
        }
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        // _error = true;
      });
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
        radius: 20,
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
    // if (_error) {
    //   return Container();
    // }

    if (!_initialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _user == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const UsersPage(),
                      ),
                    );
                  },
          ),
        ],
        backgroundColor: Colors.indigo,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Chat Rooms'),
      ),
      body: _user == null
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not authenticated'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const startLoginPage(),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            )
          : StreamBuilder<List<types.Room>>(
              stream: FirebaseChatCore.instance.rooms(),
              initialData: const [],
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      bottom: 200,
                    ),
                    child: const Text('No rooms'),
                  );
                }

                return Background2(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final room = snapshot.data![index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                room: room,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Color(0xFF181F44),
                          elevation: 15,
                          margin: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                            side: BorderSide(
                                color: Color(0x15FFFFFF), width: 3.8),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(20),

                            // color: Colors.brown,
                            // padding: const EdgeInsets.symmetric(
                            //   horizontal: 16,
                            //   vertical: 8,
                            // ),
                            child: Row(
                              children: [
                                _buildAvatar(room),
                                Text(
                                  room.name ?? '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                // Chip(

                                //   label: Text(
                                //     room.name ?? '',
                                //     style: TextStyle(
                                //         color: Colors.white, fontSize: 16),
                                //   ),
                                //   backgroundColor: Colors.indigoAccent,
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
