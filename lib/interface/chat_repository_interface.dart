import 'package:QwikChat/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IChatRepositoryInterface {
  Stream<QuerySnapshot> getChats({String email});
  void sendChat(
    String chatId,
    Map<String, dynamic> payload,
    MessageModel message,
  );
  Stream<QuerySnapshot> getChat(String chatId);
}
