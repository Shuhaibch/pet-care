part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class NewChatGetAllUser extends ChatEvent {
  @override
  List<Object> get props => [];
}

class SendChat extends ChatEvent {
  final ChatMessage chatMessage;

  const SendChat({required this.chatMessage});
  @override
  List<Object> get props => [chatMessage];
}

class GetAllUserChat extends ChatEvent {
  final String userId;

  const GetAllUserChat({required this.userId});
}

class GetChat extends ChatEvent {
  final String senderId;
  final String recieverId;

  const GetChat(
    this.senderId,
    this.recieverId,
  );
  @override
  List<Object> get props => [senderId, recieverId];
}

class SearchUser extends ChatEvent {
  final String chatUserSearch;

  const SearchUser({required this.chatUserSearch});
}
