import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  final UserRepository _userRepository;
  GoogleAuthBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(GoogleAuthInitial()) {
    on<GoogleSignInRequired>((event, emit) async {
      emit(GoogleAuthLoading());
      try {
        await _userRepository.signUpWithGoogle();
        emit(GoogleAuthSuccess());
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        emit(GoogleAuthfailed(errorMsg: e.toString()));
      } catch (e) {
        log(e.toString());
        emit(GoogleAuthfailed(errorMsg: e.toString()));
      
      }
    });
  }
}
