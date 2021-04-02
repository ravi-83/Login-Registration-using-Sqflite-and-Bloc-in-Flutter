import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_registration_app/features/data/datasources/local_data_source.dart';
import 'package:login_registration_app/features/data/models/user_model.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LocalDataSource _localDataSource;

  AuthenticationBloc({@required LocalDataSource localDataSource})
      : assert(localDataSource != null),
        _localDataSource = localDataSource,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // app start
    if (event is AppStarted) {
      var token = await _getToken();
      if (token != '') {
        // Storage().token = token;
        yield Authenticated(isLoggedIn: true);
      } else {
        yield Unauthenticated();
      }
    }else if (event is IsUserLoggedIn) {
      final token=await _getToken();
      if(token==null || token.isEmpty){
        yield Unauthenticated();
      }else{
        yield Authenticated(isLoggedIn: token.isNotEmpty);
      }
    }else if(event is GetAuthTokenEvent){
      final token=await _getToken();
      yield UserInfoLoadedState(authToken: token);
    }else if(event is GetUserInfoEvent){
      final userData= await _localDataSource.getProfileInformation(authToken: event.authToken);
      yield UserInfoLoadedState(userModel: userData);
    }else if(event is LoggedOut){
      _localDataSource.logout();
      yield Unauthenticated();
    }
  }


  /// delete Auth Token
  Future<void> _deleteToken() async {
    _localDataSource.logout();
  }

  void _saveAccessToken(String accessToken) {
    _localDataSource.saveAccessToken(accessToken);
  }

  /// Read Auth Token
  Future<String> _getToken() async {
    return _localDataSource.getAccessToken();
  }
}
