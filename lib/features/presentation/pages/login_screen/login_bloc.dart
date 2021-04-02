import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_registration_app/core/utils/constants.dart';
import 'package:login_registration_app/features/data/datasources/local_data_source.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LocalDataSource _localDataSource;

  LoginBloc({@required LocalDataSource localDataSource})
      : assert(localDataSource != null),
        _localDataSource = localDataSource,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUserEvent) {
      var userLoggedIn= await _localDataSource.loginUser(
           event.email, event.password);
      print(userLoggedIn);
      if(userLoggedIn==false){
        Fluttertoast.showToast(
            msg: "Invalid Credential !!",
            gravity: ToastGravity.CENTER,
            backgroundColor: AppColors.vd_dark_accent_border);
      }
      yield LoginLoadedState(isLoggedIn: userLoggedIn);
    } else if (event is StoreAuthTokenEvent) {
      print(event.authToken);
      _localDataSource.saveAccessToken(event.authToken);
      print("Auth token stored");
      yield LoginLoadedState(isAuthTokenStored: true);
    }
  }
}
