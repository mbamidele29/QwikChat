import 'package:QwikChat/model/message_model.dart';
import 'package:QwikChat/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatController {
  final ChatRepository _chatRepository = ChatRepository();

  Stream<QuerySnapshot> getChats({String email}) {
    return _chatRepository.getChats(email: email);
  }

  Stream<QuerySnapshot> getChat(String chatId) {
    return _chatRepository.getChat(chatId);
  }

  sendMessage(
      {@required String senderId,
      @required String username,
      @required String chatId,
      @required String groupName,
      @required List<dynamic> participants,
      @required String message}) {
    final DateTime now = DateTime.now();

    Map<String, dynamic> payload = {
      "groupName": groupName,
      "dateSent": now.toString(),
      "participants": participants,
    };
    MessageModel obj = MessageModel(
        userId: senderId,
        username: participants.length > 2 ? username : "",
        message: message,
        dateSent: now.toString());
    return _chatRepository.sendChat(chatId, payload, obj);
  }
}
