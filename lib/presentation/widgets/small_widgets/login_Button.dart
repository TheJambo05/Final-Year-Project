import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? onPressed;

  const LoginButton(
      {super.key, required this.text, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 40,
        width: 300,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
