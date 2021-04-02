part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class CheckUserIsRegisteredEvent extends RegisterEvent{
  final String email;
  final String password;

  CheckUserIsRegisteredEvent({this.email, this.password});
  @override
  List<Object> get props => [email,password];

}

class RegisterUserEvent extends RegisterEvent{
  final String name;
  final String email;
  final String password;

  RegisterUserEvent({this.name, this.email, this.password});

  @override
  List<Object> get props => [name,email,password];

}

class StoreAuthTokenEvent extends RegisterEvent{
  final String authToken;

  StoreAuthTokenEvent({this.authToken});
  @override
  List<Object> get props => [authToken];

}
