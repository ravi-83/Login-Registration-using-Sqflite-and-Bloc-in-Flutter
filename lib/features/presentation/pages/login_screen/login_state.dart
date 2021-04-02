part of 'login_bloc.dart';

@immutable
abstract class LoginState {

}

class LoginInitial extends LoginState {

}


class LoginLoadedState extends LoginState{
  final bool isLoggedIn;
  final bool isAuthTokenStored;

  LoginLoadedState({this.isLoggedIn, this.isAuthTokenStored});


}
