// Importing necessary packages and files
import 'dart:async'; // Dart package for asynchronous programming
import 'package:flutter/material.dart'; // Flutter package for building UI
import 'package:flutter_bloc/flutter_bloc.dart'; // Flutter package for implementing BLoC architecture
import 'package:jumper/logic/cubits/user_cubit/user_state.dart'; // Importing UserState class for defining user-related states
import '../../../../logic/cubits/user_cubit/user_cubits.dart'; // Importing UserCubit class for managing user-related state and business logic

class Signupprovider with ChangeNotifier {
  final BuildContext context;
  Signupprovider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription = BlocProvider.of<ProductCubit>(context).stream.listen(
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
          isLoading = false;
          error = "";
          notifyListeners();
        }
      },
    );
  }

  // Method to initiate the login process
  void createAccount() async {
    if (!formkey.currentState!.validate()) return;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    BlocProvider.of<ProductCubit>(context)
        .createAccount(email: email, password: password);
  }

  // Method to clean up resources when the provider is disposed
  @override
  void dispose() {
    _userSubscription
        ?.cancel(); // Cancelling subscription to user state changes
    super.dispose(); // Calling super class dispose method
  }
}
