import 'package:QwikChat/model/message_model.dart';
import 'package:QwikChat/model/user_model.dart';
import 'package:QwikChat/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController {
  final ChatRepository _chatRepository = ChatRepository();

  Stream<QuerySnapshot> getChats() {
    return _chatRepository.getChats();
  }

  Stream<QuerySnapshot> getChat(String chatId) {
    return _chatRepository.getChat(chatId);
  }

  sendMessage(String userId, String chatId, String message) {
    final DateTime now = DateTime.now();
    MessageModel obj = MessageModel(
        userId: userId, message: message, dateSent: now.toString());
    return _chatRepository.sendChat(chatId, obj);
  }
}
