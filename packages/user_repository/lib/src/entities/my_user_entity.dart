import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String name;
  final String address;
  final String email;
  final int phone;
  final String userRole;
  final String? profilePic;

  const MyUserEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.userRole,
    this.profilePic,
  });

  /// TO The Firebase
  Map<String, Object?> toDocument() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "email": email,
      "phone": phone,
      "userRole": userRole,
      "profilePic": profilePic,
    };
  }

  ///From the firebase
  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc["id"] as String,
      name: doc["name"] as String,
      address: doc["address"] as String,
      email: doc["email"] as String,
      phone: doc["phone"] as int,
      userRole: doc["userRole"] as String,
      profilePic: doc["profilePic"] as String,
    );
  }

  /// toString override
  @override
  String toString() {
    return ''' MyUserEntity(
      id: $id,
      name: $name,
      address: $address,
      email: $email,
      phone: $phone,
      userRole: $userRole
      profilePic: $profilePic,
    )''';
  }

  @override
  List<Object?> get props =>
      [id, name, address, email, phone, userRole, profilePic];
}
