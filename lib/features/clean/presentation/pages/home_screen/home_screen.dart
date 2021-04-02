import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_app/core/config/navigation.dart';
import 'package:login_registration_app/core/utils/constants.dart';
import 'package:login_registration_app/core/utils/routes.dart';
import 'package:login_registration_app/core/widgets/rounded_button_widget.dart';
import 'package:login_registration_app/features/clean/data/models/user_model.dart';
import 'package:login_registration_app/features/clean/presentation/authentication/authentication_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is UserInfoLoadedState) {
            if (state.authToken != null && state.authToken.isNotEmpty) {
              BlocProvider.of<AuthenticationBloc>(context).add(
                GetUserInfoEvent(authToken: state.authToken),
              );
            } else if (state.userModel != null) {
              userModel = state.userModel;
            }
          } else if (state is Unauthenticated) {
            Navigation.intentWithClearAllRoutes(context, AppRoute.login);
          }
        },
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(GetAuthTokenEvent());
          }
          return _getBody();
        },
      ),
    );
  }

  _getBody() {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.dark_grey_80,
          centerTitle: true,
          title: Text(
            userModel!=null ? "Hi, ${userModel.name}" : "Hi, User",
            style: TextStyle(
              fontSize: 20,
            ),
          )
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(left: 50,right: 50),
              child: RoundedButton(
                colour: Colors.lightGreen,
                buttonName: "Logout",
                onPressed: _handleLogOut,
              ),
            ),
          )
        ],
      ),
    );
  }

  _handleLogOut() {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
  }
}
