import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpLoading());
      try {
        final MyUser user = MyUser(
          id: '',
          name: event.userName,
          address: '',
          email: event.email,
          phone: 0,
          userRole: event.role,
          profilePic: ''
        );
        final MyUser myUser =
            await _userRepository.signUp(user, event.passWord);
        await _userRepository.setUserData(myUser);
        emit(SignUpSuccess());
      } on FirebaseException catch (e) {
        emit(SignUpError(errorMsg: e.toString()));
      } catch (e) {
        log(e.toString());
        emit(SignUpError(errorMsg: e.toString()));
      }
    });
  }
}
