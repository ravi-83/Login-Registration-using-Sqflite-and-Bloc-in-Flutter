part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState{
  @override
  List<Object> get props => [];
}

class RegisterLoadedState extends RegisterState{
  final bool isRegistered;
  final bool isAuthTokenStored;

  RegisterLoadedState({this.isRegistered,this.isAuthTokenStored});
  @override
  List<Object> get props => [isRegistered,isAuthTokenStored];

}
class ShouldRegisterState extends RegisterState{

  final bool shouldRegister;

  ShouldRegisterState({this.shouldRegister});
  @override
  List<Object> get props => [shouldRegister];

}
