import 'dart:developer';

import 'package:chat_repository/src/chat_repo.dart';
import 'package:chat_repository/src/entity/chat_entity.dart';
import 'package:chat_repository/src/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChatRepository extends ChatRepository {
  final chatCollection = FirebaseFirestore.instance.collection('message');
  @override
  Future<List<ChatMessage>> getMessage(String senderId) async {
    try {
      return await chatCollection
          .where('senderId', isEqualTo: senderId)
          .get()
          .then((value) => value.docs
              .map((e) => ChatMessage.fromEntity(
                  ChatMessageEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future sendMessage(ChatMessage message) async {
    try {
      await chatCollection.doc().set(message.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
