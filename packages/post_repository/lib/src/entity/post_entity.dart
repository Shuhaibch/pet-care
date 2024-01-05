import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? postId;
  final String userId;
  final String? postPic;
  final List? like;
  final String? caption;
  final Timestamp postDate;

  const PostEntity({
    this.postId,
    required this.userId,
    this.postPic,
    this.like,
    this.caption,
    required this.postDate,
  });

  ///To the Firebase
  Map<String, Object?> toDocument() {
    return {
      'postId': postId,
      'userId': userId,
      'postPic': postPic,
      'like': like,
      'caption': caption,
      'postDate': postDate,
    };
  }

  /// From firebase
  static PostEntity fromDocument(Map<String, dynamic> doc) {
    return PostEntity(
      postId: doc['postId'],
      userId: doc['userId'],
      postPic: doc['postPic'],
      like: doc['like'],
      caption: doc['caption'],
      postDate: doc['postDate'],
    );
  }

  /// to String overRide
  @override
  String toString() {
    return '''PostEntity(
        postId:$postId,
        userId: $userId,
        postPic: $postPic,
        like: $like,
        caption: $caption,
        postDate: $postDate)''';
  }

  @override
  List<Object?> get props => [
        postId,
        userId,
        postPic,
        like,
        caption,
        postDate,
      ];
}
