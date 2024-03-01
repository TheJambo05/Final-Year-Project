import 'package:flutter/material.dart';
import 'package:jumper/presentation/widgets/primary_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("Jumper"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                  // height: MediaQuery.of(context).size.height * 0.32,
                ),
                Image.asset(
                  "assets/Sneaker.png",
                  width: 215,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                PrimaryTextField(
                    controller: emailController, labelText: "Email address"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                PrimaryTextField(
                  controller: passwordController,
                  labelText: "Password",
                  obscureText: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 40,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register now.",
                        style: TextStyle(color: Colors.purple, fontSize: 15),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
