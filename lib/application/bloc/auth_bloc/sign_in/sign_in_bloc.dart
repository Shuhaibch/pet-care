import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInLoading());
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
        log(e.toString(), name: 'signin firebase error');
        emit(SignInfailed(errorMsg: e.toString()));
      } catch (e) {
        log(e.toString(), name: 'signin other error');
        emit(SignInfailed(errorMsg: e.toString()));
      }
    });
    on<SignOutRequired>((event, emit) async {
      await _userRepository.logout();
      emit(SignOutSuccess());
    });
    on<SignInWithGoogle>((event, emit) async {
      emit(SignInLoading());
      try {
        await _userRepository.signUpWithGoogle();
        emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
        log(e.toString(), name: 'signin firebase error');
        emit(SignInfailed(errorMsg: e.toString()));
      } catch (e) {
        log(e.toString(), name: 'signin other error');
        emit(SignInfailed(errorMsg: e.toString()));
      }
    });
  }
}
