// Importing necessary packages and files
import 'package:email_validator/email_validator.dart'; // Package for email validation
import 'package:flutter/material.dart'; // Flutter package for building UI
import 'package:flutter_bloc/flutter_bloc.dart'; // Flutter package for implementing BLoC architecture
import 'package:jumper/logic/cubits/user_cubit/user_cubits.dart'; // Importing UserCubit class for managing user-related state and business logic
import 'package:jumper/presentation/screens/auth/home/home_screen.dart';
import 'package:jumper/presentation/screens/auth/providers/login_providers.dart'; // Importing LoginProvider class for managing login functionality
import 'package:jumper/presentation/screens/auth/signup_screen.dart';
import 'package:jumper/presentation/screens/auth/splash/splash_screen.dart';
import 'package:jumper/presentation/widgets/login_Button.dart'; // Importing custom LoginButton widget
import 'package:jumper/presentation/widgets/primary_Button.dart'; // Importing custom PrimaryButton widget
import 'package:jumper/presentation/widgets/primary_Button2.dart'; // Importing custom PrimaryButton2 widget
import 'package:jumper/presentation/widgets/primary_textfield.dart'; // Importing custom PrimaryTextField widget
import 'package:provider/provider.dart';
import '../../../logic/cubits/user_cubit/user_state.dart'; // Importing UserState class for defining user-related states

// Class representing the login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key})
      : super(key: key); // Corrected the key parameter

  static const String routeName = "login"; // Route name for the login screen

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return BlocListener<UserCubit, UserState>(
      // Listening to state changes in UserCubit
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: provider.formkey, // Using form key for form validation
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    const Text("Jumper"), // Title of the app
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                    ),
                    Image.asset(
                      "assets/Sneaker.png", // Image asset for the logo
                      width: 215,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    (provider.error != "") // Displaying error message if any
                        ? Row(
                            children: [
                              Text(
                                provider.error,
                              ),
                            ],
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                    PrimaryTextField(
                      // Text field for email input
                      controller: provider.emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email address is required";
                        }

                        if (!EmailValidator.validate(value.trim())) {
                          return "Invalid email address";
                        }
                        return null;
                      },
                      labelText: "Email address",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    PrimaryTextField(
                      // Text field for password input
                      controller: provider.passwordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      labelText: "Password",
                      obscureText: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    LoginButton(
                      // Button for login action
                      onPressed: provider.logIn,
                      text: (provider.isLoading) ? "..." : "Login",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    PrimaryButton(
                      // Button for forgot password
                      onPressed: () {},
                      text: "Forgot Password",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                    ),
                    Row(
                      // Row for navigation to sign up screen
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 14),
                        ),
                        PrimaryButton2(
                          // Button for navigation to sign up screen
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SignUpScreen.routeName);
                          },
                          text: "Register now",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
