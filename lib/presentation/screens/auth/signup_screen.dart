import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jumper/presentation/screens/auth/login_screen.dart';
import 'package:jumper/presentation/screens/auth/providers/signup_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/login_Button.dart';
import '../../widgets/primary_Button2.dart';
import '../../widgets/primary_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = "signUp";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpprovider>(context);
    return Scaffold(
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
                  const Row(
                    children: [
                      Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
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
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  PrimaryTextField(
                    // Text field for password input
                    controller: provider.cPasswordController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Confirm is required";
                      }
                      if (value.trim() !=
                          provider.passwordController.text.trim()) {
                        return "Password do not match";
                      }
                      return null;
                    },
                    labelText: "Confirm Password",
                    obscureText: true,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  LoginButton(
                    // Button for login action
                    onPressed: provider.createAccount,
                    text: (provider.isLoading) ? "..." : "Create Account",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                  Row(
                    // Row for navigation to sign up screen
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 14),
                      ),
                      PrimaryButton2(
                        // Button for navigation to sign up screen
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        text: "log In",
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
