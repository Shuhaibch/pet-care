part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

//* GEt User New Chat
class NewChatGetallUserSuccess extends ChatState {
  final List<MyUser> userList;

  const NewChatGetallUserSuccess({required this.userList});
  @override
  List<Object> get props => [userList];
}

class NewChatGetallUserFailed extends ChatState {
  const NewChatGetallUserFailed();
  @override
  List<Object> get props => [];
}

class NewChatGetallUserLoading extends ChatState {
  const NewChatGetallUserLoading();
  @override
  List<Object> get props => [];
}

//* Sent New Chat
class SendChatSuccess extends ChatState {
  const SendChatSuccess();
  @override
  List<Object> get props => [];
}

class SendChatFailed extends ChatState {
  const SendChatFailed();
  @override
  List<Object> get props => [];
}

class SendChatLoading extends ChatState {
  const SendChatLoading();
  @override
  List<Object> get props => [];
}

//* Get Chat
class GetChatSuccess extends ChatState {
  final List<ChatMessage> chatList;

  const GetChatSuccess({required this.chatList});
  @override
  List<Object> get props => [chatList];
}

class GetChatFailed extends ChatState {
  const GetChatFailed();
  @override
  List<Object> get props => [];
}

class GetChatLoading extends ChatState {
  const GetChatLoading();
  @override
  List<Object> get props => [];
}
