part of 'myuser_bloc.dart';

abstract class MyuserEvent extends Equatable {
  const MyuserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserProfile extends MyuserEvent {
  final MyUser user;
  const UpdateUserProfile({required this.user});
}

class GetMyUser extends MyuserEvent {
  const GetMyUser({
    required this.myUserId,
  });
  final String myUserId;

  @override
  List<Object> get props => [myUserId];
}

class UpdateUserDetails extends MyuserEvent {
  final MyUser user;

  const UpdateUserDetails({required this.user});
}

class UpdatePassWord extends MyuserEvent {
  final String password;
  final String userId;

  const UpdatePassWord(this.password, this.userId);
}
