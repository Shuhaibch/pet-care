// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final String role;

  const SignUpRequired({
    required this.userName,
    required this.passWord,
    required this.email,
    required this.role,
  });
}
