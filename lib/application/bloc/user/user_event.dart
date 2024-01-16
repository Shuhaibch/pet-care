part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class GetUserData extends UserEvent {
  final String userId;
  const GetUserData({required this.userId});
  @override
  List<Object> get props => [];
}

class DeleteReport extends UserEvent {
  final String reportId;
  const DeleteReport({required this.reportId});
  @override
  List<Object> get props => [reportId];
}

class UpdateReport extends UserEvent {
  final Report report;
  const UpdateReport({required this.report});
  @override
  List<Object> get props => [report];
}

class DeletePost extends UserEvent {
  final String post;
  const DeletePost({required this.post});
  @override
  List<Object> get props => [post];
}
class RemoveProfilePic extends UserEvent {
  final MyUser myUser;
  const RemoveProfilePic({required this.myUser});
  @override
  List<Object> get props => [myUser];
}


class UpdatePost extends UserEvent {
  final Post post;
  const UpdatePost({required this.post});
  @override
  List<Object> get props => [post];
}
