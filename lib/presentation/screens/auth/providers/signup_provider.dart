import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import '../../../../logic/cubits/user_cubit/user_cubits.dart';

class SignUpProvider with ChangeNotifier {
  final BuildContext context;
  SignUpProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final fullNameController =
      TextEditingController(); // New controller for full name
  final phoneNumberController =
      TextEditingController(); // New controller for phone number
  final addressController =
      TextEditingController(); // New controller for address
  final cityController = TextEditingController(); // New controller for city
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

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

  void createAccount() async {
    if (!formKey.currentState!.validate()) return;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String fullName =
        fullNameController.text.trim(); // Retrieve full name from controller
    String phoneNumber = phoneNumberController.text
        .trim(); // Retrieve phone number from controller
    String address =
        addressController.text.trim(); // Retrieve address from controller
    String city = cityController.text.trim(); // Retrieve city from controller
    BlocProvider.of<UserCubit>(context).createAccount(
      email: email,
      password: password,
      fullName: fullName, // Pass full name to createAccount method
      phoneNumber: phoneNumber, // Pass phone number to createAccount method
      address: address, // Pass address to createAccount method
      city: city, // Pass city to createAccount method
    );
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
