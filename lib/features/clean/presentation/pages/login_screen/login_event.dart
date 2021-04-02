part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent{
  final String email;
  final String password;

  LoginUserEvent({this.email, this.password});

  @override
  List<Object> get props => [email,password];

}

class StoreAuthTokenEvent extends LoginEvent{
  final String authToken;

  StoreAuthTokenEvent({this.authToken});
  @override
  List<Object> get props => [authToken];

}

