part of 'myuser_bloc.dart';

abstract class MyuserState extends Equatable {
  const MyuserState();

  @override
  List<Object> get props => [];
}

class MyuserInitial extends MyuserState {}

//* Update User Profile pIc
class UpdateUserProfileSuccess extends MyuserState {
  final MyUser user;

  const UpdateUserProfileSuccess({required this.user});
}

class UpdateUserProfileLoading extends MyuserState {}

class UpdateUserProfileError extends MyuserState {
  final String errorMsg;

  const UpdateUserProfileError({required this.errorMsg});
}

//* GEt User Details
class GetUserDetailsSuccess extends MyuserState {
  final MyUser user;

  const GetUserDetailsSuccess({required this.user});
}

class GetUserDetailsLoading extends MyuserState {}

class GetUserDetailsError extends MyuserState {
  final String errorMsg;

  const GetUserDetailsError({required this.errorMsg});
}

//* Update User Details
class UpdateUserDetailsSuccess extends MyuserState {
  // final MyUser user;

  const UpdateUserDetailsSuccess(
      //   {
      //   // required this.user,
      // }
      );
}

class UpdateUserDetailsLoading extends MyuserState {}

class UpdateUserDetailsError extends MyuserState {
  final String errorMsg;

  const UpdateUserDetailsError({required this.errorMsg});
}

//* Update User password
class UpdateUserPasswordSuccess extends MyuserState {}

class UpdateUserPasswordLoading extends MyuserState {}

class UpdateUserPasswordError extends MyuserState {
  final String errorMsg;

  const UpdateUserPasswordError({required this.errorMsg});
}
