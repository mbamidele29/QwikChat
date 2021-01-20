class MessageModel {
  int userId;
  String message;
  String dateSent;
  MessageStatus status;

  MessageModel({this.userId, this.message, this.dateSent, this.status});
}

enum MessageStatus { PENDING, SENT }
