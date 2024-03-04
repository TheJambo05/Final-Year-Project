// Importing necessary packages and files
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import '../../../../logic/cubits/user_cubit/user_cubits.dart';

// Class responsible for providing login functionality and managing state
class LoginProvider with ChangeNotifier {
  final BuildContext context;
  LoginProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey =
      GlobalKey<FormState>(); // GlobalKey for accessing the form state
  StreamSubscription? _userSubscription; // Subscription to user state changes

  // Method to listen to changes in the UserCubit
  void _listenToUserCubit() {
    _userSubscription = BlocProvider.of<UserCubit>(context).stream.listen(
      (userState) {
        if (userState is UserLoadingState) {
          isLoading = true; // Setting isLoading to true during loading state
          error = ""; // Clearing any previous error message
          notifyListeners(); // Notifying listeners of state change
        } else if (userState is UserErrorState) {
          isLoading = false; // Setting isLoading to false
          error =
              userState.message; // Setting error message received from state
          notifyListeners(); // Notifying listeners of state change
        } else {
          isLoading = false; // Setting isLoading to false
          error = ""; // Clearing any previous error message
          notifyListeners(); // Notifying listeners of state change
        }
      },
    );
  }

  // Method to initiate the login process
  void logIn() async {
    if (!formkey.currentState!.validate()) return;

    String email =
        emailController.text.trim(); // Extracting email from text field
    String password =
        passwordController.text.trim(); // Extracting password from text field
    BlocProvider.of<UserCubit>(
            context) // Accessing UserCubit instance and calling signIn method
        .signIn(
            email: email,
            password:
                password); // Initiating sign-in process with provided email and password
  }

  // Method to clean up resources when the provider is disposed
  @override
  void dispose() {
    _userSubscription
        ?.cancel(); // Cancelling subscription to user state changes
    super.dispose(); // Calling super class dispose method
  }
}
