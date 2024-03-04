// Importing necessary packages and files
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/product_cubit/product_cubits.dart';
import 'package:jumper/presentation/screens/auth/add_product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes.dart';
import 'logic/cubits/category_cubit/category_cubits.dart';
import 'logic/cubits/user_cubit/user_cubits.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences instance = await SharedPreferences.getInstance();
  instance.clear();
  Bloc.observer = MyBlocObserver();
  runApp(const Jumper());
}

// Main Jumper app widget
class Jumper extends StatelessWidget {
  const Jumper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Providing multiple BLoC instances at the root of the widget tree
      providers: [
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
      ],
      child: const MaterialApp(
        // Root widget of the application
        debugShowCheckedModeBanner:
            false, // Disabling debug banner in release mode
        onGenerateRoute:
            Routes.onGenerateRoute, // Generating routes using the Routes class
        initialRoute: AddProductScreen
            .routeName, // Setting initial route to the LoginScreen
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
