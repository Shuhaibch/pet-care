import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String postId;
  final String userId;
  final String postPic;
  final String caption;
  final DateTime postDate;

  const PostEntity({
    required this.postId,
    required this.userId,
    required this.postPic,
    required this.caption,
    required this.postDate,
  });

  ///To the Firebase
  Map<String, Object?> toDocument() {
    return {
      'postId': postId,
      'userId': userId,
      'postPic': postPic,
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
        caption: $caption,
        postDate: $postDate)''';
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
