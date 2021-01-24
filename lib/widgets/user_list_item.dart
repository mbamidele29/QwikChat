import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final DocumentSnapshot document;
  final Function openChat;
  final bool addedToGroup;

  const UserListItem(
      {Key key, this.document, this.openChat, this.addedToGroup = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String chatName = document['username'];
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: openChat,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text(
                        chatName.characters
                            .characterAt(0)
                            .toUpperCase()
                            .toString(),
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatName,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          document['email'] ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: .5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  addedToGroup
                      ? Icon(Icons.radio_button_checked_outlined)
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
          Divider(
            height: 10,
          )
        ],
      ),
    );
  }
}
