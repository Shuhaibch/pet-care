part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final String userName;
  final String passWord;
  final String email;

  const SignUpRequired({
    required this.userName,
    required this.passWord,
    required this.email,
  });
}
