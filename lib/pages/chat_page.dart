import 'package:QwikChat/controller/chat_controller.dart';
import 'package:QwikChat/controller/user_controller.dart';
import 'package:QwikChat/model/message_model.dart';
import 'package:QwikChat/widgets/chat_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final UserController userController = UserController();
  final ChatController chatController = ChatController();
  final TextEditingController _messageController = TextEditingController();

  Stream<QuerySnapshot> chats;

  getChats(String chatId) {
    Stream<QuerySnapshot> ret = chatController.getChat(chatId);
    setState(() {
      chats = ret;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    DocumentSnapshot document = data["document"];

    String userId = data["uid"];
    String chatId = "";
    if (userId.compareTo(document["uid"].toString()) > 0) {
      chatId = document["uid"].toString() + "_" + userId;
    } else {
      chatId = userId + "_" + document["uid"].toString();
    }
    getChats(chatId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with ${data["document"]["username"]}"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: chats,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.documents.length > 0) {
                      return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data =
                                snapshot.data.documents[index];
                            return ChatItem(
                              index: index,
                              myMessage:
                                  data["userId"].toString().compareTo(userId) ==
                                      0,
                              document: data,
                            );
                          });
                    } else {
                      return Center(
                        child: Container(
                          child: Text("Send a message to start chat"),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 4,
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Message",
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  IconButton(
                    // color: CustomColor.color1,
                    icon: Icon(Icons.send),
                    onPressed: () {
                      String message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        chatController.sendMessage(userId, chatId, message);
                        _messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
