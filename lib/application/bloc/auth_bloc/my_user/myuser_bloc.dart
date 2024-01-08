import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'myuser_event.dart';
part 'myuser_state.dart';

class MyuserBloc extends Bloc<MyuserEvent, MyuserState> {
  final UserRepository _userRepository;
  MyuserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(MyuserInitial()) {
    on<UpdateUserProfile>((event, emit) async {
      emit(UpdateUserProfileLoading());
      try {
        await _userRepository.updateUserProfilePic(event.user);
        emit(UpdateUserProfileSuccess());
      } catch (e) {
        log(e.toString());
        emit(UpdateUserProfileError(errorMsg: e.toString()));
      }
    });

    on<UpdateUserDetails>((event, emit) async {
      emit(UpdateUserDetailsLoading());
      try {
        await _userRepository.updateUserDetails(event.user);
        emit(UpdateUserDetailsSuccess());
      } catch (e) {
        log(e.toString());
        emit(UpdateUserDetailsError(errorMsg: e.toString()));
      }
    });

    //* update user password
    on<UpdatePassWord>((event, emit) async{
       emit(UpdateUserPasswordLoading());
      try {
        // await _userRepository.resetPassword(event.user);
        emit(UpdateUserPasswordSuccess());
      } catch (e) {
        log(e.toString());
        emit(UpdateUserPasswordError(errorMsg: e.toString()));
      }
    });
  }
}
