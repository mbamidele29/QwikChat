import 'package:QwikChat/model/message_model.dart';

class UserModel {
  int id;
  String username;
  String imageUrl;
  List<MessageModel> messages = [];

  UserModel({this.id, this.username, this.imageUrl, this.messages});
}
