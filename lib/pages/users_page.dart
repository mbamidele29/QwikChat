import 'package:QwikChat/controller/user_controller.dart';
import 'package:QwikChat/model/user_model.dart';
import 'package:QwikChat/widgets/user_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  UserController _userController;
  UserModel _user;

  setUp() async {
    _userController = UserController();
    UserModel user = await _userController.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Users",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
            stream: _userController.getUsers(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData && snapshot.data.documents.length > 1) {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (ctx1, index) {
                      DocumentSnapshot data = snapshot.data.documents[index];
                      if (data["uid"] == _user.id)
                        return SizedBox();
                      else {
                        String chatId = "";
                        if (_user.id.compareTo(data["uid"].toString()) > 0) {
                          chatId = data["uid"].toString() + "_" + _user.id;
                        } else {
                          chatId = _user.id + "_" + data["uid"].toString();
                        }
                        return UserListItem(
                          document: data,
                          openChat: () {
                            Map<String, dynamic> map = {
                              "chatId": chatId,
                              "user": _user,
                              "document": data,
                            };
                            Navigator.pushNamed(context, "/chat",
                                arguments: map);
                          },
                        );
                      }
                    });
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
        onPressed: () {
          Navigator.pushNamed(context, "/create_group");
        },
        child: Icon(Icons.people),
      ),
    );
  }
}
