import 'package:QwikChat/controller/chat_controller.dart';
import 'package:QwikChat/controller/user_controller.dart';
import 'package:QwikChat/model/user_model.dart';
import 'package:QwikChat/widgets/user_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  UserModel _user;
  UserController _userController;
  ChatController _chatController;
  TextEditingController _groupNameController = TextEditingController();

  Map<String, DocumentSnapshot> addedUsers = {};

  setUp() async {
    _userController = UserController();
    _chatController = ChatController();
    UserModel user = await _userController.getUser();
    setState(() {
      _user = user;
    });
  }

  Stream<QuerySnapshot> _users;
  searchUsername(String username) {
    Stream<QuerySnapshot> ret = _userController.getUsers(username: username);
    setState(() {
      _users = ret;
    });
  }

  createGroup(
      {@required BuildContext context,
      @required String groupName,
      @required String chatId}) {
    List<String> participants = [];
    for (DocumentSnapshot document in addedUsers.values) {
      participants.add(document["email"]);
    }
    if (!addedUsers.containsKey(_user.id)) participants.add(_user.email);
    _chatController.sendMessage(
      senderId: _user.id,
      username: _user.username,
      chatId: chatId,
      groupName: groupName,
      participants: participants,
      message: "Created group",
    );
    Fluttertoast.showToast(msg: "group has been created");
    Navigator.pop(context);
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Group",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                String groupName = _groupNameController.text.trim();
                if (groupName.isEmpty) {
                  Fluttertoast.showToast(msg: "Group name cannot be empty");
                } else {
                  String chatId = _user.id +
                      groupName.replaceAll(" ", "_").replaceAll("-", "_");
                  createGroup(
                      context: ctx, groupName: groupName, chatId: chatId);
                }
              }),
        ],
      ),
      body: Container(
        width: MediaQuery.of(ctx).size.width,
        height: MediaQuery.of(ctx).size.height,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1.5),
                    color: Colors.grey,
                    blurRadius: 3,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: TextField(
                onChanged: (username) {
                  if (username.trim().isNotEmpty) searchUsername(username);
                },
                decoration: InputDecoration(
                  hintText: "Search username",
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                (addedUsers.length == 0 || addedUsers.length > 1)
                    ? "${addedUsers.length} users added"
                    : "${addedUsers.length} user added",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: _users,
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.documents.length > 0) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (ctx1, index) {
                              DocumentSnapshot data =
                                  snapshot.data.documents[index];
                              String userId = data["uid"];
                              return UserListItem(
                                document: data,
                                addedToGroup: addedUsers.containsKey(userId),
                                openChat: () {
                                  Map<String, DocumentSnapshot> state =
                                      addedUsers;
                                  if (state.containsKey(userId))
                                    state.remove(userId);
                                  else
                                    state[userId] = data;

                                  setState(() {
                                    addedUsers = state;
                                  });
                                },
                              );
                            }),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "user not found",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  }),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1.5),
                    color: Colors.grey,
                    blurRadius: 3,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: TextField(
                controller: _groupNameController,
                decoration: InputDecoration(
                  hintText: "Enter Group Name",
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
