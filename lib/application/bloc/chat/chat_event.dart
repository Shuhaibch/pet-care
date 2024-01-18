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

class GetChat extends ChatEvent {
  final String usersIds;

  const GetChat({required this.usersIds});
  @override
  List<Object> get props => [usersIds];
}
