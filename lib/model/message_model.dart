class MessageModel {
  String userId;
  String message;
  String dateSent;
  MessageStatus status;

  MessageModel({this.userId, this.message, this.dateSent, this.status});
  Map<String, String> toMap() {
    return {
      "userId": this.userId,
      "message": this.message,
      "dateSent": this.dateSent,
    };
  }
}

enum MessageStatus { PENDING, SENT }
