part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class GetUserData extends UserEvent {
  final String userId;
  const GetUserData({required this.userId});
}

class DeleteReport extends UserEvent {
  final String reportId;
  const DeleteReport({required this.reportId});
}

class UpdateReport extends UserEvent {
  final Report report;
  const UpdateReport({required this.report});
}

class DeletePost extends UserEvent {
  final Post post;
  const DeletePost({required this.post});
}

class UpdatePost extends UserEvent {
  final Post post;
  const UpdatePost({required this.post});
}
