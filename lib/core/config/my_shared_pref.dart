import 'package:shared_preferences/shared_preferences.dart';

/// Class containing 'SharedPreferences' instance, all data will be
/// stored/read using this class
class MySharedPref {
  static const ACCESS_TOKEN = "access_token";
  final SharedPreferences _pref;

  MySharedPref(this._pref);

  /// Save access token
  void saveAccessToken(String accessToken) {
    _pref.setString(ACCESS_TOKEN, accessToken);
  }

  /// Get access token
  String getAccessToken() {
    return _pref.getString(ACCESS_TOKEN);
  }

  /// Function to
  void logout() {
    _pref.remove(ACCESS_TOKEN);
  }


}
