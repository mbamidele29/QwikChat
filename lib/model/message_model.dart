class MessageModel {
  String userId;
  String email;
  String message;
  String dateSent;
  MessageStatus status;

  MessageModel(
      {this.userId, this.email, this.message, this.dateSent, this.status});
  Map<String, String> toMap() {
    return {
      "userId": this.userId,
      "email": this.email,
      "message": this.message,
      "dateSent": this.dateSent,
    };
  }
}

enum MessageStatus { PENDING, SENT }
