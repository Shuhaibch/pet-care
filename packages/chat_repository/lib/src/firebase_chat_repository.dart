import 'dart:developer';

import 'package:chat_repository/src/chat_repo.dart';
import 'package:chat_repository/src/entity/entity.dart';
import 'package:chat_repository/src/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChatRepository extends ChatRepository {
  final chatCollection = FirebaseFirestore.instance.collection('message');
  @override
  Stream<QuerySnapshot> getMessage(String senderId, String receiverId) {
    List<String> id = [senderId, receiverId];
    id.sort();
    final String chatroomId = id.join('_');

    try {
      return chatCollection
          .doc(chatroomId)
          .collection('messages')
          .orderBy('chatTime', descending: false)
          .snapshots();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future sendMessage(ChatMessage message) async {
    List<String> id = [message.senderId, message.receiverId];
    id.sort();
    final String chatroomId = id.join('_');
    try {
      await chatCollection
          .doc(chatroomId)
          .collection('messages')
          .add(message.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ChatMessage>> getUserChat(String userId) async {
    try {
      return await chatCollection
          .where(FieldPath.documentId, arrayContains: userId)
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
  Future createNewMessage(ChatMessage message) async {
    List<String> id = [message.senderId, message.receiverId];
    id.sort();
    final String chatroomId = id.join('_');
    try {
      await chatCollection.doc("chatroomId").set({"chatroomId": chatroomId});
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
