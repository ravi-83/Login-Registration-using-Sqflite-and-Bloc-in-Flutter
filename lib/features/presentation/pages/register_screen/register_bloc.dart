import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_registration_app/features/data/datasources/local_data_source.dart';
import 'package:login_registration_app/features/data/models/user_model.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final LocalDataSource _localDataSource;

  RegisterBloc({@required LocalDataSource localDataSource})
      : assert(localDataSource != null),
        _localDataSource = localDataSource,
        super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is CheckUserIsRegisteredEvent){
      var shouldLogin= await _localDataSource.shouldRegister(event.email, event.password);
      yield ShouldRegisterState(shouldRegister: shouldLogin);
    }else if(event is RegisterUserEvent){
      var isRegistered = await _localDataSource.saveUserProfile(event.name, event.email, event.password);
      yield RegisterLoadedState(isRegistered: isRegistered);
    }else if(event is StoreAuthTokenEvent){
      _localDataSource.saveAccessToken(event.authToken);
      print("Auth token stored");
      yield RegisterLoadedState(isAuthTokenStored: true);
    }
  }
}
