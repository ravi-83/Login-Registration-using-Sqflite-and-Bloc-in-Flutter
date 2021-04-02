import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_registration_app/core/config/navigation.dart';
import 'package:login_registration_app/core/utils/constants.dart';
import 'package:login_registration_app/core/utils/routes.dart';
import 'package:login_registration_app/core/widgets/rounded_button_widget.dart';
import 'package:login_registration_app/core/widgets/text_form_field_widget.dart';
import 'package:login_registration_app/features/presentation/pages/login_screen/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //final _auth = FirebaseAuth.instance;
  final _key = GlobalKey<FormState>();

  String email;
  String password;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadedState) {
            print("hello");
            if (state.isLoggedIn != null) {
              print("hello");
              if (state.isLoggedIn == true) {
                BlocProvider.of<LoginBloc>(context).add(
                  StoreAuthTokenEvent(authToken: _emailController.text),
                );
              } else {
                Fluttertoast.showToast(
                    msg: "Invalid Credential !!",
                    gravity: ToastGravity.CENTER,
                    backgroundColor: AppColors.vd_dark_accent_border);
                _doClearControllerText();
              }
            } else if (state.isAuthTokenStored != null &&
                state.isAuthTokenStored) {
              Navigation.intentWithClearAllRoutes(context, AppRoute.home);
            }
          }
        },
        builder: (context, state) {
          return _getBody();
        },
      ),
    );
  }

  _getBody() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
              ),
            ),
            Text(
              'Please sign in to continue',
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(
              height: 20,
            ),
            _containerForm(),
            SizedBox(
              height: 20,
            ),
            Center(
              child: RoundedButton(
                onPressed: () => _handleLogin(),
                buttonName: 'Sign In',
                colour: Colors.lightGreen,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _firstTimeHereTextAndButton(),
          ],
        ),
      ),
    );
  }

  _handleLogin() {
    if (_key.currentState.validate()) {
      BlocProvider.of<LoginBloc>(context).add(
        LoginUserEvent(
            email: _emailController.text, password: _passwordController.text),
      );
    }
  }

  _containerForm() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        margin: EdgeInsets.all(20),
        width: double.infinity,
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '  Email',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormFieldWidget(
                hintText: 'you@example.com',
                controller: _emailController,
                callBack: (value) {
                  if (!value.contains('@')) {
                    return 'Enter a Valid Email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '  Password',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormFieldWidget(
                obscureText: true,
                controller: _passwordController,
                callBack: (value) {
                  if (value.length < 5) {
                    return 'weak password';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _firstTimeHereTextAndButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account yet? ',
          style: TextStyle(
              color: Colors.black45, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          onTap: () {
            Navigation.intentWithClearAllRoutes(context, AppRoute.register);
          },
        ),
      ],
    );
  }

  _doClearControllerText() {
    _passwordController.clear();
    _emailController.clear();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
