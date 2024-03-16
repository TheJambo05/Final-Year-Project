// Importing necessary packages and files
import 'package:email_validator/email_validator.dart'; // Package for email validation
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubits.dart';
import 'package:jumper/presentation/screens/auth/home/home_screen.dart';
import 'package:jumper/presentation/screens/auth/providers/login_providers.dart';
import 'package:jumper/presentation/screens/auth/signup_screen.dart';
import 'package:jumper/presentation/screens/auth/splash/splash_screen.dart';
import 'package:jumper/presentation/widgets/small_widgets/login_Button.dart';
import 'package:jumper/presentation/widgets/small_widgets/primary_Button2.dart';
import 'package:jumper/presentation/widgets/small_widgets/primary_textfield.dart';
import 'package:provider/provider.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';
import '../../widgets/small_widgets/primary_button.dart';

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
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        body: Form(
          key: provider.formkey, // Using form key for form validation
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  // Title of the app
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
                  SizedBox(
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

                  PrimaryButton(
                    // Button for forgot password
                    onPressed: () {},
                    text: "Forgot Password",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
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
                          Navigator.pushNamed(context, SignUpScreen.routeName);
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
    );
  }
}
