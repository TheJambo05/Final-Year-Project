// Importing necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/models/category/category_model.dart';
import 'package:jumper/data/models/product/product_model.dart';
import 'package:jumper/logic/cubits/category_product_cubit/category_product_cubit.dart';
import 'package:jumper/presentation/screens/auth/products/category_product_screen.dart';
import 'package:jumper/presentation/screens/auth/products/product_details_screen.dart';
import 'package:provider/provider.dart';
import '../presentation/screens/auth/add_product_screen.dart';
import '../presentation/screens/auth/cart/cart_screen.dart';
import '../presentation/screens/auth/home/home_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/auth/providers/add_product_provider.dart';
import '../presentation/screens/auth/providers/login_providers.dart';
import '../presentation/screens/auth/providers/signup_provider.dart';
import '../presentation/screens/auth/splash/splash_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Route for the login screen
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => LoginProvider(context),
            child: const LoginScreen(),
          ),
        );

      // Route for the sign-up screen
      case SignUpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SignUpProvider(context),
            child: const SignUpScreen(),
          ),
        );

      // Route for the AddProduct screen
      case AddProductScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AddProductProvider(context),
              child: const AddProductScreen()),
        );

      // Route for the Home screen
      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AddProductProvider(context),
              child: const HomeScreen()),
        );

      // Route for the Splash screen
      // case SplashScreen.routeName:
      //   return CupertinoPageRoute(
      //     builder: (context) => const SplashScreen(),
      //   );

      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ProductDetailsScreen(
            productModel: settings.arguments as ProductModel,
          ),
        );

      case CartScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const CartScreen(),
        );

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                CategoryProductCubit(settings.arguments as CategoryModel),
            child: const CategoryProductScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
