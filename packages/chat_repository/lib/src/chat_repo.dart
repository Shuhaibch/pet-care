import 'package:chat_repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {
  Future sendMessage(ChatMessage message);
  Stream<QuerySnapshot> getMessage(String senderId, String receiverId);
  Future createNewMessage(ChatMessage message);
  Future<List<ChatMessage>> getUserChat(String userId);
}
