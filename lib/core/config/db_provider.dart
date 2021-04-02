import 'package:login_registration_app/features/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/constants.dart';

class DBProvider {
  static Database _database;

  Future<Database> getInstance() async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  /// Initializing the database
  _initDB() async {
    return await openDatabase(Constants.DB_NAME, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ${DBConstants.TABLE_USER} "
          "("
          "${DBConstants.FIELD_ID} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "${DBConstants.FIELD_NAME} TEXT, "
          "${DBConstants.FILED_PASSWORD} TEXT, "
          "${DBConstants.FIELD_EMAIL} TEXT"
          ")");
    });
  }

  /// Function to save the user's profile information
  saveUserProfile({
    //final int id,
    final String name,
    final String password,
    final String email,
  }) async {
    //await _database.rawQuery("DELETE FROM ${DBConstants.TABLE_USER}");

    final values = Map<String, dynamic>();
    //values[DBConstants.FIELD_ID] = id;
    values[DBConstants.FIELD_NAME] = name;
    values[DBConstants.FILED_PASSWORD] = password;
    values[DBConstants.FIELD_EMAIL] = email;

    try {
      var row = await _database.insert(DBConstants.TABLE_USER, values);
      print("User information inserted = " + row.toString());
      var userData =
          await _database.rawQuery("SELECT * FROM ${DBConstants.TABLE_USER}");
      print(userData);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Function to get the user's profile information
  Future<UserModel> getUserProfileInformation(String authToken) async {
    var userData = await _database.rawQuery(
        "SELECT * FROM ${DBConstants.TABLE_USER} WHERE ${DBConstants.FIELD_EMAIL} = ? ",
        [authToken]);
    if (userData.length > 0) {
      return UserModel.fromJson(userData[0]);
    }
    return null;
  }

  /// Removing user profile information from the database
  void logout() {
    _database.rawQuery("DELETE FROM ${DBConstants.TABLE_USER}");
  }

  Future<bool> registerUser(String email, String password) async {
    print("register User");
    print(email);
    print(password);

    List<Map> maps = await _database.query(DBConstants.TABLE_USER,
        columns: [DBConstants.FIELD_EMAIL],
        where: "${DBConstants.FIELD_EMAIL} = ? ",
        whereArgs: [email]);
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      return false;
    } else {
      return true;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    print("login User");
    print(email);
    print(password);

    List<Map> maps = await _database.query(DBConstants.TABLE_USER,
        columns: [DBConstants.FIELD_EMAIL, DBConstants.FILED_PASSWORD],
        where:
            "${DBConstants.FIELD_EMAIL} = ? and ${DBConstants.FILED_PASSWORD} = ?",
        whereArgs: [email, password]);
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      return true;
    } else {
      return false;
    }
  }
}
