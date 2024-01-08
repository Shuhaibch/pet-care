// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_users_bloc.dart';

abstract class MyUsersEvent extends Equatable {
  const MyUsersEvent();
  @override
  List<Object> get props => [];
}

class GetMyUsers extends MyUsersEvent {
  const GetMyUsers({
    required this.myUsersId,
  });
  final String myUsersId;

  @override
  List<Object> get props => [myUsersId];
}
