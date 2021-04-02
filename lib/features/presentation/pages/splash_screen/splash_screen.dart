import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:login_registration_app/core/config/navigation.dart';
import 'package:login_registration_app/core/utils/routes.dart';
import 'package:login_registration_app/features/presentation/authentication/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Authenticated) {
              if (state.isLoggedIn) {
                  Navigation.intentWithClearAllRoutes(context, AppRoute.home);
              } else {
                Navigation.intentWithClearAllRoutes(context, AppRoute.login);
              }
            } else if (state is Unauthenticated) {
              Navigation.intentWithClearAllRoutes(context, AppRoute.login);
            }
          },
          builder: (context, state) {
            return _getBody();
          },
        ),
      ),
    );
  }

  Widget _getBody() {
    final paint = Paint();
    paint.color = Colors.amber;
    return Container(
      // color: AppColors.dark_grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash.jpeg"),
              fit: BoxFit.fill
          ),
          color: Colors.grey[800],
      ),
      // padding: EdgeInsets.only(left: 20),
      child: ShowUpAnimationWidget(
        delay: 500,
        child: RichText(
          text:TextSpan(
            text: "Login &",
            style: TextStyle(
              fontSize: 48,

          ),
            children: <TextSpan>[
              TextSpan(
                  text: "Register",
                  style: TextStyle(
                      fontSize: 48, color: Colors.black, backgroundColor: Colors.white)),
            ],
          ),
        ),
        callBack: () {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(IsUserLoggedIn());
        },
      ),
    );
  }

  void dispose() {
    super.dispose();
  }
}



class ShowUpAnimationWidget extends StatefulWidget {
  final Widget child;
  final int delay;
  final Function callBack;

  ShowUpAnimationWidget({@required this.child, this.delay, this.callBack});

  @override
  _ShowUpAnimationWidgetState createState() => _ShowUpAnimationWidgetState();
}

class _ShowUpAnimationWidgetState extends State<ShowUpAnimationWidget> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500),);
    final curve =
    CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);
    if(widget.callBack != null) {
      _animController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.callBack();
        }
      });
    }
    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}