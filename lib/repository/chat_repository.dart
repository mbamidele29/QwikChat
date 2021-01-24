import 'package:QwikChat/interface/chat_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/message_model.dart';

class ChatRepository implements IChatRepositoryInterface {
  @override
  Stream<QuerySnapshot> getChats({String email}) {
    return Firestore.instance
        .collection("chats")
        .where("participants", arrayContains: email)
        .orderBy("dateSent", descending: true)
        .snapshots();
  }

  @override
  void sendChat(
    String chatId,
    Map<String, dynamic> payload,
    MessageModel message,
  ) async {
    if (chatId.contains("null")) return;
    Firestore.instance
        .collection("chats")
        .document(chatId)
        .setData(payload)
        .catchError(
      (e) {
        Fluttertoast.showToast(msg: e.toString());
      },
    );

    Map<String, String> data = message.toMap();
    Firestore.instance
        .collection("chats")
        .document(chatId)
        .collection("conversations")
        .add(data)
        .catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  @override
  Stream<QuerySnapshot> getChat(String chatId) {
    return Firestore.instance
        .collection("chats")
        .document(chatId)
        .collection("conversations")
        .orderBy("dateSent", descending: true)
        .snapshots();
  }
}
