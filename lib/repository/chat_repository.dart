import 'package:QwikChat/interface/chat_repository_interface.dart';
import '../model/chat_model.dart';
import '../model/message_model.dart';
import '../util/api.dart';
import '../util/network.dart';

class ChatRepository implements IChatRepositoryInterface {
  @override
  Future<List<MessageModel>> sendChat(
      String token, MessageModel message) async {
    String url = API.sendChatUrl;
    Map<String, dynamic> data = await Network.callAPI(
        url: url,
        networkAction: NetworkAction.POST,
        payload: {
          "message": message,
        });

    if (data != null) {
      return null;
    }
    return null;
  }

  @override
  Future<List<MessageModel>> getChat(String token, int userId) async {
    return null;
  }

  @override
  Future<ChatModel> getChats(String token) async {
    String url = API.getChatsUrl;
    Map<String, dynamic> data = await Network.callAPI(
        url: url, networkAction: NetworkAction.POST, token: token);

    if (data != null) {
      return null;
    }
    return null;
  }
}
