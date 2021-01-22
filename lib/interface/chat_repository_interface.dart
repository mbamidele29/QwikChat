import 'package:QwikChat/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IChatRepositoryInterface {
  Stream<QuerySnapshot> getChats();
  // Stream<QuerySnapshot> getChat(String chatId, messageMap);
  Future<List<MessageModel>> sendChat(String token, MessageModel message);
}
