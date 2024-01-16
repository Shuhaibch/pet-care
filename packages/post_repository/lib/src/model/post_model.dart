import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/src/entity/entity.dart';

class Post extends Equatable {
  final String? postId;
  final String userId;
  final String? postPic;
  final List? like;
  final String? caption;
  final Timestamp postDate;

  const Post({
    this.postId,
    required this.userId,
    this.postPic,
    this.like,
    this.caption,
    required this.postDate,
  });

  /// Empty Post
  static final empty = Post(
    postId: '',
    userId: '',
    postPic: '',
    like: List.empty(),
    caption: '',
    postDate: Timestamp.now(),
  );

  /// Copy Post Methord
  Post copyWith({
    String? postId,
    String? userId,
    String? postPic,
    List? like,
    String? caption,
    Timestamp? postDate,
  }) {
    return Post(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      postPic: postPic ?? this.postPic,
      like: like ?? this.like,
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
      like: like,
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
      like: entity.like,
      caption: entity.caption,
      postDate: entity.postDate,
    );
  }

  addLike({required String userId}) {
    like!.add(userId);
    return like;
  }

  removeLike({required String userId}) {
    like!.remove(userId);
    return like;
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
