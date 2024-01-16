import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:post_repository/post_repository.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid(); 

class FirebasePostRepository implements PostRepo {
  final postCollection = FirebaseFirestore.instance.collection('post');
  List<Post> postList = [];
  List<Post> allPostList = [];

//* Create post
  @override
  Future<void> createPost(Post post, String image) async {
    try {
      String url = await upLoadPicture(image, post.postId!);
      post = post.copyWith(postPic: url);

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
      final documentRef = postCollection.doc(postId);
      await documentRef.delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//* get User post
  @override
  Future<List<Post>> getUserPost(String userId) async {
    try {
      return await postCollection.where('userId', isEqualTo: userId).get().then(
          (value) => value.docs
              .map((e) => Post.fromEntity(PostEntity.fromDocument(e.data())))
              .toList());
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
      // return allPostList;
      return await postCollection.get().then((value) => value.docs
          .map((e) => Post.fromEntity(PostEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //* upload image
  @override
  Future<String> upLoadPicture(String file, String postId) async {
    try {
      File imageFile = File(file);
      Reference fireBaseStoreRef =
          FirebaseStorage.instance.ref().child('Post/$postId');
      await fireBaseStoreRef.putFile(
          imageFile,
          SettableMetadata(
            contentType: "image/jpeg",
          ));
      String url = await fireBaseStoreRef.getDownloadURL();
      url = url.toString();
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
