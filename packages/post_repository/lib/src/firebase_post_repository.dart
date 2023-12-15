import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_repository/post_repository.dart';

class FirebasePostRepository implements PostRepo {
  final postCollection = FirebaseFirestore.instance.collection('post');
  List<Post> postList = [];
  List<Post> allPostList = [];

//* Create post
  @override
  Future<void> createPost(Post post) async {
    try {
      await postCollection.doc(post.postId).set(post.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//* delete post
  @override
  Future<void> deletePost(String postId) async {
    try {
      await postCollection.doc(postId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//* get User post
  @override
  Future<List<Post>> getPost(String userId) async {
    try {
      postList = [];
      QuerySnapshot postSnapshot =
          await postCollection.where('userId', isEqualTo: userId).get();
      postSnapshot.docs.map(
        (doc) => postList.add(
          Post(
            postId: doc['postId'],
            userId: doc['userId'],
            postPic: doc['postPic'],
            caption: doc['caption'],
            postDate: doc['postDate'],
          ),
        ),
      );
      return postList;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//* Update post
  @override
  Future<void> updatePost(Post post) async {
    try {
      await postCollection
          .doc(post.postId)
          .update(post.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
    }
  }

//* get all post
  @override
  Future<List<Post>> getAllPost() async {
    try {
      QuerySnapshot allPostSnapshot = await postCollection.get();
      allPostSnapshot.docs.map(
        (doc) => allPostList.add(
          Post(
            postId: doc['postId'],
            userId: doc['userId'],
            postPic: doc['postPic'],
            caption: doc['caption'],
            postDate: doc['postDate'],
          ),
        ),
      );
      return allPostList;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
