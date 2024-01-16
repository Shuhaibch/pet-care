// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

//* Delete Report
class DeleteReportSuccess extends UserState {}

class DeleteReportLoading extends UserState {}

class DeleteReportError extends UserState {
  final String errorMsg;
  const DeleteReportError({required this.errorMsg});
}

// * Get User Report
class GetUserDataSuccess extends UserState {
  final List<Report> userReportList;
  final List<Post> userPostList;
  final MyUser userDetail;

  const GetUserDataSuccess({
    required this.userReportList,
    required this.userPostList,
    required this.userDetail,
  });
   @override
  List<Object> get props => [userReportList, userPostList, userDetail];
}

class GetUserDataLoading extends UserState {
  @override
  List<Object> get props => [];
}
class GetUserDataError extends UserState {
  final String errorMsg;

  const GetUserDataError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

//* Update Report
class UpdateReportSuccess extends UserState {
  @override
  List<Object> get props => [];
}
class UpdateReportLoading extends UserState {
  @override
  List<Object> get props => [];
}
class UpdateReportError extends UserState {
  final String errorMsg;
  const UpdateReportError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class GetUserProfile extends UserState {
  @override
  List<Object> get props => [];}

//* Remove Profile
class RemoveProfileSuccess extends UserState {
  @override
  List<Object> get props => [];}

class RemoveProfileLoading extends UserState {
  @override
  List<Object> get props => [];}

class RemoveProfileError extends UserState {
  final String errorMsg;

  const RemoveProfileError({required this.errorMsg});
  
  @override
  List<Object> get props => [];
}
//* Delete Post
class DeletePostSuccess extends UserState {}

class DeletePostLoading extends UserState {}

class DeletePostError extends UserState {
  final String errorMsg;
  const DeletePostError({required this.errorMsg});
}