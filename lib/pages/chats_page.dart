import 'package:QwikChat/controller/chat_controller.dart';
import 'package:QwikChat/controller/user_controller.dart';
import 'package:QwikChat/widgets/chat_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final UserController userController = UserController();
  final ChatController chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QwikChat",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                userController.signout();
                Navigator.pushReplacementNamed(context, "/");
              }),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black45,
              Colors.black12,
            ],
            stops: [0.6, 0.6],
          ),
        ),
        child: StreamBuilder(
            stream: chatController.getChats(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData && snapshot.data.documents.length > 1) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (ctx1, index) {
                        DocumentSnapshot data = snapshot.data.documents[index];
                        if (data["uid"] == userController.user.id)
                          return SizedBox();
                        else
                          return ChatListItem(
                            document: data,
                            openChat: () {
                              Map<String, dynamic> map = {
                                "uid": userController.user.id,
                                "document": data,
                              };
                              Navigator.pushNamed(context, "/chat",
                                  arguments: map);
                            },
                          );
                      }),
                );
              } else {
                return Center(
                  child: Text(
                    "You are the only registered user",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("/users");
        },
      ),
    );
  }
}
