import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entity.dart';

/// User Model
class MyUser extends Equatable {
  final String id;
  final String name;
  final String address;
  final String email;
  final int phone;
  final String? profilePic;

  const MyUser({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    this.profilePic,
  });

  /// Empty User
  static const empty = MyUser(
    id: '',
    name: '',
    address: "",
    email: '',
    phone: 0,
  );

  /// MyUser Copywith
  MyUser copyWith({
    String? id,
    String? name,
    String? address,
    String? email,
    int? phone,
    String? profilePic,
  }) {
    return MyUser(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  /// Convienent getter to determine wheather the user is empty
  bool get isEmpty => this == MyUser.empty;

  /// Convienent getter to determine wheather the user is not empty
  bool get isNotEmpty => this != MyUser.empty;

  ///from local to firebase
  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      name: name,
      address: address,
      email: email,
      phone: phone,
      profilePic: profilePic,
    );
  }

  ///Form Firebase to local storage
  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      email: entity.email,
      phone: entity.phone,
    );
  }

  

  @override
  List<Object?> get props => [id, name, address, email, phone, profilePic];
}
