import 'package:chat_repository/chat_repository.dart';

abstract class ChatRepository {
  Future sendMessage(ChatMessage message);
  Future <List<ChatMessage>> getMessage(String senderId);
}
