// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../entity/entity.dart';

class ChatMessage extends Equatable {
  final String chatId;
  final String senderId;
  final String receiverId;
  final String content;
  final Timestamp chatTime;
  const ChatMessage({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.chatTime,
  });

  /// Empty Chat
  static final empty = ChatMessage(
    chatId: '',
    senderId: '',
    receiverId: '',
    content: '',
    chatTime: Timestamp.now(),
  );

  /// Copy Post Methord
  ChatMessage copyWith({
    String? chatId,
    String? senderId,
    String? receiverId,
    String? content,
    Timestamp? chatTime,
  }) {
    return ChatMessage(
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      chatTime: chatTime ?? this.chatTime,
    );
  }

  /// Convienent getter to determine wheather the post is empty
  bool get isEmpty => this == ChatMessage.empty;

  /// Convienent getter to determine wheather the post is not empty
  bool get isNotEmpty => this != ChatMessage.empty;

  /// From Local to Firebase
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      chatId: chatId,
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      chatTime: chatTime,
    );
  }

  /// From firebase To local
  static ChatMessage fromEntity(ChatMessageEntity entity) {
    return ChatMessage(
      chatId: entity.chatId,
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      content: entity.content,
      chatTime: entity.chatTime,
    );
  }
 factory ChatMessage.fromDocumentSnapshot(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ChatMessage(
      chatId: data['chatId']??'',
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      content: data['content'] ?? '',
      chatTime: data['chatTime'] ?? Timestamp.now(),
    );
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
