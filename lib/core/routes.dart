// Importing necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:jumper/presentation/screens/auth/admin_screen.dart';
import 'package:jumper/presentation/screens/auth/home/home_screen.dart';
import 'package:jumper/presentation/screens/auth/providers/add_product_providers.dart';
import 'package:jumper/presentation/screens/auth/providers/login_providers.dart';
import 'package:jumper/presentation/screens/auth/providers/signup_provider.dart';
import 'package:provider/provider.dart';
import 'package:jumper/presentation/screens/auth/login_screen.dart';
import 'package:jumper/presentation/screens/auth/signup_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Route for the login screen
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => AddProductProvider(context),
            child: const LoginScreen(),
          ),
        );

      // Route for the sign-up screen
      case SignUpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => Signupprovider(context),
            child: const SignUpScreen(),
          ),
        );

      // Route for the Home screen
      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );

      // Route for the Admin screen
      case AdminScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => AddProductProvider(context),
            child: const AdminScreen(),
          ),
        );

      // Route for the Splash screen
      case AdminScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const AdminScreen(),
        );
      default:
        return null;
    }
  }
}
