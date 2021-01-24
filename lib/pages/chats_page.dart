import 'package:QwikChat/controller/chat_controller.dart';
import 'package:QwikChat/controller/user_controller.dart';
import 'package:QwikChat/model/user_model.dart';
import 'package:QwikChat/util/color.dart';
import 'package:QwikChat/widgets/chat_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  UserController _userController;
  ChatController _chatController;

  UserModel _user;
  Stream<QuerySnapshot> chats;

  getChats({String email}) {
    Stream<QuerySnapshot> ret = _chatController.getChats(email: email);
    setState(() {
      chats = ret;
    });
  }

  setUp() async {
    _userController = UserController();
    UserModel user = await _userController.getUser();
    setState(() {
      _user = user;
    });
    _chatController = ChatController();
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getChats(email: _user.email);
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
              onPressed: () async {
                await _userController.signout();
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
        child: _user == null
            ? SpinKitCircle(
                color: CustomColor.color1,
              )
            : StreamBuilder(
                stream: chats,
                builder: (ctx, snapshot) {
                  if (snapshot.hasData && snapshot.data.documents.length > 0) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (ctx1, index) {
                          DocumentSnapshot data =
                              snapshot.data.documents[index];
                          String chatName = data["groupName"];
                          String lastMessageFrom =
                              data["lastMessageFrom"] ?? "";
                          List<dynamic> users = data["participants"];

                          if (chatName == null || chatName.isEmpty) {
                            if (users != null && users.length == 2) {
                              for (dynamic item in users) {
                                String email = _user.email ?? "";
                                if (item.toString().compareTo(email) != 0)
                                  chatName = item.toString();
                              }
                            }
                          }
                          return ChatListItem(
                            chatName: chatName,
                            document: data,
                            newMessages:
                                lastMessageFrom.compareTo(_user.email) != 0,
                            openChat: () {
                              Map<String, dynamic> map = {
                                "user": _user,
                                "document": data,
                              };
                              Navigator.pushNamed(context, "/chat",
                                  arguments: map);
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Start chatting by clicking on the add button",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
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
