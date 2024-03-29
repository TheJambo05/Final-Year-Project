// Importing necessary packages and files
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/add_Product_cubit.dart/add_product_cubit.dart';
import 'package:jumper/logic/cubits/product_cubit/product_cubits.dart';
import 'package:jumper/presentation/screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes.dart';
import 'logic/cubits/category_cubit/category_cubits.dart';
import 'logic/cubits/user_cubit/user_cubits.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // preferences wala code
  // SharedPreferences instance = await SharedPreferences.getInstance();
  // instance
  //     .clear(); // Remove this line if you don't want to clear SharedPreferences on app start
  Bloc.observer = MyBlocObserver();
  runApp(const Jumper());
}

class Jumper extends StatelessWidget {
  const Jumper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        // BlocProvider(
        //   create: (context) => AddProductCubit(),
        // ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: LoginScreen.routeName,
      ),
    );
  }
}

// Custom observer for monitoring BLoC events
class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $Change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Transition in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
