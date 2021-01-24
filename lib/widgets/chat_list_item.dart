import 'package:QwikChat/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final DocumentSnapshot document;
  final Function openChat;
  final String chatName;
  final String lastChat;
  final String lastChatTime;
  final bool newMessages;

  const ChatListItem({
    Key key,
    @required this.document,
    @required this.openChat,
    @required this.chatName,
    this.lastChat = "",
    this.lastChatTime = "",
    this.newMessages = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        lastChat.isNotEmpty
                            ? Text(
                                lastChat,
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: .5,
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  newMessages
                      ? Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: CustomColor.color1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "NEW",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
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
