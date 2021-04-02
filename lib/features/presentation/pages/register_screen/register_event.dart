part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {

}

class CheckUserIsRegisteredEvent extends RegisterEvent{
  final String email;
  final String password;

  CheckUserIsRegisteredEvent({this.email, this.password});


}

class RegisterUserEvent extends RegisterEvent{
  final String name;
  final String email;
  final String password;

  RegisterUserEvent({this.name, this.email, this.password});



}

class StoreAuthTokenEvent extends RegisterEvent{
  final String authToken;

  StoreAuthTokenEvent({this.authToken});
  @override
  List<Object> get props => [authToken];

}
