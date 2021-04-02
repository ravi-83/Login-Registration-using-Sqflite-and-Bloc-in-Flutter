import 'package:flutter/foundation.dart';
import 'package:login_registration_app/core/config/db_provider.dart';
import 'package:login_registration_app/core/config/my_shared_pref.dart';
import 'package:login_registration_app/features/data/models/user_model.dart';

abstract class LocalDataSource{
  void saveAccessToken(String accessToken);

  String getAccessToken();

  Future<UserModel> getProfileInformation({String authToken});

  void logout();

  Future<bool> shouldRegister(String email,String password);

  Future<bool> saveUserProfile(String name,String email,String password);
  Future<bool> loginUser(final String email, final String password);
}


class LocalDataSourceImpl extends LocalDataSource{
  final MySharedPref mySharedPref;
  final DBProvider dbProvider;

  LocalDataSourceImpl({
    @required this.mySharedPref,
    @required this.dbProvider,
  });

  @override
  String getAccessToken() {
    return mySharedPref.getAccessToken();
  }

  @override
  void saveAccessToken(String accessToken) {
    mySharedPref.saveAccessToken(accessToken);
  }

  @override
  Future<UserModel> getProfileInformation({String authToken}) async{
    return await dbProvider.getUserProfileInformation(authToken);
  }

  @override
  void logout() {
    mySharedPref.logout();
  }

  @override
  Future<bool> shouldRegister(String email, String password) async{
    return await dbProvider.registerUser(email, password);
  }

  @override
  Future<bool> saveUserProfile(String name, String email, String password) async{
    return await dbProvider.saveUserProfile(name: name,email: email,password: password);
  }

  @override
  Future<bool> loginUser(String email, String password) async{
    return await dbProvider.loginUser(email, password);
  }

}