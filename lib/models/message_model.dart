import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? senderId;
  String? recieverId;
  Timestamp? dateTime;
  String? message;

  MessageModel({
    this.recieverId,
    this.senderId,
    this.dateTime,
    this.message,
  });

  MessageModel.fromjson(Map<String, dynamic> json) {
    recieverId = json['recieverId'];
    senderId = json['senderId'];

    dateTime = json['dateTime'] ?? '';
    message = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "recieverId": recieverId,
      "dateTime": dateTime,
      "text": message,
    };
  }
}
