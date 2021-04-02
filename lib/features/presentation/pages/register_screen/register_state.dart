part of 'register_bloc.dart';

@immutable
abstract class RegisterState{

}

class RegisterInitial extends RegisterState {

}

class RegisterLoadingState extends RegisterState{

}

class RegisterLoadedState extends RegisterState{
  final bool isRegistered;
  final bool isAuthTokenStored;

  RegisterLoadedState({this.isRegistered,this.isAuthTokenStored});


}
class ShouldRegisterState extends RegisterState{

  final bool shouldRegister;

  ShouldRegisterState({this.shouldRegister});


}
