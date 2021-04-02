part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}


class LoginLoadedState extends LoginState{
  final bool isLoggedIn;
  final bool isAuthTokenStored;

  LoginLoadedState({this.isLoggedIn, this.isAuthTokenStored});
  @override
  List<Object> get props => [isLoggedIn,isAuthTokenStored];

}
