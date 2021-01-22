import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final DocumentSnapshot document;
  final Function openChat;

  const ChatListItem({Key key, this.document, this.openChat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              openChat();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['username'] ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
                  )
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
