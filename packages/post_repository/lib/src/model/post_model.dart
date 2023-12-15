import 'package:equatable/equatable.dart';
import 'package:post_repository/src/entity/entity.dart';

class Post extends Equatable {
  final String postId;
  final String userId;
  final String postPic;
  final String caption;
  final DateTime postDate;

  const Post({
    required this.postId,
    required this.userId,
    required this.postPic,
    required this.caption,
    required this.postDate,
  });

  /// Empty Post
  static final empty = Post(
    postId: '',
    userId: '',
    postPic: '',
    caption: '',
    postDate: DateTime.now(),
  );

  /// Copy Post Methord
  Post copyWith({
    String? postId,
    String? userId,
    String? postPic,
    String? caption,
    DateTime? postDate,
  }) {
    return Post(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      postPic: postPic ?? this.postPic,
      caption: caption ?? this.caption,
      postDate: postDate ?? this.postDate,
    );
  }

  /// Convienent getter to determine wheather the post is empty
  bool get isEmpty => this == Post.empty;

  /// Convienent getter to determine wheather the post is not empty
  bool get isNotEmpty => this != Post.empty;

  /// From Local to Firebase
  PostEntity toEntity() {
    return PostEntity(
      postId: postId,
      userId: userId,
      postPic: postPic,
      caption: caption,
      postDate: postDate,
    );
  }

  /// From firebase To local
  static Post fromEntity(PostEntity entity) {
    return Post(
      postId: entity.postId,
      userId: entity.userId,
      postPic: entity.postPic,
      caption: entity.caption,
      postDate: entity.postDate,
    );
  }

  @override
  List<Object?> get props => [
        postId,
        userId,
        postPic,
        caption,
        postDate,
      ];
}
