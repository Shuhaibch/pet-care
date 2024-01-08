import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

class AllPost {
  final Post post;
  final MyUser user;

  AllPost({
    required this.post,
    required this.user,
  });

  /// Empty Post
  static final empty = AllPost(
    post: Post.empty,
    user: MyUser.empty,
  );

  /// Copy Post Methord
  AllPost copyWith({
    Post? post,
    MyUser? user,
  }) {
    return AllPost(
      post: post ?? this.post,
      user: user ?? this.user,
    );
  }

  /// Convienent getter to determine wheather the post is empty
  bool get isEmpty => this == AllPost.empty;

  /// Convienent getter to determine wheather the post is not empty
  bool get isNotEmpty => this != AllPost.empty;
  @override
  String toString() {
    return '''AllPost(
      post: $post
        user: $user
        )''';
  }

  addLike({required String userId}) {
    post.like!.add(userId);
    return post.like;
  }

  removeLike({required String userId}) {
    post.like!.remove(userId);
    return post.like;
  }
}
