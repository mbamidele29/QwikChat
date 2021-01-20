import 'user_model.dart';

class ChatModel {
  List<UserModel> _chats;

  ChatModel(_chats);

  get chats => _chats;

  UserModel chat(int id) => _chats[id];
}
