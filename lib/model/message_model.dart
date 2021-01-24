class MessageModel {
  String userId;
  String username;
  String message;
  String dateSent;
  MessageStatus status;

  MessageModel(
      {this.userId, this.username, this.message, this.dateSent, this.status});
  Map<String, String> toMap() {
    return {
      "userId": this.userId,
      "username": this.username,
      "message": this.message,
      "dateSent": this.dateSent,
    };
  }
}

enum MessageStatus { PENDING, SENT }
