part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String userName;
  final String userId;

  LoggedIn({this.token, this.userName, this.userId});

  @override
  List<Object> get props => [token, userName];
}

class LoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class IsUserLoggedIn extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class GetUserInfoEvent extends AuthenticationEvent{
  final String authToken;

  GetUserInfoEvent({this.authToken});
  @override
  List<Object> get props => [authToken];

}

class GetAuthTokenEvent extends AuthenticationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
