import 'package:get_it/get_it.dart';
import 'package:login_registration_app/features/clean/presentation/authentication/authentication_bloc.dart';
import 'package:login_registration_app/features/clean/presentation/pages/login_screen/login_bloc.dart';
import 'package:login_registration_app/features/clean/presentation/pages/register_screen/register_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/db_provider.dart';
import 'core/config/my_shared_pref.dart';
import 'features/clean/data/datasources/local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthenticationBloc(localDataSource: sl()));
  sl.registerFactory(() => RegisterBloc(localDataSource: sl()));
  sl.registerFactory(() => LoginBloc(localDataSource: sl()));

  // No access to DB provider, job of LocalDataSource to choose which source
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(mySharedPref: sl(), dbProvider: sl()));

  sl.registerLazySingleton<MySharedPref>(() => MySharedPref(sl()));

  // External
  final dbProvider = DBProvider();
  await dbProvider.getInstance();

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<DBProvider>(() => dbProvider);
}
