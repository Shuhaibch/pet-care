import 'dart:developer';

import 'package:bloc/bloc.dart';
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
    on<NewChatGetAllUser>((event, emit) async {
      emit(const NewChatGetallUserLoading());
      try {
        final List<MyUser> userList = await _userRepository.getAllUser();
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
  }
}
