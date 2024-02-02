import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:chat_repository/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final UserRepository _userRepository;
  final ChatRepository _chatRepository;
  ChatBloc({
    required UserRepository userRepository,
    required ChatRepository chatRepository,
  })  : _chatRepository = chatRepository,
        _userRepository = userRepository,
        super(ChatInitial()) {
    List<MyUser> userList = [];
    List<MyUser> userSeachList = [];

    on<NewChatGetAllUser>((event, emit) async {
      emit(const NewChatGetallUserLoading());
      try {
        userList = await _userRepository.getAllUser();
        emit(NewChatGetallUserSuccess(userList: userList));
      } catch (e) {
        log(e.toString());
        emit(const NewChatGetallUserLoading());
      }
    });
    on<SendChat>((event, emit) async {
      try {
        await _chatRepository.sendMessage(event.chatMessage);
        emit(const SendChatSuccess());
      } catch (e) {
        emit(const SendChatFailed());
      }
    });
    on<GetChat>((event, emit) async {
      emit(const GetChatLoading());
      try {
        // var snapshot =
        //     _chatRepository.getMessage(event.senderId, event.recieverId);
        // snapshot.
        // emit(GetChatSuccess(snapshot));
      } catch (e) {
        emit(const GetChatFailed());
      }
    });
    on<GetAllUserChat>((event, emit) async {
      emit(const GetUserChatLoading());
      try {
        final List<ChatMessage> messageList =
            await _chatRepository.getUserChat(event.userId);
        emit(GetUserChatSuccess(messageList));
      } catch (e) {
        log(e.toString());
        emit(const GetUserChatFailed());
      }
    });

    //* chat search User
    on<SearchUser>((event, emit) {
      userSeachList = [];

      for (var element in userList) {
        if (element.name.contains(event.chatUserSearch)) {
          userSeachList.add(element);
        }
      }

      emit(ChatSearchUserSuccess(userSeachList));
    });
  }
}
