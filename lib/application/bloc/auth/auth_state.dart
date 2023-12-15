part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final auth.User? authUser;
  const 

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}
