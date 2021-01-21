import 'message_model.dart';

class UserModel {
  String id;
  String email;
  String username;
  String profilePicture;
  List<MessageModel> messages = [];

  UserModel(
      {this.id, this.username, this.email, this.profilePicture, this.messages});
}
