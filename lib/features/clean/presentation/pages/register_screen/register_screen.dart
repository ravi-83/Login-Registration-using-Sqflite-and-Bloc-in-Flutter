import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_registration_app/core/config/navigation.dart';
import 'package:login_registration_app/core/utils/constants.dart';
import 'package:login_registration_app/core/utils/routes.dart';
import 'package:login_registration_app/core/widgets/rounded_button_widget.dart';
import 'package:login_registration_app/core/widgets/text_form_field_widget.dart';
import 'package:login_registration_app/features/clean/presentation/pages/register_screen/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameText = TextEditingController();
  TextEditingController _emailText = TextEditingController();
  TextEditingController _passwordText = TextEditingController();
  TextEditingController _conformationPass = TextEditingController();

  String name;
  String email;
  String password;
  String conformPass;

  final _key = GlobalKey<FormState>();
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Double press to back', gravity: ToastGravity.CENTER);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoadingState) {
            } else if (state is RegisterLoadedState) {
              if (state.isRegistered !=null && state.isRegistered) {
                BlocProvider.of<RegisterBloc>(context).add(
                  StoreAuthTokenEvent(authToken: _emailText.text),
                );
              } else if (state.isAuthTokenStored !=null && state.isAuthTokenStored) {
                Navigation.intentWithClearAllRoutes(context, AppRoute.home);
              }
            } else if (state is ShouldRegisterState) {
              if (state.shouldRegister) {
                BlocProvider.of<RegisterBloc>(context).add(
                  RegisterUserEvent(
                    name: _nameText.text,
                    email: _emailText.text,
                    password: _passwordText.text,
                  ),
                );
              }else if (!state.shouldRegister) {
                Fluttertoast.showToast(
                    msg: "Invalid Credential !!",
                    gravity: ToastGravity.CENTER,
                    backgroundColor: AppColors.vd_dark_accent_border);
              }
            }
          },
          builder: (context, state) {
            return _getBody();
          },
        ));
  }

  _getBody() {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getHelloText(),
              _getLoginText(),
              SizedBox(
                height: 20,
              ),
              _containerForm(),
              Center(
                  child: RoundedButton(
                      onPressed: () => _handleRegister(),
                      buttonName: 'Sign Up',
                      colour: Colors.lightGreen)),
              SizedBox(
                height: 20,
              ),
              _alreadyHaveAnAccount(),
            ],
          )),
    );
  }

  _handleRegister() {
    if (_key.currentState.validate()) {
      BlocProvider.of<RegisterBloc>(context).add(CheckUserIsRegisteredEvent(
          email: _emailText.text, password: _passwordText.text));
    }
  }

  _getHelloText() {
    return Text(
      'Hello!',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 40,
      ),
    );
  }

  _getLoginText() {
    return Text(
      'Please create an account to continue',
      style: TextStyle(color: Colors.black54),
    );
  }

  _containerForm() {
    return Material(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        margin: EdgeInsets.all(20),
        width: double.infinity,
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '  Full Name',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormFieldWidget(
                controller: _nameText,
                callBack: (value) {
                  if (value.isNotEmpty) {
                    return null;
                  }
                  return "Field cannot be empty";
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '  Email',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormFieldWidget(
                controller: _emailText,
                hintText: 'you@example.com',
                callBack: (value) {
                  if (!value.contains('@')) {
                    return 'Please enter valid email';
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
                controller: _passwordText,
                callBack: (value) {
                  if (value.length < 5) {
                    return 'weak password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '  Conform password',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormFieldWidget(
                controller: _conformationPass,
                callBack: (value) {
                  if (value != _passwordText.text) {
                    return 'Match the password properly';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _alreadyHaveAnAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account ? ',
          style: TextStyle(
              color: Colors.black45, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          onTap: () {
            Navigation.intentWithClearAllRoutes(context, AppRoute.login);
          },
        ),
      ],
    );
  }
}
