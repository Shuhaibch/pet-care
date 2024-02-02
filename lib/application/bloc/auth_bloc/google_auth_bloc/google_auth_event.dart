part of 'google_auth_bloc.dart';

abstract class GoogleAuthEvent extends Equatable {
  const GoogleAuthEvent();

  @override
  List<Object> get props => [];
}
class GoogleSignInRequired extends GoogleAuthEvent{
  
  @override
  List<Object> get props => [];
}