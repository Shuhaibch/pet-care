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
}

class GetUserDataLoading extends UserState {}

class GetUserDataError extends UserState {
  final String errorMsg;

  const GetUserDataError({required this.errorMsg});
}

//* Update Report
class UpdateReportSuccess extends UserState {}

class UpdateReportLoading extends UserState {}

class UpdateReportError extends UserState {
  final String errorMsg;

  const UpdateReportError({required this.errorMsg});
}

class GetUserProfile extends UserState {}
