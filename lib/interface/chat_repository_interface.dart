import 'package:QwikChat/model/chat_model.dart';
import 'package:QwikChat/model/message_model.dart';

abstract class IChatRepositoryInterface {
  Future<ChatModel> getChats(String token);
  Future<List<MessageModel>> getChat(String token, int userId);
  Future<List<MessageModel>> sendChat(String token, MessageModel message);
}
