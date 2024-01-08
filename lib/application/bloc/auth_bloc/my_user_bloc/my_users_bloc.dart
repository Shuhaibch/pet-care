import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'my_users_event.dart';
part 'my_users_state.dart';

class MyUsersBloc extends Bloc<MyUsersEvent, MyUsersState> {
  final UserRepository _userRepository;
  MyUsersBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const MyUsersState.loading()) {
    on<GetMyUsers>((event, emit) async {
      try {
        MyUser myUsers = await _userRepository.getUserData(event.myUsersId);
        emit(MyUsersState.success(myUsers));
      } catch (e) {
        log(e.toString());
        emit(const MyUsersState.failure());
      }
    });
  }
}
