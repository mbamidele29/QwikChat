import 'package:QwikChat/controller/chat_controller.dart';
import 'package:QwikChat/controller/user_controller.dart';
import 'package:QwikChat/model/user_model.dart';
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
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    DocumentSnapshot document = arguments["document"];

    String chatName = document["groupName"] ?? document["username"];
    List<dynamic> users = document["participants"];
    String chatId = arguments["chatId"];
    UserModel user = arguments["user"];

    if (chatName == null || chatName.isEmpty) {
      if (users != null && users.length == 2) {
        for (dynamic item in users) {
          if (item.toString().compareTo(user.username) != 0)
            chatName = item.toString();
        }
      }
    }

    if (users != null && users.length > 2) {
      chatName = "$chatName - ${users.length} participants";
    }

    getChats(chatId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with $chatName"),
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
                              myMessage: data["userId"]
                                      .toString()
                                      .compareTo(user.id) ==
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
                    icon: Icon(Icons.send),
                    onPressed: () {
                      String message = _messageController.text.trim();
                      List<dynamic> participants =
                          users ?? [user.email, document["email"].toString()];
                      if (message.isNotEmpty) {
                        chatController.sendMessage(
                          groupName: document["groupName"] ?? "",
                          senderId: user.id,
                          email: user.email,
                          chatId: chatId,
                          participants: participants,
                          message: message,
                        );
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
