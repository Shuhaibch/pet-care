// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_user_bloc.dart';

abstract class MyUserEvent extends Equatable {
  const MyUserEvent();
  @override
  List<Object> get props => [];
}

class GetMyUser extends MyUserEvent {
  const GetMyUser({
    required this.myUserId,
  });
  final String myUserId;

  @override
  List<Object> get props => [myUserId];
}
