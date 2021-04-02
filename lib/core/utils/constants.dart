import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Class containing constants used throughout the app
class Constants {
  static const String DB_NAME = "app.db";
  static const SystemUiOverlayStyle SYSTEM_UI_OVERLAY_STYLE =
  SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    // this will change the brightness of the icons
    statusBarColor: AppColors.black,
    // or any color you want
    systemNavigationBarIconBrightness:
    Brightness.light, //navigation bar icons' color
    statusBarBrightness: Brightness.light,
  );



}

class DBConstants {
  static const String TABLE_USER = "user_table";

  static const String FIELD_ID = "id";
  static const String FIELD_NAME = "name";
  static const String FILED_PASSWORD = "password";
  static const String FIELD_EMAIL = "email";
}

class AppColors {

  static const Color dark_grey_80 = Color(0xcc26292e);
  static const Color black = Color(0xff000000);
  static const Color vd_dark_accent_border = Color(0xff151619);


}

