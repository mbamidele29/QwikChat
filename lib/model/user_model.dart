import 'message_model.dart';

class UserModel {
  int id;
  String username;
  String profilePicture;
  List<MessageModel> messages = [];

  UserModel({this.id, this.username, this.profilePicture, this.messages});

  factory UserModel.fromJson(Map<String, String> json) {
    return UserModel(
        id: int.parse(json["id"]),
        username: json["username"],
        profilePicture: json["profilePicture"]);
  }
}
