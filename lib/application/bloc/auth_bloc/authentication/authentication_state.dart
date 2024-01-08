part of 'authentication_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthStatus status;
  final User? user;

  const AuthenticationState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user,)
      : this._(status: AuthStatus.authenticated, user: user ,  );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user, ];
}
