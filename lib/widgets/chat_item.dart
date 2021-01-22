import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final int index;
  final bool myMessage;
  final DocumentSnapshot document;

  const ChatItem({Key key, this.index, this.document, this.myMessage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: myMessage
          ? EdgeInsets.only(right: 30, top: 10, bottom: 10)
          : EdgeInsets.only(left: 30, top: 10, bottom: 10),
      child: Align(
        alignment: (myMessage ? Alignment.topRight : Alignment.topLeft),
        // alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
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
              // color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  document["message"],
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  document["dateSent"],
                  style: TextStyle(fontSize: 12),
                ),
              ],
            )),
      ),
    );
  }
}
