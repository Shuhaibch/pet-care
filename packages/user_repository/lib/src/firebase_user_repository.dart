import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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
      return userCollection.doc(userId).get().then(
            (value) => MyUser.fromEntity(
              MyUserEntity.formDocument(
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
    await _firebaseAuth.sendPasswordResetEmail(email: email);
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
      allUsers = [];
      QuerySnapshot userSnapshot = await userCollection.get();
      userSnapshot.docs.map(
        (doc) => allUsers.add(
          MyUser(
            id: doc['id'],
            name: doc['name'],
            address: doc['address'],
            email: doc['email'],
            phone: doc['phone'],
          ),
        ),
      );
      return allUsers;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
