// Importing necessary packages and files
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../logic/cubits/user_cubit/user_cubits.dart';

// Class responsible for providing login functionality and managing state
class LoginProvider with ChangeNotifier {
  final BuildContext context;
  LoginProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";
  late SharedPreferences prefs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  // Method to listen to changes in the UserCubit
  void _listenToUserCubit() {
    _userSubscription = BlocProvider.of<UserCubit>(context).stream.listen(
      (userState) {
        if (userState is UserLoadingState) {
          isLoading = true;
          error = "";
          notifyListeners();
        } else if (userState is UserErrorState) {
          isLoading = false;
          error = userState.message;
          notifyListeners();
        } else {
          isLoading = false;
          error = "";
          notifyListeners();
        }
      },
    );
  }

  void logIn() async {
    if (!formkey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    BlocProvider.of<UserCubit>(context)
        .signIn(email: email, password: password);
  }

  // Method to clean up resources when the provider is disposed
  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
