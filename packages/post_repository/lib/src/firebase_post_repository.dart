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
      // log(image, name: 'createpost');
      // Reference fireBaseStoreRef = FirebaseStorage.instance
      //     .ref('post')
      //     .child('${post.postId}');
      // await fireBaseStoreRef.putFile(File(image.path));
      // String url = await fireBaseStoreRef.getDownloadURL();
      // log(url, name: 'irl');
      String url = await upLoadPicture(image, post.postId!);
      post = post.copyWith(postPic: url);
      // log(post.toString(), name: 'test');

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
  Future<List<Post>> getUserPost(String userId) async {
    try {
      // postList = [];
      // QuerySnapshot postSnapshot =
      //     await postCollection.where('userId', isEqualTo: userId).get();
      // postSnapshot.docs.map(
      //   (doc) => postList.add(
      //     Post(
      //       postId: doc['postId'],
      //       userId: doc['userId'],
      //       postPic: doc['postPic'],
      //       caption: doc['caption'],
      //       postDate: doc['postDate'],
      //     ),
      //   ),
      // );
      // return postList;
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
      // QuerySnapshot allPostSnapshot = await postCollection.get();
      // allPostSnapshot.docs.map(
      //   (doc) => allPostList.add(
      //     Post(
      //       postId: doc['postId'],
      //       userId: doc['userId'],
      //       postPic: doc['postPic'],
      //       caption: doc['caption'],
      //       postDate: doc['postDate'],
      //     ),
      //   ),
      // );
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
