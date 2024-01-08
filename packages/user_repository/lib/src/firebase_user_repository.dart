import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  final auth.FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('user');
  List<MyUser> allUsers = [];
  //? SignUP
  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );
      myUser = myUser.copyWith(id: user.user!.uid);
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<auth.User?> get user {
    try {
      return _firebaseAuth.authStateChanges().map((fireBaseUser) {
        final user = fireBaseUser;
        return user;
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getUserData(String userId) {
    try {
      log('message');
      return userCollection.doc(userId).get().then(
            (value) => MyUser.fromEntity(
              MyUserEntity.fromDocument(
                value.data()!,
              ),
            ),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    // await _firebaseAuth.pas(email: email);
  }

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await userCollection.doc(user.id).set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MyUser>> getAllUser() async {
    try {
      return await userCollection.get().then((value) => value.docs
          .map((e) => MyUser.fromEntity(MyUserEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //* upload image
  @override
  Future<String> upLoadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);
      Reference fireBaseStoreRef =
          FirebaseStorage.instance.ref().child('Profile/$userId');
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

  @override
  Future<void> updateUserProfilePic(MyUser myUser) async {
    try {
      final url = await upLoadPicture(myUser.profilePic!, myUser.id);
      myUser = myUser.copyWith(profilePic: url);
      await userCollection.doc(myUser.id).set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<void> updateUserDetails(MyUser myUser)async {
    try {
    
      await userCollection.doc(myUser.id).set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
