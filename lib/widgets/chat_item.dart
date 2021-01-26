import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatItem extends StatelessWidget {
  final int index;
  final bool myMessage;
  final DocumentSnapshot document;

  const ChatItem({Key key, this.index, this.document, this.myMessage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String username = document["username"] ?? "";
    DateTime date = DateTime.parse(document["dateSent"]);

    return Container(
      padding: myMessage
          ? EdgeInsets.only(right: 30, top: 10, bottom: 10)
          : EdgeInsets.only(left: 30, top: 10, bottom: 10),
      child: Align(
        alignment: (myMessage ? Alignment.topRight : Alignment.topLeft),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: myMessage
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))
                  : BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
              color: (myMessage ? Colors.blue[200] : Colors.grey.shade200),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                (!myMessage && username != null && username.isNotEmpty)
                    ? Text(
                        username,
                        style: TextStyle(fontSize: 12),
                      )
                    : SizedBox.shrink(),
                Text(
                  document["message"],
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  timeago.format(date),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            )),
      ),
    );
  }
}
