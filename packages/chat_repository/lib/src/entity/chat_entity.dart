import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String chatId;
  final String senderId;
  final String receiverId;
  final String content;
  final Timestamp chatTime;

  const ChatMessageEntity({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.chatTime,
  });

  ///To the Firebase
  Map<String, Object?> toDocument() {
    return {
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'chatTime': chatTime,
    };
  }

  /// From firebase
  static ChatMessageEntity fromDocument(Map<String, dynamic> doc) {
    return ChatMessageEntity(
      chatId: doc['chatId'],
      senderId: doc['senderId'],
      receiverId: doc['receiverId'],
      content: doc['content'],
      chatTime: doc['chatTime'],
    );
  }

  ///'] to String overRide
  @override
  String toString() {
    return '''PostEntity(
        chatId: $chatId,
      senderId: $senderId,
      receiverId: $receiverId,
      content: $content,
      chatTime: $chatTime,''';
  }

  @override
  List<Object?> get props => [
        chatId,
        senderId,
        receiverId,
        content,
        chatTime,
      ];
}
