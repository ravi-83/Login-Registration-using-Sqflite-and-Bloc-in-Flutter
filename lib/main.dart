import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/core/utils/routes.dart';
import 'package:login_registration_app/features/presentation/authentication/authentication_bloc.dart';
import 'package:login_registration_app/features/presentation/pages/home_screen/home_screen.dart';
import 'package:login_registration_app/features/presentation/pages/login_screen/login_screen.dart';
import 'package:login_registration_app/features/presentation/pages/register_screen/register_bloc.dart';
import 'package:login_registration_app/features/presentation/pages/register_screen/register_screen.dart';
import 'package:login_registration_app/features/presentation/pages/splash_screen/splash_screen.dart';
import 'package:login_registration_app/injection_container.dart';
import 'core/utils/constants.dart';
import 'features/presentation/pages/login_screen/login_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode

  SystemChrome.setSystemUIOverlayStyle(Constants.SYSTEM_UI_OVERLAY_STYLE);
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => sl.get<AuthenticationBloc>()..add(AppStarted()),
      child: MaterialApp(
        title: 'Login & Registration',
        locale: Locale('en'),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoute.splash,
        routes: _registerRoutes(),
      ),
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      AppRoute.splash: (context) => BlocProvider(
            create: (context) => sl<AuthenticationBloc>(),
            child: SplashScreen(),
          ),
      AppRoute.login: (context) => BlocProvider(
            create: (context) => sl<LoginBloc>(),
            child: LoginScreen(),
          ),
      AppRoute.register: (context) => BlocProvider(
            create: (context) => sl<RegisterBloc>(),
            child: RegisterScreen(),
          ),
      AppRoute.home: (context) => BlocProvider(
            create: (context) => sl<AuthenticationBloc>(),
            child: HomeScreen(),
          ),
    };
  }
}
