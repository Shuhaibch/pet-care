part of 'my_users_bloc.dart';

enum MyUsersStatus { success, failure, loading }

class MyUsersState extends Equatable {
  final MyUsersStatus status;
  final MyUser? users;

  const MyUsersState._({this.status = MyUsersStatus.loading, this.users});

  const MyUsersState.loading() : this._();

  const MyUsersState.success(MyUser users)
      : this._(status: MyUsersStatus.success, users: users);
  const MyUsersState.failure() : this._(status: MyUsersStatus.failure);

  @override
  List<Object?> get props => [status, users];
}
