part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInSuccess extends SignInState {}

final class SignInfailed extends SignInState {
  final String? errorMsg;

  const SignInfailed({required this.errorMsg});
}

final class SignInLoading extends SignInState {}
class SignOutSuccess extends SignInState {
  
}
