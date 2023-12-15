import 'package:post_repository/post_repository.dart';

abstract class PostRepo {
  Future<void> createPost(Post post);
  Future<List<Post>> getPost(String userId);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String postId);
  Future<List<Post>> getAllPost();

}
