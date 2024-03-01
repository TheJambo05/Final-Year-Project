import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:jumper/presentation/screens/auth/login_screen.dart';
import 'package:jumper/presentation/screens/auth/signup_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (context) => LoginScreen());

      case SignUpScreen.routeName:
        return CupertinoPageRoute(builder: (context) => SignUpScreen());

      default:
        return null;
    }
  }
}
