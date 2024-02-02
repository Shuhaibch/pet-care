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
  final DocumentSnapshot snapshot;

  const GetChatSuccess(this.snapshot);
  @override
  List<Object> get props => [snapshot];
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
//* Get User Chat
class GetUserChatSuccess extends ChatState {
  final List<ChatMessage> messageList;

  const GetUserChatSuccess(this.messageList);
  @override
  List<Object> get props => [messageList];
}

class GetUserChatFailed extends ChatState {
  const GetUserChatFailed();
  @override
  List<Object> get props => [];
}

class GetUserChatLoading extends ChatState {
  const GetUserChatLoading();
  @override
  List<Object> get props => [];
}
//* chat search user
class ChatSearchUserSuccess extends ChatState {
  final List<MyUser> userList;

  const ChatSearchUserSuccess(this.userList);
  @override
  List<Object> get props => [userList];
}

class ChatSearchUserFailed extends ChatState {
  const ChatSearchUserFailed();
  @override
  List<Object> get props => [];
}

class ChatSearchUserLoading extends ChatState {
  const ChatSearchUserLoading();
  @override
  List<Object> get props => [];
}
