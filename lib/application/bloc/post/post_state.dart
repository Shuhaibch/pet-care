part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class GetAllPostSuccess extends PostState {
  final List<AllPost> allPost;
  const GetAllPostSuccess({required this.allPost});
}

class GetAllPostFailed extends PostState {
  final String? errorMsg;
  const GetAllPostFailed({required this.errorMsg});
}

class GetAllPostLoading extends PostState {}

class CreatePostSuccess extends PostState {}

class CreatePostFailed extends PostState {
  final String? errorMsg;
  const CreatePostFailed({required this.errorMsg});
}

class CreatePostLoading extends PostState {}

class UpdatePostSuccess extends PostState {}

class UpdatePostFailed extends PostState {
  final String? errorMsg;
  const UpdatePostFailed({required this.errorMsg});
}

class UpdatePostLoading extends PostState {}

class DeletePostSuccess extends PostState {}

class DeletePostFailed extends PostState {
  final String? errorMsg;
  const DeletePostFailed({required this.errorMsg});
}

class DeletePostLoading extends PostState {}
