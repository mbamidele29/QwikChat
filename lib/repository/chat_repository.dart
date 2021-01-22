import 'package:QwikChat/interface/chat_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/message_model.dart';

class ChatRepository {
  // @override

  Stream<QuerySnapshot> getChats() {
    return Firestore.instance.collection("users").snapshots();
  }

  // // @override
  sendChat(String chatId, MessageModel message) async {
    Map<String, String> data = message.toMap();
    return Firestore.instance
        .collection("messages")
        .document(chatId)
        .collection("chats")
        .add(data)
        .catchError((e) {
      print(e.toString());
    });
  }

  // // @override
  Stream<QuerySnapshot> getChat(String chatId) {
    return Firestore.instance
        .collection("messages")
        .document(chatId)
        .collection("chats")
        .orderBy("dateSent", descending: true)
        .snapshots();
  }

  createChatRoom(String roomName, chatMap) {
    Firestore.instance
        .collection("chatRoom")
        .document(roomName)
        .setData(chatMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
