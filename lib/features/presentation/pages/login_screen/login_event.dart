part of 'login_bloc.dart';
@immutable
abstract class LoginEvent  {
}

class LoginUserEvent extends LoginEvent{
  final String email;
  final String password;

  LoginUserEvent({this.email, this.password});

}

class StoreAuthTokenEvent extends LoginEvent{
  final String authToken;

  StoreAuthTokenEvent({this.authToken});


}

