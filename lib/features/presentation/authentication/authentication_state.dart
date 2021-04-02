part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}


class Uninitialized extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  final bool isLoggedIn;

  Authenticated({
    this.isLoggedIn,
  });

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserInfoLoadedState extends AuthenticationState{
  final String authToken;
  final UserModel userModel;

  UserInfoLoadedState({this.authToken, this.userModel});
  @override
  List<Object> get props => [authToken,userModel];

}


