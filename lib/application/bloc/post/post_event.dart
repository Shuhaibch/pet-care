// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetAllPost extends PostEvent {}


class CreatePost extends PostEvent {
  final Post post;
  final String image;
  const CreatePost({
    required this.post,
    required this.image,
  });
}

class DeletePost extends PostEvent {
  final String postId;

  const DeletePost({required this.postId});
}